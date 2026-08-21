import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:forui/forui.dart' as forui_kit;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import '../theme/app_settings.dart';
import 'adaptive_scheme.dart';
import 'design_system.dart';

/// The root, chosen by the current design system.
///
/// The original plan had this returning a different `ThemeData` to one
/// `MaterialApp`. That only works for the two systems that *are* Material
/// themes. Fluent and Shadcn each bring their own root built on `WidgetsApp`,
/// so the swap has to happen a level higher than the theme.
///
/// Everything below is written against Material regardless — `Navigator`,
/// `MediaQuery` and the rest come from `WidgetsApp` in every case, and both
/// non-Material roots ship Material's localization delegates, so Material
/// widgets still *function* under them. They just do not inherit the look,
/// which is why the components in this directory exist.
class AdaptiveApp extends StatelessWidget {
  const AdaptiveApp({
    super.key,
    required this.settings,
    required this.title,
    required this.home,
  });

  final AppSettings settings;
  final String title;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final dark = settings.dark;

    return switch (settings.system) {
      AppDesignSystem.auris || AppDesignSystem.forui => MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: settings.system.materialTheme(
          dark: dark,
          accent: settings.accent,
          bevelScale: settings.bevelScale,
          glowScale: settings.glowScale,
        ),
        // Forui needs its own theme installed as well as converted: without an
        // ancestor FTheme, `FTheme.of` quietly returns the default light theme,
        // so AdaptiveScheme read light colours onto dark surfaces.
        builder: settings.system != AppDesignSystem.forui
            ? null
            : (context, child) => forui_kit.FTheme(
                data: settings.system.foruiTheme(dark: dark),
                child: child ?? const SizedBox.shrink(),
              ),
        home: home,
      ),

      AppDesignSystem.fluent => fluent_kit.FluentApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: settings.system.fluentTheme(dark: dark),
        // Material widgets below still need a Material ancestor for ink and
        // text styling, and FluentApp does not provide one. The text colour
        // matters as much as the background: without it every unstyled Text
        // inherits Material's default, which is near-black on Fluent's dark
        // surfaces.
        builder: (context, child) {
          final theme = fluent_kit.FluentTheme.of(context);
          // Composited, because Fluent's own background colour is translucent
          // — see AdaptiveScheme.fluentBase.
          final base = AdaptiveScheme.fluentBase(theme.brightness);
          return Material(
            color: Color.alphaBlend(theme.scaffoldBackgroundColor, base),
            textStyle: TextStyle(
              color: Color.alphaBlend(
                theme.resources.textFillColorPrimary,
                base,
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: home,
      ),

      AppDesignSystem.shadcn => shadcn_kit.ShadcnApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: settings.system.shadcnTheme(dark: dark),
        builder: (context, child) {
          final theme = shadcn_kit.Theme.of(context);
          return Material(
            color: theme.colorScheme.background,
            textStyle: TextStyle(color: theme.colorScheme.foreground),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: home,
      ),
    };
  }
}
