import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:forui/forui.dart' as forui_kit;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import '../adaptive_scheme.dart';
import '../design_system.dart';
import '../design_scope.dart';

/// A labelled figure, in whichever system is in force.
///
/// The shape of every adapter here: one widget, four answers. Auris has a
/// purpose-built card and simply returns it. The others have no equivalent, so
/// each is composed from that system's own primitives — not from Material with
/// a different colour, which is what makes the result look native rather than
/// merely recoloured.
///
/// The call site knows none of this. It asks for a stat card and gets the one
/// that belongs.
class AdaptiveStatCard extends StatelessWidget {
  const AdaptiveStatCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.delta,
  });

  final String label;
  final String value;
  final String? unit;

  /// A signed change, shown where the system has somewhere sensible to put it.
  final String? delta;

  @override
  Widget build(BuildContext context) {
    final system = DesignScope.of(context);
    final scheme = AdaptiveScheme.of(context, system);

    return switch (system) {
      // Auris ships this one, so nothing is reinvented.
      AppDesignSystem.auris => auris_kit.AurisStatCard(
        label: label,
        value: value,
        unit: unit,
        delta: delta,
      ),

      // Forui composes from its own card and typography.
      AppDesignSystem.forui => forui_kit.FCard(
        child: _Body(
          scheme: scheme,
          label: label,
          value: value,
          unit: unit,
          delta: delta,
        ),
      ),

      // Fluent's card equivalent is a Card with its own resources; the padding
      // and the muted label are what make it read as Windows rather than as
      // Material in different colours.
      AppDesignSystem.fluent => fluent_kit.Card(
        padding: const EdgeInsets.all(14),
        child: _Body(
          scheme: scheme,
          label: label,
          value: value,
          unit: unit,
          delta: delta,
        ),
      ),

      AppDesignSystem.shadcn => shadcn_kit.Card(
        child: _Body(
          scheme: scheme,
          label: label,
          value: value,
          unit: unit,
          delta: delta,
        ),
      ),
    };
  }
}

/// The contents, which are the same everywhere — only the frame differs.
///
/// Deliberately not four copies: the systems disagree about surfaces, borders
/// and corner treatment, not about how to stack a label above a number.
class _Body extends StatelessWidget {
  const _Body({
    required this.scheme,
    required this.label,
    required this.value,
    required this.unit,
    required this.delta,
  });

  final AdaptiveScheme scheme;
  final String label;
  final String value;
  final String? unit;
  final String? delta;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.2,
            color: scheme.textDim,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: scheme.textBright,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 4),
              Text(
                unit!,
                style: TextStyle(fontSize: 12, color: scheme.textMid),
              ),
            ],
            if (delta != null) ...[
              const Spacer(),
              Text(
                delta!,
                style: TextStyle(
                  fontSize: 12,
                  color: delta!.startsWith('-')
                      ? scheme.danger
                      : scheme.success,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
