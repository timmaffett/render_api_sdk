import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:fluent_ui/fluent_ui.dart' as fluent_kit;
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_kit;

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';

/// The interactive widgets, one adapter each.
///
/// This file is what dropping Phase 2's rule costs. Under a Material theme a
/// `FilledButton` restyles itself for free, so wrapping it would be waste —
/// but under Fluent's or Shadcn's root there is no Material theme to restyle
/// it, and an unwrapped button renders in Material's own clothes against
/// foreign chrome. So the rule "never wrap Material widgets" holds for exactly
/// half the systems, and a switch that covers all four cannot keep it.
///
/// Forui never appears below, which is worth noticing: because its theme *is*
/// a Material theme, every control it needs is already the Material one wearing
/// Forui's colours. That is the "approximate" in `toApproximateMaterialTheme` —
/// a Forui button here is a Material button in Forui clothing rather than an
/// `FButton`. Close enough that no adapter earns its keep, and a reminder that
/// a theme bridge buys breadth rather than fidelity.

/// The primary action.
class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.tone = AdaptiveButtonTone.normal,
  });

  final String label;
  final VoidCallback? onPressed;
  final AdaptiveButtonTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);

    return switch (DesignScope.of(context)) {
      // Both Material themes: the theme already styles it, so wrapping only
      // routes the destructive colour.
      AppDesignSystem.auris || AppDesignSystem.forui => FilledButton(
        onPressed: onPressed,
        style: tone == AdaptiveButtonTone.destructive
            ? FilledButton.styleFrom(backgroundColor: scheme.danger)
            : null,
        child: Text(label),
      ),

      AppDesignSystem.fluent =>
        tone == AdaptiveButtonTone.destructive
            ? fluent_kit.FilledButton(
                onPressed: onPressed,
                style: fluent_kit.ButtonStyle(
                  backgroundColor: fluent_kit.WidgetStatePropertyAll(
                    scheme.danger,
                  ),
                ),
                child: Text(label),
              )
            : fluent_kit.FilledButton(onPressed: onPressed, child: Text(label)),

      AppDesignSystem.shadcn =>
        tone == AdaptiveButtonTone.destructive
            ? shadcn_kit.DestructiveButton(
                onPressed: onPressed,
                child: Text(label),
              )
            : shadcn_kit.PrimaryButton(
                onPressed: onPressed,
                child: Text(label),
              ),
    };
  }
}

enum AdaptiveButtonTone { normal, destructive }

/// A secondary action.
class AdaptiveOutlinedButton extends StatelessWidget {
  const AdaptiveOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => switch (DesignScope.of(context)) {
    AppDesignSystem.auris || AppDesignSystem.forui => OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    ),
    AppDesignSystem.fluent => fluent_kit.Button(
      onPressed: onPressed,
      child: Text(label),
    ),
    AppDesignSystem.shadcn => shadcn_kit.OutlineButton(
      onPressed: onPressed,
      child: Text(label),
    ),
  };
}

/// A single-line entry field.
class AdaptiveTextField extends StatelessWidget {
  const AdaptiveTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.obscureText = false,
    this.autofocus = false,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => switch (DesignScope.of(context)) {
    AppDesignSystem.auris || AppDesignSystem.forui => TextField(
      controller: controller,
      obscureText: obscureText,
      autofocus: autofocus,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(labelText: label, hintText: hint),
    ),
    AppDesignSystem.fluent => fluent_kit.InfoLabel(
      label: label ?? '',
      child: fluent_kit.TextBox(
        controller: controller,
        obscureText: obscureText,
        autofocus: autofocus,
        placeholder: hint,
        onSubmitted: onSubmitted,
      ),
    ),
    AppDesignSystem.shadcn => shadcn_kit.TextField(
      controller: controller,
      obscureText: obscureText,
      autofocus: autofocus,
      placeholder: hint == null ? null : Text(hint!),
      onSubmitted: onSubmitted,
    ),
  };
}

/// An on/off control.
class AdaptiveSwitch extends StatelessWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) => switch (DesignScope.of(context)) {
    AppDesignSystem.auris => auris_kit.AurisSwitch(
      value: value,
      onChanged: onChanged,
      label: label,
    ),
    AppDesignSystem.forui => Switch(value: value, onChanged: onChanged),
    AppDesignSystem.fluent => fluent_kit.ToggleSwitch(
      checked: value,
      onChanged: onChanged,
      content: label == null ? null : Text(label!),
    ),
    AppDesignSystem.shadcn => shadcn_kit.Switch(
      value: value,
      onChanged: onChanged,
    ),
  };
}

/// A one-of-many choice.
class AdaptiveSegmented<T> extends StatelessWidget {
  const AdaptiveSegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  /// Value to label, in the order they should appear.
  final Map<T, String> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);

    if (DesignScope.of(context)
        case AppDesignSystem.auris || AppDesignSystem.forui) {
      return SegmentedButton<T>(
        segments: [
          for (final entry in segments.entries)
            ButtonSegment(value: entry.key, label: Text(entry.value)),
        ],
        selected: {selected},
        onSelectionChanged: (values) => onChanged(values.first),
      );
    }

    // Neither Fluent nor Shadcn ships a segmented control, so both get the
    // same composition — a row of bordered buttons, which is what each of
    // their own design languages would use.
    return Row(
      children: [
        for (final entry in segments.entries)
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: entry.key == selected
                      ? scheme.accent.withValues(alpha: 0.18)
                      : null,
                  border: Border.all(
                    color: entry.key == selected
                        ? scheme.accent
                        : scheme.border,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 12,
                    color: entry.key == selected
                        ? scheme.textBright
                        : scheme.textMid,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A segmented meter.
class AdaptiveProgressBar extends StatelessWidget {
  const AdaptiveProgressBar({
    super.key,
    required this.value,
    this.label,
    this.valueLabel,
    this.secondary = false,
  });

  final double value;
  final String? label;
  final String? valueLabel;

  /// Draws in the secondary colour, for a subordinate row.
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);

    if (DesignScope.of(context) == AppDesignSystem.auris) {
      return auris_kit.AurisProgressBar(
        value: value,
        label: label,
        valueLabel: valueLabel,
        segments: 24,
        variant: secondary
            ? auris_kit.AurisProgressVariant.secondary
            : auris_kit.AurisProgressVariant.primary,
      );
    }

    final color = secondary ? scheme.secondary : scheme.accent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || valueLabel != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label ?? '',
                    style: TextStyle(fontSize: 12, color: scheme.textMid),
                  ),
                ),
                if (valueLabel != null)
                  Text(
                    valueLabel!,
                    style: TextStyle(fontSize: 12, color: scheme.textDim),
                  ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: scheme.inset,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
