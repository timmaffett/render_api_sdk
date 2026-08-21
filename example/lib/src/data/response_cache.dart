import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Keeps the last good response for every GET, and serves it when a fresh one
/// cannot be had.
///
/// Render's Postgres introspection endpoints allow roughly one request per
/// minute and answer `Retry-After: 51`. Without this, opening a tab twice in a
/// row replaces real data with a rate-limit error — the app forgets something
/// it already knew, which is the wrong trade. Cached and stale beats blank and
/// correct.
///
/// It sits at the HTTP layer rather than around the typed loaders, so every
/// endpoint gets it without knowing, and a replayed body decodes through
/// exactly the same path a live one does.
class ResponseCache extends http.BaseClient with ChangeNotifier {
  ResponseCache(this._prefs, {http.Client? inner})
    : _inner = inner ?? http.Client();

  static const _prefix = 'cache.';

  /// Metrics responses run to hundreds of kilobytes. Preferences are the wrong
  /// home for that, so large bodies stay in memory only for this session.
  static const _maxPersistedBytes = 256 * 1024;

  final SharedPreferences _prefs;
  final http.Client _inner;
  final _memory = <String, _Entry>{};

  /// When each request was last answered by Render rather than by this cache.
  final _freshAt = <String, DateTime>{};

  /// True while anything on screen is being shown from cache.
  bool get servingStale => _servingStale;
  bool _servingStale = false;

  /// The oldest reading currently on screen, or null if everything is fresh.
  DateTime? get staleSince => _staleSince;
  DateTime? _staleSince;

  /// Forgets that anything was stale, before a refresh re-establishes it.
  void beginRefresh() {
    _servingStale = false;
    _staleSince = null;
    notifyListeners();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);
    final key = request.url.toString();

    try {
      final response = await http.Response.fromStream(
        await _inner.send(request),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _store(key, response.body);
        _freshAt[key] = DateTime.now();
        return _streamed(response, request);
      }
      final cached = _read(key);
      if (cached == null) return _streamed(response, request);
      _markStale(key);
      // A rate limit is not a reason to forget what we already knew.
      return _streamed(http.Response(cached, 200), request);
    } on Object {
      final cached = _read(key);
      if (cached == null) rethrow;
      _markStale(key);
      return _streamed(http.Response(cached, 200), request);
    }
  }

  void _markStale(String key) {
    _servingStale = true;
    final at = _freshAt[key] ?? _storedAt(key);
    if (at != null && (_staleSince == null || at.isBefore(_staleSince!))) {
      _staleSince = at;
    }
    // Safe to notify directly: this runs when an HTTP response arrives, which
    // is never inside a build.
    notifyListeners();
  }

  http.StreamedResponse _streamed(http.Response r, http.BaseRequest request) =>
      http.StreamedResponse(
        Stream.value(r.bodyBytes),
        r.statusCode,
        contentLength: r.bodyBytes.length,
        request: request,
        headers: r.headers,
        reasonPhrase: r.reasonPhrase,
      );

  void _store(String key, String body) {
    _memory[key] = _Entry(body, DateTime.now());
    if (body.length <= _maxPersistedBytes) {
      _prefs.setString(
        '$_prefix$key',
        jsonEncode({'at': DateTime.now().toIso8601String(), 'body': body}),
      );
    }
  }

  String? _read(String key) {
    final live = _memory[key];
    if (live != null) return live.body;
    final stored = _prefs.getString('$_prefix$key');
    if (stored == null) return null;
    try {
      return (jsonDecode(stored) as Map<String, Object?>)['body'] as String?;
    } on Object {
      return null;
    }
  }

  DateTime? _storedAt(String key) {
    final stored = _prefs.getString('$_prefix$key');
    if (stored == null) return null;
    try {
      final at = (jsonDecode(stored) as Map<String, Object?>)['at'] as String?;
      return at == null ? null : DateTime.tryParse(at);
    } on Object {
      return null;
    }
  }

  /// Drops everything, so the next load has to reach Render.
  Future<void> clear() async {
    _memory.clear();
    _freshAt.clear();
    for (final key in _prefs.getKeys().where((k) => k.startsWith(_prefix))) {
      await _prefs.remove(key);
    }
    _servingStale = false;
    _staleSince = null;
    notifyListeners();
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}

class _Entry {
  const _Entry(this.body, this.at);
  final String body;
  final DateTime at;
}
