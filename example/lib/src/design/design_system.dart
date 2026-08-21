// Prefixed `*_kit` rather than by package name. An enum value below is called
// `auris`, and inside the enum's own scope a constant shadows an import prefix
// of the same name — the same family of collision as render_api's `State`,
// `Route` and `Image` against Flutter's.
import 'package:auris/auris.dart' as auris_kit;
import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:forui/forui.dart' as forui_kit;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

/// The design systems this app can wear.
///
/// They are not equivalent, and that is the point of the experiment.
///
/// [auris] and [forui] are **Material themes**: each produces a `ThemeData`, so
/// a `MaterialApp` restyles every ordinary widget for free. [fluent] and
/// [shadcn] are **parallel widget libraries**: they replace `MaterialApp` with
/// their own root built on `WidgetsApp`. A Material button dropped inside those
/// still works — both ship Material localizations — but renders in Material's
/// own clothes, looking foreign against the surrounding chrome.
///
/// So every interactive widget in this app has an adapter. The tidier rule,
/// "theme the Material widgets and wrap only the exotic ones", holds for half
/// of these and breaks for the other half.
enum AppDesignSystem {
  auris('Auris', 'Chamfered sci-fi HUD'),
  forui('Forui', 'Flat, shadcn-style'),
  fluent('Fluent', 'Windows 11'),
  shadcn('Shadcn', 'shadcn/ui for Flutter');

  const AppDesignSystem(this.label, this.description);

  final String label;
  final String description;

  /// Whether this system expresses itself as a Material [ThemeData].
  bool get isMaterialTheme => this == auris || this == forui;

  /// The Material theme for this system, or null when it has none.
  ///
  /// [accent], [bevelScale] and [glowScale] are Auris's three knobs and are
  /// ignored elsewhere — a system that offers no equivalent should not pretend
  /// to, so the settings page hides those controls rather than leaving them
  /// inert.
  ThemeData? materialTheme({
    required bool dark,
    Color? accent,
    double bevelScale = 1,
    double glowScale = 1,
  }) => switch (this) {
    auris =>
      dark
          ? auris_kit.AurisTheme.dark(
              accent: accent,
              bevelScale: bevelScale,
              glowScale: glowScale,
            )
          : auris_kit.AurisTheme.light(
              accent: accent,
              bevelScale: bevelScale,
              glowScale: glowScale,
            ),
    forui =>
      (dark ? forui_kit.FTheme.neutral.dark : forui_kit.FTheme.neutral.light)
          .touch
          .toApproximateMaterialTheme(),
    fluent || shadcn => null,
  };

  /// Fluent's own theme, for the root it insists on.
  fluent_kit.FluentThemeData fluentTheme({required bool dark}) => dark
      ? fluent_kit.FluentThemeData.dark()
      : fluent_kit.FluentThemeData.light();

  /// Shadcn's own theme. Note the type: `ThemeData` here is *shadcn's* class,
  /// not Material's — another collision, and the reason this directory imports
  /// everything with a prefix.
  shadcn_kit.ThemeData shadcnTheme({required bool dark}) =>
      shadcn_kit.ThemeData(
        colorScheme: dark
            ? shadcn_kit.ColorSchemes.darkZinc
            : shadcn_kit.ColorSchemes.lightZinc,
        radius: 0.5,
      );
}
