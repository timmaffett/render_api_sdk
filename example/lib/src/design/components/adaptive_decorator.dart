import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';

/// Background ornamentation, where the system wants any.
///
/// Auris is a HUD: hex plates and scan brackets are the aesthetic, not
/// decoration on top of it. Fluent and Shadcn are deliberately flat, and Forui
/// more so — adding brackets there would not be a different theme, it would be
/// a mistake.
///
/// So this is the one adapter whose non-Auris branch is simply the child. That
/// is a real answer rather than an unfinished one: an abstraction over design
/// systems has to be able to say "this system does not do that", and returning
/// the child unchanged is how it says it.
class AdaptiveDecorator extends StatelessWidget {
  const AdaptiveDecorator({
    super.key,
    required this.child,
    this.ornament = Ornament.hex,
  });

  final Widget child;
  final Ornament ornament;

  @override
  Widget build(BuildContext context) {
    if (DesignScope.of(context) != AppDesignSystem.auris) return child;

    final scheme = AdaptiveScheme.of(context);
    return switch (ornament) {
      Ornament.hex => Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            width: 160,
            height: 160,
            child: IgnorePointer(
              child: auris_kit.AurisHexOrnament(
                color: scheme.accentDim,
                opacity: 0.3,
              ),
            ),
          ),
          child,
        ],
      ),
      Ornament.brackets => auris_kit.AurisScanBracket(child: child),
    };
  }
}

/// Which piece of Auris furniture to hang on a view.
enum Ornament { hex, brackets }
