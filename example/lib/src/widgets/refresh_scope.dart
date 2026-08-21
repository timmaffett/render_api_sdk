import 'package:flutter/material.dart';

import '../data/response_cache.dart';
import 'data_time.dart';
import '../design/adaptive_scheme.dart';

/// A bare notifier: the refresh button pokes it, every view listens.
class RefreshSignal extends ChangeNotifier {
  /// Reloads everything currently on screen.
  void fire() => notifyListeners();
}

/// Carries the refresh signal down the tree.
///
/// Must sit *above* the `MaterialApp`, not inside its `home:`. Below the
/// Navigator a pushed route cannot see it, so every detail page silently
/// loses its refresh button — which is exactly what happened first.
///
/// One button in the app bar bumps a [ChangeNotifier]; every view built with
/// `LoadOnce(refresh: RefreshScope.of(context))` reloads. Pages stay unaware
/// of the button, and the button unaware of the pages.
class RefreshScope extends InheritedWidget {
  const RefreshScope({
    super.key,
    required this.signal,
    required this.cache,
    required super.child,
  });

  final RefreshSignal signal;

  /// Null in tests, which have no cache to report staleness from.
  final ResponseCache? cache;

  static RefreshScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RefreshScope>();

  static Listenable? of(BuildContext context) => maybeOf(context)?.signal;

  @override
  bool updateShouldNotify(RefreshScope old) =>
      signal != old.signal || cache != old.cache;
}

/// The refresh control, and what it has to admit when a refresh fails.
///
/// Render rate limits hard enough that a refresh often cannot get through —
/// one request per minute on the Postgres introspection endpoints. Rather than
/// replace real data with an error, the cache replays the last good response
/// and this says so, with the time it was actually read.
class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = RefreshScope.maybeOf(context);
    if (scope == null) return const SizedBox.shrink();
    final scheme = AdaptiveScheme.of(context);

    return ListenableBuilder(
      listenable: scope.cache ?? scope.signal,
      builder: (context, _) {
        final cache = scope.cache;
        final stale = cache?.servingStale ?? false;
        final since = cache?.staleSince;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (stale)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: since == null
                    ? Text(
                        'CACHED',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: scheme.textDim),
                      )
                    : DataTime(
                        at: since,
                        prefix: 'CACHED',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: scheme.textDim),
                      ),
              ),
            IconButton(
              tooltip: stale
                  ? 'Showing cached data — try Render again'
                  : 'Refresh from Render',
              icon: const Icon(Icons.refresh),
              onPressed: () {
                scope.cache?.beginRefresh();
                scope.signal.fire();
              },
            ),
          ],
        );
      },
    );
  }
}
