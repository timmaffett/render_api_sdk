import 'package:flutter/material.dart';

import 'app_settings.dart';
import '../design/adaptive_scheme.dart';
import '../design/components/adaptive_surface.dart';
import '../design/components/adaptive_panel.dart';
import '../design/components/adaptive_data_row.dart';
import '../design/components/adaptive_controls.dart';
import '../design/components/adaptive_badge.dart';
import '../design/design_system.dart';

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

  final AppSettings settings;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    final text = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AdaptivePanel(
            title: 'DESIGN SYSTEM',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final system in AppDesignSystem.values)
                  InkWell(
                    onTap: () => settings.system = system,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            system == settings.system
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 18,
                            color: system == settings.system
                                ? scheme.accent
                                : scheme.textDim,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(system.label, style: text.bodyMedium),
                                Text(
                                  system.isMaterialTheme
                                      ? '${system.description} · a Material theme'
                                      : '${system.description} · replaces MaterialApp',
                                  style: text.bodySmall?.copyWith(
                                    color: scheme.textMid,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  'Auris and Forui are Material themes, so ordinary widgets '
                  'restyle themselves. Fluent and Shadcn bring their own root '
                  'widget instead — every control there goes through an '
                  'adapter, which is what this experiment is measuring.',
                  style: text.bodySmall?.copyWith(color: scheme.textDim),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AdaptivePanel(
            title: 'APPEARANCE',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdaptiveSwitch(
                  value: settings.dark,
                  label: 'DARK',
                  onChanged: (value) => settings.dark = value,
                ),
                const SizedBox(height: 20),
                Text('ACCENT', style: text.labelSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final (label, color) in AppSettings.accents)
                      _Swatch(
                        label: label,
                        color: color ?? scheme.accent,
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
          AdaptivePanel(
            title: 'TIME',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('CLOCK', style: text.labelSmall),
                const SizedBox(height: 8),
                SegmentedButton<ClockFormat>(
                  segments: const [
                    ButtonSegment(
                      value: ClockFormat.twelveHour,
                      label: Text('12 HOUR'),
                    ),
                    ButtonSegment(
                      value: ClockFormat.twentyFourHour,
                      label: Text('24 HOUR'),
                    ),
                  ],
                  selected: {settings.clock},
                  onSelectionChanged: (values) => settings.clock = values.first,
                ),
                const SizedBox(height: 24),
                Text('METRIC PANELS', style: text.labelSmall),
                const SizedBox(height: 8),
                SegmentedButton<MetricTimeDisplay>(
                  segments: const [
                    ButtonSegment(
                      value: MetricTimeDisplay.age,
                      label: Text('AGE'),
                    ),
                    ButtonSegment(
                      value: MetricTimeDisplay.clock,
                      label: Text('CLOCK TIME'),
                    ),
                  ],
                  selected: {settings.metricTime},
                  onSelectionChanged: (values) =>
                      settings.metricTime = values.first,
                ),
                const SizedBox(height: 8),
                Text(
                  settings.metricTime == MetricTimeDisplay.age
                      ? 'Panels count up from when their data was read — '
                            '"14 seconds ago" — and tick every second. A clock '
                            'time cannot show that a reload just happened.'
                      : 'Panels show the wall-clock time their data was read, '
                            'written as ${settings.formatClock(DateTime.now())}.',
                  style: text.bodySmall?.copyWith(color: scheme.textMid),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AdaptivePanel(
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
          AdaptivePanel(
            title: 'ABOUT',
            child: Column(
              children: [
                const AdaptiveDataRow(label: 'package', value: 'render_api'),
                const AdaptiveDataRow(label: 'mode', value: 'read-only'),
                AdaptiveDataRow(
                  label: 'theme',
                  value: 'auris',
                  trailing: const AdaptiveBadge(
                    'FLUTTER',
                    tone: AdaptiveBadgeTone.quiet,
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
    final scheme = AdaptiveScheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AdaptiveSurface(
        width: 78,
        height: 44,
        fill: color.withValues(alpha: selected ? 0.28 : 0.12),
        borderColor: selected ? color : scheme.border,
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
