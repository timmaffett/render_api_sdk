import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'env/env.dart';
import 'exceptions.dart';

/// Default base URL for the Render REST API.
const String kRenderBaseUrl = 'https://api.render.com/v1';

/// Default base URL of the CLI's local task server (`render workflows dev`).
const String kRenderLocalDevUrl = 'http://localhost:8120';

const String _userAgent = 'render-api-dart/0.1.0';

/// Low-level transport for the Render REST API.
///
/// Handles authentication, JSON encoding, retries and error translation. The
/// typed endpoint groups in `render_api.dart` sit on top of this; reach for
/// [send] directly only for endpoints this package does not yet model.
class RenderApiClient {
  RenderApiClient({
    String? token,
    String? baseUrl,
    http.Client? httpClient,
    this.maxRetries = 3,
    this.timeout = const Duration(seconds: 30),
  }) : _token = token ?? readEnv('RENDER_API_KEY'),
       baseUrl = _resolveBaseUrl(baseUrl),
       _http = httpClient ?? http.Client(),
       _ownsHttpClient = httpClient == null {
    if (_token == null || _token.isEmpty) {
      throw ArgumentError(
        'No Render API key. Pass token:, or set RENDER_API_KEY in the '
        'environment. On the web there is no environment, so the token must '
        'always be passed explicitly.',
      );
    }
  }

  /// Points at the CLI's local task server instead of Render's API.
  ///
  /// Only task-related endpoints are simulated locally; everything else will
  /// 404. The local server needs no credentials, so [token] is optional.
  factory RenderApiClient.localDev({
    String? url,
    String? token,
    http.Client? httpClient,
  }) => RenderApiClient(
    token: token ?? 'local-dev',
    baseUrl: url ?? readEnv('RENDER_LOCAL_DEV_URL') ?? kRenderLocalDevUrl,
    httpClient: httpClient,
  );

  static String _resolveBaseUrl(String? explicit) {
    if (explicit != null) return _stripTrailingSlash(explicit);
    if (readEnv('RENDER_USE_LOCAL_DEV') == 'true') {
      return _stripTrailingSlash(
        readEnv('RENDER_LOCAL_DEV_URL') ?? kRenderLocalDevUrl,
      );
    }
    return kRenderBaseUrl;
  }

  static String _stripTrailingSlash(String s) =>
      s.endsWith('/') ? s.substring(0, s.length - 1) : s;

  final String? _token;
  final String baseUrl;
  final http.Client _http;
  final bool _ownsHttpClient;

  /// How many times to retry a retryable failure. See [_isRetryable].
  final int maxRetries;

  /// Per-attempt timeout.
  final Duration timeout;

  /// Sends a request and decodes the JSON response.
  ///
  /// Returns null for `204 No Content` and other empty successful responses.
  /// Throws a [RenderApiException] subtype for non-2xx responses, and
  /// [RenderNetworkException] if the request could not be completed.
  Future<Object?> send(
    String method,
    String path, {
    Map<String, Object?>? query,
    Object? body,
  }) async {
    final uri = _uri(path, query);
    final payload = body == null ? null : jsonEncode(body);

    var attempt = 0;
    while (true) {
      try {
        final response = await _sendOnce(method, uri, payload);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (response.body.isEmpty) return null;
          try {
            return jsonDecode(response.body);
          } on FormatException catch (e) {
            throw RenderNetworkException(
              'Render returned a ${response.statusCode} with a body that is '
              'not valid JSON.',
              hint:
                  'Body started with: '
                  '${response.body.substring(0, response.body.length.clamp(0, 120))}',
              cause: e,
            );
          }
        }

        final retryAfter = _retryAfter(response.headers);
        if (_isRetryable(response.statusCode, method) && attempt < maxRetries) {
          await Future<void>.delayed(_backoff(attempt, retryAfter));
          attempt++;
          continue;
        }

        throw exceptionFor(
          statusCode: response.statusCode,
          method: method,
          path: path,
          body: response.body,
          retryAfter: retryAfter,
        );
      } on http.ClientException catch (e) {
        if (attempt < maxRetries) {
          await Future<void>.delayed(_backoff(attempt, null));
          attempt++;
          continue;
        }
        throw RenderNetworkException(
          'Could not reach Render at $uri: ${e.message}',
          cause: e,
        );
      } on TimeoutException catch (e) {
        if (attempt < maxRetries) {
          await Future<void>.delayed(_backoff(attempt, null));
          attempt++;
          continue;
        }
        throw RenderNetworkException(
          'Request to $uri timed out after ${timeout.inSeconds}s.',
          cause: e,
        );
      }
    }
  }

  /// Sends a request expecting a JSON object.
  Future<Map<String, Object?>> sendObject(
    String method,
    String path, {
    Map<String, Object?>? query,
    Object? body,
  }) async {
    final decoded = await send(method, path, query: query, body: body);
    if (decoded is Map<String, Object?>) return decoded;

    throw RenderNetworkException(
      'Expected a JSON object from $method $path but got '
      '${decoded.runtimeType}.',
    );
  }

  /// Sends a request expecting a JSON array.
  Future<List<Object?>> sendList(
    String method,
    String path, {
    Map<String, Object?>? query,
    Object? body,
  }) async {
    final decoded = await send(method, path, query: query, body: body);
    if (decoded is List<Object?>) return decoded;
    if (decoded == null) return const [];
    throw RenderNetworkException(
      'Expected a JSON array from $method $path but got '
      '${decoded.runtimeType}.',
    );
  }

  /// Headers for an authenticated request, for callers hand-rolling a request
  /// this package does not model — streaming endpoints, for instance.
  Map<String, String> authHeaders({String accept = 'application/json'}) => {
    'Authorization': 'Bearer $_token',
    'Accept': accept,
    'User-Agent': _userAgent,
  };

  Future<http.Response> _sendOnce(String method, Uri uri, String? payload) {
    final request = http.Request(method, uri)
      ..headers.addAll({
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
        'User-Agent': _userAgent,
        if (payload != null) 'Content-Type': 'application/json',
      });
    if (payload != null) request.body = payload;

    return _http.send(request).then(http.Response.fromStream).timeout(timeout);
  }

  Uri _uri(String path, Map<String, Object?>? query) {
    final base = Uri.parse('$baseUrl$path');
    if (query == null || query.isEmpty) return base;

    // Render repeats keys for multi-value filters (?workflowId=a&workflowId=b).
    final params = <String, List<String>>{};
    query.forEach((key, value) {
      if (value == null) return;
      if (value is Iterable) {
        final values = value.map((v) => '$v').toList();
        if (values.isNotEmpty) params[key] = values;
      } else {
        params[key] = ['$value'];
      }
    });

    return base.replace(
      queryParameters: {...base.queryParametersAll, ...params},
    );
  }

  /// Whether a failed response is worth retrying.
  ///
  /// 429 is always safe — nothing was processed. 5xx is only retried for
  /// idempotent methods: a POST that fails with 5xx may still have taken
  /// effect, and retrying could create duplicates.
  ///
  /// Note that Render returns 500 for at least one *non*-transient condition
  /// (a workflow whose repository it cannot read), so retrying 5xx is a
  /// convenience, not a cure — see [hintFor].
  bool _isRetryable(int statusCode, String method) {
    if (statusCode == 429) return true;
    if (statusCode < 500) return false;
    return method == 'GET' || method == 'HEAD' || method == 'DELETE';
  }

  Duration _backoff(int attempt, Duration? retryAfter) {
    if (retryAfter != null) return retryAfter;
    return Duration(milliseconds: 250 * (1 << attempt));
  }

  Duration? _retryAfter(Map<String, String> headers) {
    final raw = headers['retry-after'];
    if (raw == null) return null;
    final seconds = int.tryParse(raw.trim());
    if (seconds != null) return Duration(seconds: seconds);
    final date = DateTime.tryParse(raw.trim());
    if (date == null) return null;
    final delta = date.difference(DateTime.now());
    return delta.isNegative ? Duration.zero : delta;
  }

  /// Releases the underlying HTTP client, if this instance created it.
  void close() {
    if (_ownsHttpClient) _http.close();
  }
}
