import 'package:flutter/material.dart';

import '../data/response_cache.dart';
import 'async_view.dart';
import 'data_time.dart';
import 'refresh_scope.dart';
import '../design/adaptive_scheme.dart';

/// Starts a load once, and offers to run it again.
///
/// `FutureBuilder(future: load())` re-invokes the loader on every rebuild —
/// a theme change, a window resize, a parent setState — which is wasteful
/// against any API and actively harmful against Render's Postgres
/// introspection endpoints, where a handful of calls in a row is refused with
/// a 429. Creating the future in `initState` means one call per mount.
///
/// The retry matters for the same reason: a rate limit is temporary, so the
/// failure a user sees most often is one worth offering to repeat.
class LoadOnce<T> extends StatefulWidget {
  const LoadOnce({
    super.key,
    required this.load,
    required this.builder,
    this.emptyMessage = 'Nothing here.',
    this.onUnauthorized,
    this.refresh,
    this.stamp = false,
  });

  final Future<T> Function() load;
  final Widget Function(BuildContext context, T value) builder;
  final String emptyMessage;
  final VoidCallback? onUnauthorized;

  /// Bumped by the refresh button. Every view listening to it reloads, so one
  /// control refreshes whatever is on screen without any page knowing about
  /// the button.
  final Listenable? refresh;

  /// Shows when this view's own data was read.
  ///
  /// Worth it where a page makes several independent requests — the metrics
  /// tab makes seven, and one panel can be live while another is replayed from
  /// cache, which the single indicator in the app bar cannot express. Not worth
  /// it where a whole tab comes from one response and every stamp would read
  /// the same.
  final bool stamp;

  @override
  State<LoadOnce<T>> createState() => _LoadOnceState<T>();
}

class _LoadOnceState<T> extends State<LoadOnce<T>> {
  late Future<T> _future = _start();
  DataAge? _age;

  Future<T> _start() {
    final cache = RefreshScope.maybeOf(context)?.cache;
    if (cache == null || !widget.stamp) return widget.load();
    return cache.observe(widget.load).then((result) {
      final (value, age) = result;
      if (mounted) setState(() => _age = age);
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.refresh?.addListener(_reload);
  }

  @override
  void dispose() {
    widget.refresh?.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    if (mounted) setState(() => _future = _start());
  }

  @override
  Widget build(BuildContext context) {
    final view = AsyncView<T>(
      future: _future,
      emptyMessage: widget.emptyMessage,
      onUnauthorized: widget.onUnauthorized,
      onRetry: () => setState(() => _future = _start()),
      builder: widget.builder,
    );
    final age = _age;
    final at = age?.at;
    if (!widget.stamp || age == null || at == null) return view;

    final scheme = AdaptiveScheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: DataTime(
            at: at,
            prefix: age.fromCache ? 'cached' : 'read',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: age.fromCache ? scheme.secondary : scheme.textDim,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Flexible(child: view),
      ],
    );
  }
}
