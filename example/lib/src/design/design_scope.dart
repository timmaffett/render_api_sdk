import 'package:flutter/widgets.dart';

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
