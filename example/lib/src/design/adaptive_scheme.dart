import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:forui/forui.dart' as forui_kit;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import 'design_scope.dart';
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
    required this.dangerStrong,
    required this.success,
    required this.secondary,
    required this.accentDim,
    required this.borderStrong,
    required this.cornerCut,
  });

  /// Reads the scheme for whichever system is in force.
  ///
  /// Auris is the only one that publishes a full semantic palette; the rest are
  /// mapped from what they do publish. The system comes from [DesignScope], so
  /// a call site asks for colours and never for a system.
  factory AdaptiveScheme.of(BuildContext context) =>
      AdaptiveScheme.forSystem(context, DesignScope.of(context));

  factory AdaptiveScheme.forSystem(
    BuildContext context,
    AppDesignSystem system,
  ) => switch (system) {
    AppDesignSystem.auris => _fromAuris(
      Theme.of(context).extension<auris_kit.AurisScheme>()!,
    ),
    AppDesignSystem.forui => _fromForui(forui_kit.FTheme.of(context)),
    AppDesignSystem.fluent => _fromFluent(fluent_kit.FluentTheme.of(context)),
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

  /// The louder danger, where a system has two. Where it has one, the same.
  final Color dangerStrong;

  final Color success;
  final Color secondary;

  /// The quieter accent, for rules and inactive marks.
  final Color accentDim;

  /// The stronger border, for a raised edge against a plain one.
  final Color borderStrong;

  /// How far a corner is chamfered.
  ///
  /// Geometry rather than colour, and the one token that is zero for three of
  /// the four: Auris's chamfer is a signature, and the flat systems would look
  /// wrong wearing it. Keeping it here means a surface can ask "how do corners
  /// work in this system" instead of asking which system it is.
  final double cornerCut;

  static AdaptiveScheme _fromAuris(auris_kit.AurisScheme s) => AdaptiveScheme(
    page: s.surfacePage,
    panel: s.surfacePanel,
    inset: s.surfaceInset,
    textBright: s.textBright,
    textMid: s.textMid,
    textDim: s.textDim,
    border: s.borderResting,
    accent: s.primaryActive,
    danger: s.danger,
    dangerStrong: s.dangerBright,
    success: s.success,
    secondary: s.secondary,
    accentDim: s.primaryDim,
    borderStrong: s.borderBright,
    cornerCut: s.bevel.lg,
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
      dangerStrong: c.destructive,
      // Nor a success colour: shadcn-descended palettes are deliberately
      // neutral, so this is the one place a literal is unavoidable.
      success: const Color(0xFF3FB950),
      secondary: c.secondaryForeground,
      accentDim: c.primary.withValues(alpha: 0.5),
      borderStrong: c.border,
      cornerCut: 0,
    );
  }

  /// The opaque colour Fluent expects to be composited over.
  ///
  /// Measured, because guessing was wrong twice: Fluent's own
  /// `scaffoldBackgroundColor` is `#40ffffff` in light and `#09ffffff` in dark
  /// — translucent white, both of them. *Every* colour in the theme is an
  /// overlay, because Windows paints them over mica and the theme never carries
  /// the backdrop. An app that paints them flat gets grey, which is exactly
  /// what happened.
  ///
  /// These are Windows 11's mica base colours, and supplying one is the only
  /// way to recover the colour Fluent intends a reader to see.
  static Color fluentBase(Brightness brightness) =>
      brightness == Brightness.dark
      ? const Color(0xFF202020)
      : const Color(0xFFF3F3F3);

  static AdaptiveScheme _fromFluent(fluent_kit.FluentThemeData t) {
    final r = t.resources;
    final base = fluentBase(t.brightness);
    final page = Color.alphaBlend(t.scaffoldBackgroundColor, base);

    Color over(Color c) => Color.alphaBlend(c, page);

    return AdaptiveScheme(
      page: page,
      panel: over(r.cardBackgroundFillColorDefault),
      inset: over(r.subtleFillColorSecondary),
      textBright: over(r.textFillColorPrimary),
      textMid: over(r.textFillColorSecondary),
      textDim: over(r.textFillColorTertiary),
      border: over(r.controlStrokeColorDefault),
      accent: t.accentColor.defaultBrushFor(t.brightness),
      danger: fluent_kit.Colors.red,
      dangerStrong: fluent_kit.Colors.red.lighter,
      success: fluent_kit.Colors.green,
      secondary: fluent_kit.Colors.blue,
      accentDim: t.accentColor
          .defaultBrushFor(t.brightness)
          .withValues(alpha: 0.5),
      borderStrong: over(r.controlStrongStrokeColorDefault),
      cornerCut: 0,
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
      dangerStrong: c.destructive,
      success: const Color(0xFF3FB950),
      secondary: c.secondaryForeground,
      accentDim: c.primary.withValues(alpha: 0.5),
      borderStrong: c.border,
      cornerCut: 0,
    );
  }
}
