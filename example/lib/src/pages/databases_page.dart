import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/async_view.dart';
import '../widgets/sparkline.dart';

/// render.Postgres and key value stores.
///
/// Worth a page of its own because databases are where metrics actually work
/// on a free workspace: `getCpu` against a `dpg-` id returns real points, while
/// the same call against a `wfl-` id returns nothing at all.
class DatabasesPage extends StatelessWidget {
  const DatabasesPage({super.key, required this.client, this.onUnauthorized});

  final RenderClient client;
  final VoidCallback? onUnauthorized;

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<render.Postgres>>(
      future: client.postgres(),
      onUnauthorized: onUnauthorized,
      emptyMessage: 'No render.Postgres instances.',
      builder: (context, databases) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: databases.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final db = databases[i];
          return AurisPanel(
            title: db.name,
            code: db.id,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AurisDataRow(
                  label: 'status',
                  value: db.status.wireValue,
                  trailing: AurisBadge(
                    (db.plan.wireValue).toUpperCase(),
                    variant: AurisBadgeVariant.slate,
                  ),
                ),
                AurisDataRow(label: 'region', value: db.region.toString()),
                AurisDataRow(label: 'version', value: db.version.toString()),
                const SizedBox(height: 12),
                Text(
                  'CPU · 24h',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                AsyncView<List<MetricSeries>>(
                  future: client.cpu(db.id),
                  emptyMessage: 'No CPU data for this window.',
                  builder: (context, series) {
                    final withData = series.where((s) => !s.isEmpty).toList();
                    if (withData.isEmpty) {
                      return const SizedBox(
                        height: 48,
                        child: Center(child: Text('no data')),
                      );
                    }
                    return Sparkline(series: withData.first);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
