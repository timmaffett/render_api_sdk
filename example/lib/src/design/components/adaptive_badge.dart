import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';

/// What a badge is saying, rather than what colour it is.
///
/// The call sites used `AurisBadgeVariant.gold` and `.danger`, which are Auris's
/// words. A shared enum lets them say `good` and `bad` instead, and each system
/// answers in its own palette.
enum AdaptiveBadgeTone { neutral, good, bad, quiet }

class AdaptiveBadge extends StatelessWidget {
  const AdaptiveBadge(
    this.label, {
    super.key,
    this.tone = AdaptiveBadgeTone.neutral,
  });

  final String label;
  final AdaptiveBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);

    if (DesignScope.of(context) == AppDesignSystem.auris &&
        aurisThemeReady(context)) {
      return auris_kit.AurisBadge(
        label,
        variant: switch (tone) {
          AdaptiveBadgeTone.neutral => auris_kit.AurisBadgeVariant.amber,
          AdaptiveBadgeTone.good => auris_kit.AurisBadgeVariant.gold,
          AdaptiveBadgeTone.bad => auris_kit.AurisBadgeVariant.danger,
          AdaptiveBadgeTone.quiet => auris_kit.AurisBadgeVariant.slate,
        },
      );
    }

    final color = switch (tone) {
      AdaptiveBadgeTone.neutral => scheme.accent,
      AdaptiveBadgeTone.good => scheme.success,
      AdaptiveBadgeTone.bad => scheme.danger,
      AdaptiveBadgeTone.quiet => scheme.textDim,
    };

    // A pill: the shape every flat system reaches for, and the one Auris
    // deliberately does not.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, letterSpacing: 0.8, color: color),
      ),
    );
  }
}
