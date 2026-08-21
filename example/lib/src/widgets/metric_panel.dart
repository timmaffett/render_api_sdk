import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';

import '../data/response_cache.dart';
import 'async_view.dart';
import 'data_time.dart';
import 'refresh_scope.dart';
import '../design/adaptive_scheme.dart';

/// A titled panel whose header carries controls, not just text.
///
/// `AurisPanel` takes a `code` string in the trailing corner and nothing else,
/// so a per-panel timestamp and reload button cannot both live there. This
/// repeats its header treatment — inset strip, corner ticks flanking the title,
/// divider — and gives the trailing end a widget slot.
///
/// The point is vertical space. A metrics tab is four stacked charts; a line of
/// status above each one pushes the last chart off the screen. In the header it
/// costs nothing.
class MetricPanel extends StatelessWidget {
  const MetricPanel({
    super.key,
    required this.title,
    required this.child,
    this.status,
    this.onReload,
    this.padding = const EdgeInsets.all(16),
  });

  final String title;
  final Widget child;

  /// Trailing status — when this panel's data was read.
  final Widget? status;

  /// Reloads this panel alone.
  ///
  /// Worth having beside the global refresh because these panels each own their
  /// request, and Render rate limits per endpoint: refreshing everything can be
  /// refused while refreshing one thing succeeds.
  final VoidCallback? onReload;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);

    return AurisContainer(
      cut: scheme.cornerCut,
      borderColor: scheme.borderStrong,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: scheme.inset,
            child: Padding(
              // Tighter vertically than AurisPanel's 11, because an IconButton
              // is taller than a line of text and would otherwise grow the strip.
              padding: const EdgeInsets.only(
                left: 16,
                right: 8,
                top: 2,
                bottom: 2,
              ),
              child: Row(
                children: [
                  // The title group takes every spare pixel, so the trailing
                  // controls sit hard right. A `Flexible` title beside a
                  // `Spacer` does not: both carry flex 1, so they split the
                  // free space, the title uses only part of its half, and the
                  // remainder lands after the controls and drifts them inward.
                  Expanded(
                    child: Row(
                      children: [
                        _Tick(color: scheme.accentDim, left: true),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            title.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: scheme.textBright,
                                  letterSpacing: 2,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _Tick(color: scheme.accentDim, left: false),
                      ],
                    ),
                  ),
                  ?status,
                  if (onReload != null)
                    IconButton(
                      onPressed: onReload,
                      icon: const Icon(Icons.refresh, size: 16),
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(),
                      tooltip: 'Reload just this',
                      color: scheme.textDim,
                    ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: scheme.border),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// The corner ornament auris flanks a panel title with. Private there, so it
/// is repeated here rather than approximated.
class _Tick extends StatelessWidget {
  const _Tick({required this.color, required this.left});

  final Color color;
  final bool left;

  @override
  Widget build(BuildContext context) {
    final side = BorderSide(color: color, width: 1.5);
    return SizedBox(
      width: 7,
      height: 7,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: side,
            left: left ? side : BorderSide.none,
            right: left ? BorderSide.none : side,
          ),
        ),
      ),
    );
  }
}

/// A [MetricPanel] that owns its own load, stamp and reload.
///
/// Each of these makes its own requests, so each can be fresh or replayed
/// independently — and each can be reloaded on its own, which matters because
/// Render rate limits per endpoint: refreshing the whole screen can be refused
/// while refreshing one panel succeeds.
class LoadedPanel<T> extends StatefulWidget {
  const LoadedPanel({
    super.key,
    required this.title,
    required this.load,
    required this.builder,
  });

  final String title;
  final Future<T> Function() load;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<LoadedPanel<T>> createState() => _LoadedPanelState<T>();
}

class _LoadedPanelState<T> extends State<LoadedPanel<T>> {
  late Future<T> _future = _start();
  DataAge? _age;
  Listenable? _refresh;

  Future<T> _start() {
    final cache = RefreshScope.maybeOf(context)?.cache;
    if (cache == null) return widget.load();
    return cache.observe(widget.load).then((result) {
      final (value, age) = result;
      if (mounted) setState(() => _age = age);
      return value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final signal = RefreshScope.of(context);
    if (signal == _refresh) return;
    _refresh?.removeListener(_reload);
    _refresh = signal?..addListener(_reload);
  }

  @override
  void dispose() {
    _refresh?.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    if (mounted) setState(() => _future = _start());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    final age = _age;
    final at = age?.at;

    return MetricPanel(
      title: widget.title,
      onReload: _reload,
      status: at == null
          ? null
          : DataTime(
              at: at,
              prefix: age!.fromCache ? 'cached' : 'read',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: age.fromCache ? scheme.secondary : scheme.textDim,
              ),
            ),
      child: AsyncView<T>(
        future: _future,
        onRetry: _reload,
        builder: widget.builder,
      ),
    );
  }
}
