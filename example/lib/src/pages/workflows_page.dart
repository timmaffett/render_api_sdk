import 'package:auris/auris_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/load_once.dart';
import '../widgets/responsive_scaffold.dart';

/// Workflow services, their tasks, and how their runs have been going.
///
/// These come from `GET /workflows`, which is disjoint from `GET /services` —
/// nothing here appears on the services page and vice versa.
///
/// The run-outcome chart is built from `listTaskRuns` rather than from a
/// metrics endpoint, which is also how the dashboard does it: workflow
/// services have no CPU or memory metrics at all, so their charts are made of
/// run records.
class WorkflowsPage extends StatelessWidget {
  const WorkflowsPage({super.key, required this.client, this.onUnauthorized});

  final RenderClient client;
  final VoidCallback? onUnauthorized;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<render.WorkflowWithCursorWorkflow>>(
      load: () => client.workflows(),
      onUnauthorized: onUnauthorized,
      emptyMessage: 'No workflow services.',
      builder: (context, workflows) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: workflows.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final workflow = workflows[i];
          return AurisPanel(
            title: workflow.name,
            code: codeFor(context, workflow.id),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AurisDataRow(
                  label: 'root dir',
                  value: workflow.buildConfig.rootDir ?? '/',
                ),
                AurisDataRow(label: 'region', value: workflow.region.wireValue),
                const SizedBox(height: 12),
                _RunOutcomes(client: client, workflowId: workflow.id),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Succeeded / failed / other, over the runs the API will return.
class _RunOutcomes extends StatelessWidget {
  const _RunOutcomes({required this.client, required this.workflowId});

  final RenderClient client;
  final String workflowId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.extension<AurisScheme>()!;

    return LoadOnce<List<render.TaskRunWithCursorTaskRun>>(
      load: () => client.taskRuns(workflowId: workflowId),
      emptyMessage: 'No runs yet.',
      builder: (context, runs) {
        final counts = <String, int>{};
        for (final run in runs) {
          final status = run.status.wireValue;
          counts[status] = (counts[status] ?? 0) + 1;
        }
        final entries = counts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        return SizedBox(
          height: 140,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= entries.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          entries[i].key.toUpperCase(),
                          style: theme.textTheme.labelSmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: [
                for (var i = 0; i < entries.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: entries[i].value.toDouble(),
                        width: 18,
                        borderRadius: BorderRadius.zero,
                        // The spec has both 'completed' and 'succeeded';
                        // Render returns 'completed' in practice, so matching
                        // only 'succeeded' left every good run painted in the
                        // neutral colour. Both are a success.
                        color: switch (entries[i].key) {
                          'completed' || 'succeeded' => scheme.success,
                          'failed' => scheme.danger,
                          'canceled' => scheme.secondary,
                          'running' ||
                          'pending' ||
                          'paused' => scheme.primaryActive,
                          _ => scheme.primaryDim,
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
