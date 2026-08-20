import 'package:auris/auris.dart';
import 'package:flutter/material.dart';

/// One destination in the app's navigation.
class Destination {
  const Destination({
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final WidgetBuilder builder;
}

/// The single breakpoint, in one place.
///
/// Wide: a navigation rail beside the content, the way the Render dashboard
/// sits on a desktop. Narrow: a bottom bar, because a rail on a phone leaves
/// no room for the tables this app is mostly made of.
const double kWideBreakpoint = 760;

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelect,
    required this.title,
    this.actions = const [],
  });

  final List<Destination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final wide = MediaQuery.sizeOf(context).width >= kWideBreakpoint;
    final body = destinations[selectedIndex].builder(context);

    return Scaffold(
      backgroundColor: scheme.surfacePage,
      appBar: AppBar(
        title: Text(
          title.toUpperCase(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(letterSpacing: 3),
        ),
        actions: actions,
      ),
      body: wide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onSelect,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: scheme.surfacePanel,
                  destinations: [
                    for (final d in destinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                VerticalDivider(width: 1, color: scheme.borderResting),
                Expanded(child: body),
              ],
            )
          : body,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelect,
              backgroundColor: scheme.surfacePanel,
              destinations: [
                for (final d in destinations)
                  NavigationDestination(icon: Icon(d.icon), label: d.label),
              ],
            ),
    );
  }
}
