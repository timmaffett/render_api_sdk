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
    forui => _withReadableText(
      (dark ? forui_kit.FTheme.neutral.dark : forui_kit.FTheme.neutral.light)
          .touch
          .toApproximateMaterialTheme(),
      (dark ? forui_kit.FTheme.neutral.dark : forui_kit.FTheme.neutral.light)
          .touch
          .colors
          .foreground,
    ),
    fluent || shadcn => null,
  };

  /// Forces the text palette to match the surfaces this app paints.
  ///
  /// Found by running it: under Forui half the labels vanished. The bridge
  /// approximates a Material TextTheme against Forui's *own* surfaces, and any
  /// `Text` without an explicit colour inherits that — which is the wrong
  /// colour for the panels and rails here.
  ///
  /// The lesson is that a design-system seam has to cover typography, not only
  /// colour and components. A theme that agrees about backgrounds and disagrees
  /// about foregrounds is worse than one that disagrees about both, because it
  /// fails silently and only on some screens.
  static ThemeData _withReadableText(ThemeData base, Color foreground) =>
      base.copyWith(
        textTheme: base.textTheme.apply(
          bodyColor: foreground,
          displayColor: foreground,
        ),
      );

  /// Forui's own theme, which has to be installed as well as converted.
  ///
  /// `FTheme.of(context)` falls back to `FTheme.neutral.light.touch` when there
  /// is no ancestor, silently — so without this the app was themed dark by the
  /// converted Material theme while AdaptiveScheme read Forui's *light*
  /// colours, and half the labels were white on white. Two sources of truth,
  /// agreeing about nothing and complaining about nothing.
  forui_kit.FThemeData foruiTheme({required bool dark}) =>
      (dark ? forui_kit.FTheme.neutral.dark : forui_kit.FTheme.neutral.light)
          .touch;

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
