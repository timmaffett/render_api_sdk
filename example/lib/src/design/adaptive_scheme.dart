import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:forui/forui.dart' as forui_kit;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import 'design_system.dart';

/// The colours this app actually asks for, named by what they mean.
///
/// This is the piece the original plan did not have, and nothing else compiles
/// without it. The app read `Theme.of(context).extension<AurisScheme>()!` in
/// twenty places for `danger`, `success`, `textDim` and friends; under any
/// other system that extension is absent and the `!` throws. Widgets were never
/// the real coupling — the scheme was.
///
/// Every system is asked for the same eight meanings and answers in its own
/// vocabulary. Where one has no equivalent — Fluent has no "dim text" token —
/// the nearest honest colour is used rather than an invented one.
@immutable
class AdaptiveScheme {
  const AdaptiveScheme({
    required this.page,
    required this.panel,
    required this.inset,
    required this.textBright,
    required this.textMid,
    required this.textDim,
    required this.border,
    required this.accent,
    required this.danger,
    required this.success,
    required this.secondary,
  });

  /// Reads the scheme for whichever system is in force.
  ///
  /// Auris is the only one that publishes a full semantic palette; the rest are
  /// mapped from what they do publish.
  factory AdaptiveScheme.of(BuildContext context, AppDesignSystem system) =>
      switch (system) {
        AppDesignSystem.auris => _fromAuris(
          Theme.of(context).extension<auris_kit.AurisScheme>()!,
        ),
        AppDesignSystem.forui => _fromForui(forui_kit.FTheme.of(context)),
        AppDesignSystem.fluent => _fromFluent(
          fluent_kit.FluentTheme.of(context),
        ),
        AppDesignSystem.shadcn => _fromShadcn(shadcn_kit.Theme.of(context)),
      };

  final Color page;
  final Color panel;
  final Color inset;
  final Color textBright;
  final Color textMid;
  final Color textDim;
  final Color border;
  final Color accent;
  final Color danger;
  final Color success;
  final Color secondary;

  static AdaptiveScheme _fromAuris(auris_kit.AurisScheme s) => AdaptiveScheme(
    page: s.surfacePage,
    panel: s.surfacePanel,
    inset: s.surfaceInset,
    textBright: s.textBright,
    textMid: s.textMid,
    textDim: s.textDim,
    border: s.borderResting,
    accent: s.primaryActive,
    danger: s.dangerBright,
    success: s.success,
    secondary: s.secondary,
  );

  static AdaptiveScheme _fromForui(forui_kit.FThemeData t) {
    final c = t.colors;
    return AdaptiveScheme(
      page: c.background,
      panel: c.secondary,
      inset: c.muted,
      textBright: c.foreground,
      textMid: c.mutedForeground,
      // Forui has no third text tier, so the middle tone is dimmed rather than
      // a fourth colour being invented.
      textDim: c.mutedForeground.withValues(alpha: 0.7),
      border: c.border,
      accent: c.primary,
      danger: c.destructive,
      // Nor a success colour: shadcn-descended palettes are deliberately
      // neutral, so this is the one place a literal is unavoidable.
      success: const Color(0xFF3FB950),
      secondary: c.secondaryForeground,
    );
  }

  static AdaptiveScheme _fromFluent(fluent_kit.FluentThemeData t) {
    final r = t.resources;
    return AdaptiveScheme(
      page: t.scaffoldBackgroundColor,
      panel: r.cardBackgroundFillColorDefault,
      inset: r.subtleFillColorSecondary,
      textBright: r.textFillColorPrimary,
      textMid: r.textFillColorSecondary,
      textDim: r.textFillColorTertiary,
      border: r.controlStrokeColorDefault,
      accent: t.accentColor.defaultBrushFor(t.brightness),
      danger: fluent_kit.Colors.red,
      success: fluent_kit.Colors.green,
      secondary: fluent_kit.Colors.blue,
    );
  }

  static AdaptiveScheme _fromShadcn(shadcn_kit.ThemeData t) {
    final c = t.colorScheme;
    return AdaptiveScheme(
      page: c.background,
      panel: c.card,
      inset: c.muted,
      textBright: c.foreground,
      textMid: c.mutedForeground,
      textDim: c.mutedForeground.withValues(alpha: 0.7),
      border: c.border,
      accent: c.primary,
      danger: c.destructive,
      success: const Color(0xFF3FB950),
      secondary: c.secondaryForeground,
    );
  }
}
