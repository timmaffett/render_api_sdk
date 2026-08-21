import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;
import '../design/adaptive_scheme.dart';

/// The one place loading, error and empty states are rendered.
///
/// Every page loads a list from Render and every page can fail the same four
/// ways, so none of them reimplements this. The error path is the interesting
/// one: [RenderApiException.hint] exists because Render's status codes are
/// sometimes misleading — a 500 for an unknown task run id, a 400 for a metric
/// the plan does not include — so when there is a hint it is shown as
/// prominently as the message.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    super.key,
    required this.future,
    required this.builder,
    this.emptyMessage = 'Nothing here.',
    this.onUnauthorized,
    this.onRetry,
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T value) builder;
  final String emptyMessage;

  /// Called when Render rejects the token, so the app can sign out rather than
  /// showing an error the user cannot act on.
  final VoidCallback? onUnauthorized;

  /// Runs the load again. Offered on the error panel, because the failure a
  /// user hits most often here is a rate limit, which clears by itself.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final error = snapshot.error;
        if (error != null) {
          if (error is render.RenderAuthException) {
            // Fires after this frame: signing out rebuilds the tree, and doing
            // that during a build is an error.
            final callback = onUnauthorized;
            if (callback != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => callback());
            }
          }
          return _ErrorPanel(error: error, onRetry: onRetry);
        }

        final value = snapshot.data as T;
        if (value is List && value.isEmpty) {
          return _Empty(message: emptyMessage);
        }
        return builder(context, value);
      },
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    final text = Theme.of(context).textTheme;

    final (message, hint) = switch (error) {
      render.RenderApiException e => (e.message, e.hint),
      render.RenderException e => (e.message, e.hint),
      _ => (error.toString(), null),
    };

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REQUEST FAILED',
                style: text.labelLarge?.copyWith(
                  color: scheme.danger,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              SelectableText(message, style: text.bodyMedium),
              if (hint != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.inset,
                    border: Border(
                      left: BorderSide(color: scheme.accent, width: 2),
                    ),
                  ),
                  // Verbatim: the hints exist because the status code alone is
                  // misleading, and paraphrasing one loses the actionable part.
                  child: SelectableText(
                    hint,
                    style: text.bodySmall?.copyWith(color: scheme.textMid),
                  ),
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: onRetry,
                  child: const Text('TRY AGAIN'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: scheme.textDim),
      ),
    );
  }
}
