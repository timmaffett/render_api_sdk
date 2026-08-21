import 'package:flutter/material.dart';

import '../data/api_types.dart';
import '../data/render_client.dart';
import '../widgets/load_once.dart';
import '../widgets/refresh_scope.dart';
import '../widgets/metric_chart.dart';
import '../widgets/metric_palette.dart';
import '../widgets/metric_panel.dart';
import '../design/adaptive_scheme.dart';
import '../design/components/adaptive_panel.dart';
import '../design/components/adaptive_data_row.dart';
import '../design/components/adaptive_controls.dart';
import '../design/components/adaptive_badge.dart';

/// One Postgres instance: what it is doing, and what it holds.
///
/// The metrics tab is time series — CPU, memory, disk against its capacity,
/// and open connections. The other three are not metrics at all: Render runs
/// them against the database itself, so they answer what a time series cannot.
///
/// Each tab loads only when it is opened. The introspection endpoints are rate
/// limited far more tightly than the metrics ones — two calls in a row is
/// enough to be refused — so fetching all four eagerly would fail most of the
/// time.
class PostgresDetailPage extends StatelessWidget {
  const PostgresDetailPage({
    super.key,
    required this.client,
    required this.database,
  });

  final RenderClient client;
  final PostgresRecord database;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: scheme.page,
        appBar: AppBar(
          title: Text(database.name.toUpperCase()),
          actions: const [RefreshButton()],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'METRICS'),
              Tab(text: 'SIZES'),
              Tab(text: 'QUERIES'),
              Tab(text: 'ACTIVITY'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _Metrics(client: client, id: database.id),
            _Sizes(client: client, id: database.id),
            _Queries(client: client, id: database.id),
            _Activity(client: client, id: database.id),
          ],
        ),
      ),
    );
  }
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.client, required this.id});

  final RenderClient client;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Panel(kind: MetricKind.cpu, load: () => client.cpuChart(id)),
        const SizedBox(height: 12),
        _Panel(kind: MetricKind.memory, load: () => client.memoryChart(id)),
        const SizedBox(height: 12),
        _Panel(kind: MetricKind.disk, load: () => client.diskChart(id)),
        const SizedBox(height: 12),
        _Panel(
          kind: MetricKind.connections,
          load: () => client.connectionsChart(id),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.kind, required this.load});

  final MetricKind kind;
  final Future<MetricChartData> Function() load;

  @override
  Widget build(BuildContext context) => LoadedPanel<MetricChartData>(
    title: kind.label,
    load: load,
    builder: (context, data) => data.isEmpty
        ? const SizedBox(
            height: 60,
            child: Center(child: Text('no data for this window')),
          )
        : MetricChart(title: '', data: data, kind: kind),
  );
}

class _Sizes extends StatelessWidget {
  const _Sizes({required this.client, required this.id});

  final RenderClient client;
  final String id;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<PostgresSize>>(
      // One request answers this whole tab, so one stamp covers every row in
      // it; a note per card would repeat the same time down the page.
      stamp: true,
      refresh: RefreshScope.of(context),
      load: () => client.sizes(id),
      emptyMessage: 'No tables yet.',
      builder: (context, sizes) {
        final largest = sizes.first.bytes.toDouble();
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sizes.length,
          itemBuilder: (context, i) {
            final size = sizes[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AdaptiveProgressBar(
                // Relative to the largest object, so the bar compares things
                // rather than implying a capacity it does not know.
                value: largest == 0 ? 0 : size.bytes / largest,
                label: size.name,
                valueLabel: _bytes(size.bytes),
                secondary: size.index != null,
              ),
            );
          },
        );
      },
    );
  }
}

class _Queries extends StatelessWidget {
  const _Queries({required this.client, required this.id});

  final RenderClient client;
  final String id;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<TopQuery>>(
      // One request answers this whole tab, so one stamp covers every row in
      // it; a note per card would repeat the same time down the page.
      stamp: true,
      refresh: RefreshScope.of(context),
      load: () => client.topQueries(id),
      emptyMessage:
          'No statements recorded. Render reports these from '
          'pg_stat_statements, which starts empty.',
      builder: (context, queries) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: queries.length,
        itemBuilder: (context, i) {
          final query = queries[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AdaptivePanel(
              title: '${query.calls} calls',
              code: '${query.meanMs.toStringAsFixed(2)} ms mean',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SelectableText(
                    query.query.replaceAll(RegExp(r'\s+'), ' '),
                    maxLines: 4,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  AdaptiveDataRow(
                    label: 'total',
                    value: '${query.totalMs.toStringAsFixed(1)} ms',
                  ),
                  AdaptiveDataRow(label: 'rows', value: '${query.rows}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Activity extends StatelessWidget {
  const _Activity({required this.client, required this.id});

  final RenderClient client;
  final String id;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<PostgresProcess>>(
      // One request answers this whole tab, so one stamp covers every row in
      // it; a note per card would repeat the same time down the page.
      stamp: true,
      refresh: RefreshScope.of(context),
      load: () => client.processes(id),
      emptyMessage: 'Nothing running.',
      builder: (context, processes) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: processes.length,
        itemBuilder: (context, i) {
          final process = processes[i];
          return AdaptiveDataRow(
            label: 'pid ${process.pid}',
            value: process.application.isEmpty
                ? process.state
                : '${process.state} · ${process.application}',
            trailing: AdaptiveBadge(
              '${process.seconds.toStringAsFixed(1)}s',
              tone: process.seconds > 5
                  ? AdaptiveBadgeTone.bad
                  : AdaptiveBadgeTone.quiet,
            ),
          );
        },
      ),
    );
  }
}

String _bytes(int value) {
  if (value >= 1 << 30) return '${(value / (1 << 30)).toStringAsFixed(2)} GB';
  if (value >= 1 << 20) return '${(value / (1 << 20)).toStringAsFixed(1)} MB';
  return '${(value / 1024).toStringAsFixed(0)} kB';
}
