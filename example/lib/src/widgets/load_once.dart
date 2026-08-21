import 'package:flutter/material.dart';

import 'async_view.dart';

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
  });

  final Future<T> Function() load;
  final Widget Function(BuildContext context, T value) builder;
  final String emptyMessage;
  final VoidCallback? onUnauthorized;

  /// Bumped by the refresh button. Every view listening to it reloads, so one
  /// control refreshes whatever is on screen without any page knowing about
  /// the button.
  final Listenable? refresh;

  @override
  State<LoadOnce<T>> createState() => _LoadOnceState<T>();
}

class _LoadOnceState<T> extends State<LoadOnce<T>> {
  late Future<T> _future = widget.load();

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
    if (mounted) setState(() => _future = widget.load());
  }

  @override
  Widget build(BuildContext context) => AsyncView<T>(
    future: _future,
    emptyMessage: widget.emptyMessage,
    onUnauthorized: widget.onUnauthorized,
    onRetry: () => setState(() => _future = widget.load()),
    builder: widget.builder,
  );
}
