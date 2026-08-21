import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import '../theme/app_settings.dart';
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
        home: home,
      ),

      AppDesignSystem.fluent => fluent_kit.FluentApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: settings.system.fluentTheme(dark: dark),
        // Material widgets below still need a Material ancestor for ink and
        // text styling, and FluentApp does not provide one.
        builder: (context, child) => Material(
          color: fluent_kit.FluentTheme.of(context).scaffoldBackgroundColor,
          child: child ?? const SizedBox.shrink(),
        ),
        home: home,
      ),

      AppDesignSystem.shadcn => shadcn_kit.ShadcnApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: settings.system.shadcnTheme(dark: dark),
        builder: (context, child) => Material(
          color: shadcn_kit.Theme.of(context).colorScheme.background,
          child: child ?? const SizedBox.shrink(),
        ),
        home: home,
      ),
    };
  }
}
