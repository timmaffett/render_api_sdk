import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';
import 'adaptive_surface.dart';

/// A titled card with a header strip.
///
/// Auris's header carries corner-bracket ornaments flanking the title, which is
/// its signature and would look like a mistake anywhere else. The flat systems
/// get a plain header and a divider — and [trailing] takes a widget rather than
/// AurisPanel's string, because this app needs a timestamp and a button up
/// there, not a status code.
class AdaptivePanel extends StatelessWidget {
  const AdaptivePanel({
    super.key,
    required this.title,
    required this.child,
    this.code,
    this.trailing,
    this.accent = false,
    this.padding = const EdgeInsets.all(16),
  });

  final String title;
  final Widget child;

  /// A short monospace note in the header's trailing corner.
  final String? code;

  /// Header controls, which Auris's own panel cannot take.
  final Widget? trailing;

  final bool accent;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final system = DesignScope.of(context);
    final scheme = AdaptiveScheme.of(context);

    // Auris's own panel, when nothing extra is needed from the header.
    if (system == AppDesignSystem.auris && trailing == null) {
      return auris_kit.AurisPanel(
        title: title,
        code: code,
        accent: accent,
        padding: padding,
        child: child,
      );
    }

    return AdaptiveSurface(
      borderColor: accent ? scheme.accent : scheme.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: scheme.inset,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: trailing == null ? 16 : 8,
                top: trailing == null ? 11 : 2,
                bottom: trailing == null ? 11 : 2,
              ),
              child: Row(
                children: [
                  if (system == AppDesignSystem.auris) ...[
                    _Tick(color: scheme.accentDim, left: true),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            system == AppDesignSystem.auris
                                ? title.toUpperCase()
                                : title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: system == AppDesignSystem.auris
                                  ? 2
                                  : 0,
                              color: accent ? scheme.accent : scheme.textBright,
                            ),
                          ),
                        ),
                        if (system == AppDesignSystem.auris) ...[
                          const SizedBox(width: 10),
                          _Tick(color: scheme.accentDim, left: false),
                        ],
                      ],
                    ),
                  ),
                  if (code != null)
                    Text(
                      code!,
                      style: TextStyle(fontSize: 11, color: scheme.textMid),
                    ),
                  ?trailing,
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

/// Auris's corner ornament, which is private to that package.
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
