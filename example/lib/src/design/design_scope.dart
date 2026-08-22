import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import 'design_system.dart';

/// Makes the current design system readable from anywhere.
///
/// Every adapter needs it, including ones inside pushed routes, so it sits
/// above the root app widget — the same lesson as RefreshScope, which had to be
/// hoisted above MaterialApp for exactly this reason.
class DesignScope extends InheritedWidget {
  const DesignScope({super.key, required this.system, required super.child});

  final AppDesignSystem system;

  static AppDesignSystem of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DesignScope>()?.system ??
      AppDesignSystem.auris;

  @override
  bool updateShouldNotify(DesignScope old) => system != old.system;
}

/// Whether Auris's own theme is actually in the tree.
///
/// Not the same question as "is Auris the chosen system". Changing the system
/// rebuilds the widgets that depend on [DesignScope] and the widgets that
/// depend on `Theme` — and they do not all rebuild in the same frame, so an
/// `AurisPanel` can be asked to build against Forui's theme on the way out.
/// Every Auris widget reads `extension<AurisScheme>()!` internally and throws
/// when it is missing, which cannot be guarded from outside the package.
///
/// So the adapters ask this before *returning* an Auris widget, and compose
/// their own for the frame in between. Fidelity when the theme is there,
/// something that renders when it is not.
bool aurisThemeReady(BuildContext context) =>
    Theme.of(context).extension<auris_kit.AurisScheme>() != null;
