import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';

/// A bordered panel surface.
///
/// Auris chamfers its corners; the others round them. That difference is the
/// whole of it, which is why [AdaptiveScheme.cornerCut] exists — a surface asks
/// how corners work here rather than which system it is, and only Auris needs
/// its own branch because only Auris has a widget that draws the chamfer.
class AdaptiveSurface extends StatelessWidget {
  const AdaptiveSurface({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.fill,
    this.borderColor,
    this.borderWidth = 1,
    this.width,
    this.height,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? fill;
  final Color? borderColor;
  final double borderWidth;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    final system = DesignScope.of(context);

    if (system == AppDesignSystem.auris) {
      return auris_kit.AurisContainer(
        cut: scheme.cornerCut,
        fill: fill,
        borderColor: borderColor ?? scheme.border,
        borderWidth: borderWidth,
        padding: padding,
        width: width,
        height: height,
        alignment: alignment,
        child: child,
      );
    }

    return Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(
          color: borderColor ?? scheme.border,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
