import 'package:auris/auris_widgets.dart' as auris_kit;
import 'package:flutter/material.dart';

import '../adaptive_scheme.dart';
import '../design_scope.dart';
import '../design_system.dart';

/// A label on the left, a value on the right.
///
/// The most-used component in the app — twenty-two call sites — and the one
/// where the systems disagree least about structure and most about texture.
/// Auris draws a fixed-height row with an uppercase key and a monospace value;
/// the flat systems use ordinary sentence case and let the row breathe.
class AdaptiveDataRow extends StatelessWidget {
  const AdaptiveDataRow({
    super.key,
    required this.label,
    this.value,
    this.trailing,
    this.highlight = false,
  }) : assert(
         value != null || trailing != null,
         'Provide a value, a trailing widget, or both.',
       );

  final String label;
  final String? value;
  final Widget? trailing;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    if (DesignScope.of(context) == AppDesignSystem.auris &&
        aurisThemeReady(context)) {
      return auris_kit.AurisDataRow(
        label: label,
        value: value,
        trailing: trailing,
        highlight: highlight,
      );
    }

    final scheme = AdaptiveScheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: scheme.textMid),
            ),
          ),
          if (value != null)
            Text(
              value!,
              style: TextStyle(
                fontSize: 13,
                color: highlight ? scheme.accent : scheme.textBright,
                fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}
