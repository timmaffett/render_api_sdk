import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';

import 'theme_settings.dart';

/// Live theme controls.
///
/// [AurisTheme] takes three values — accent, bevel scale, glow scale — so the
/// whole look is adjustable from one page, and every control here rebuilds the
/// `MaterialApp` theme as it moves rather than on a save button.
class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.settings,
    required this.onSignOut,
  });

  final ThemeSettings settings;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final text = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AurisPanel(
            title: 'APPEARANCE',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AurisSwitch(
                  value: settings.dark,
                  label: 'DARK',
                  statusLabels: const ('DARK', 'LIGHT'),
                  onChanged: (value) => settings.dark = value,
                ),
                const SizedBox(height: 20),
                Text('ACCENT', style: text.labelSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final (label, color) in ThemeSettings.accents)
                      _Swatch(
                        label: label,
                        color: color ?? scheme.primaryActive,
                        selected: settings.accent == color,
                        onTap: () => settings.accent = color,
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('BEVEL', style: text.labelSmall),
                const SizedBox(height: 8),
                SegmentedButton<double>(
                  segments: const [
                    ButtonSegment(value: 0.5, label: Text('TIGHT')),
                    ButtonSegment(value: 1.0, label: Text('NORMAL')),
                    ButtonSegment(value: 1.6, label: Text('BOLD')),
                  ],
                  selected: {settings.bevelScale},
                  onSelectionChanged: (values) =>
                      settings.bevelScale = values.first,
                ),
                const SizedBox(height: 24),
                Text(
                  'GLOW  ×${settings.glowScale.toStringAsFixed(1)}',
                  style: text.labelSmall,
                ),
                Slider(
                  value: settings.glowScale,
                  max: 3,
                  divisions: 12,
                  onChanged: (value) => settings.glowScale = value,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: settings.reset,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AurisPanel(
            title: 'ACCOUNT',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Signing out deletes the API key from this device\'s '
                  'keychain. Nothing is revoked on Render.',
                  style: text.bodySmall?.copyWith(color: scheme.textMid),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onSignOut,
                  style: FilledButton.styleFrom(backgroundColor: scheme.danger),
                  child: const Text('SIGN OUT'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AurisPanel(
            title: 'ABOUT',
            child: Column(
              children: [
                const AurisDataRow(label: 'package', value: 'render_api'),
                const AurisDataRow(label: 'mode', value: 'read-only'),
                AurisDataRow(
                  label: 'theme',
                  value: 'auris',
                  trailing: const AurisBadge(
                    'FLUTTER',
                    variant: AurisBadgeVariant.slate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    return GestureDetector(
      onTap: onTap,
      child: AurisContainer(
        width: 78,
        height: 44,
        cut: 6,
        fill: color.withValues(alpha: selected ? 0.28 : 0.12),
        borderColor: selected ? color : scheme.borderResting,
        borderWidth: selected ? 2 : 1,
        alignment: Alignment.center,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: selected ? scheme.textBright : scheme.textMid,
          ),
        ),
      ),
    );
  }
}
