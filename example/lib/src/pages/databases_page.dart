import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/load_once.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/metric_chart.dart';
import 'postgres_detail_page.dart';

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
    return LoadOnce<List<render.Postgres>>(
      load: () => client.postgres(),
      onUnauthorized: onUnauthorized,
      emptyMessage: 'No render.Postgres instances.',
      builder: (context, databases) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: databases.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final db = databases[i];
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    PostgresDetailPage(client: client, database: db),
              ),
            ),
            child: AurisPanel(
              title: db.name,
              code: codeFor(context, db.id),
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
                  AurisDataRow(label: 'region', value: db.region.wireValue),
                  AurisDataRow(label: 'version', value: db.version.wireValue),
                  const SizedBox(height: 16),
                  LoadOnce<MetricChartData>(
                    load: () => client.cpuChart(db.id),
                    builder: (context, data) => data.isEmpty
                        ? const SizedBox(
                            height: 48,
                            child: Center(child: Text('no CPU data')),
                          )
                        : MetricChart(
                            title: 'CPU · 24h',
                            data: data,
                            height: 130,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
