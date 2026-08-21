import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/load_once.dart';
import '../widgets/refresh_scope.dart';
import '../widgets/metric_chart.dart';
import '../widgets/metric_panel.dart';
import '../design/adaptive_scheme.dart';
import '../design/components/adaptive_data_row.dart';
import '../design/components/adaptive_badge.dart';

/// One service: deploys, events, environment and metrics.
///
/// Four tabs because four different operations answer four different
/// questions, and the dashboard splits them the same way.
class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({
    super.key,
    required this.client,
    required this.service,
  });

  final RenderClient client;
  final render.Service service;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: scheme.page,
        appBar: AppBar(
          title: Text(service.name.toUpperCase()),
          actions: const [RefreshButton()],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'DEPLOYS'),
              Tab(text: 'EVENTS'),
              Tab(text: 'ENV'),
              Tab(text: 'METRICS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _Deploys(client: client, service: service),
            _Events(client: client, service: service),
            _EnvVars(client: client, service: service),
            _Metrics(client: client, service: service),
          ],
        ),
      ),
    );
  }
}

class _Deploys extends StatelessWidget {
  const _Deploys({required this.client, required this.service});

  final RenderClient client;
  final render.Service service;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<render.Deploy>>(
      refresh: RefreshScope.of(context),
      load: () => client.deploys(service.id),
      emptyMessage: 'No deploys yet.',
      builder: (context, deploys) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: deploys.length,
        itemBuilder: (context, i) {
          final deploy = deploys[i];
          final status = deploy.status?.wireValue ?? 'unknown';
          return AdaptiveDataRow(
            label: _shortSha(deploy.commit?.id) ?? deploy.id,
            value: _ago(deploy.createdAt),
            highlight: i == 0,
            trailing: AdaptiveBadge(
              status.toUpperCase(),
              tone: switch (status) {
                'live' => AdaptiveBadgeTone.good,
                'build_failed' ||
                'update_failed' ||
                'canceled' => AdaptiveBadgeTone.bad,
                _ => AdaptiveBadgeTone.quiet,
              },
            ),
          );
        },
      ),
    );
  }
}

class _Events extends StatelessWidget {
  const _Events({required this.client, required this.service});

  final RenderClient client;
  final render.Service service;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<render.ServiceEventWithCursorEvent>>(
      refresh: RefreshScope.of(context),
      load: () => client.events(service.id),
      emptyMessage: 'No events.',
      builder: (context, events) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, i) => AdaptiveDataRow(
          label: events[i].type.toString(),
          value: _ago(events[i].timestamp),
        ),
      ),
    );
  }
}

class _EnvVars extends StatelessWidget {
  const _EnvVars({required this.client, required this.service});

  final RenderClient client;
  final render.Service service;

  @override
  Widget build(BuildContext context) {
    return LoadOnce<List<render.EnvVar>>(
      refresh: RefreshScope.of(context),
      load: () => client.envVars(service.id),
      emptyMessage: 'No environment variables set on this service.',
      builder: (context, vars) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vars.length,
        // Values are never shown. Render returns them, and an env var is
        // exactly where a credential lives — this app is read-only in the
        // stronger sense of not putting secrets on screen either.
        itemBuilder: (context, i) =>
            AdaptiveDataRow(label: vars[i].key, value: '•' * 12),
      ),
    );
  }
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.client, required this.service});

  final RenderClient client;
  final render.Service service;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ChartPanel(title: 'CPU', load: () => client.cpuChart(service.id)),
        const SizedBox(height: 12),
        _ChartPanel(
          title: 'MEMORY',
          load: () => client.memoryChart(service.id),
        ),
        const SizedBox(height: 12),
        _ChartPanel(
          title: 'BANDWIDTH',
          load: () => client.bandwidthChart(service.id),
        ),
        const SizedBox(height: 12),
        _ChartPanel(
          title: 'HTTP REQUESTS',
          load: () => client.httpRequestsChart(service.id),
          // Not a bug and not an idle service: HTTP metrics are gated by the
          // instance plan, and Render returns 200 with no series rather than
          // saying so. Its sibling getHttpLatency answers 400 outright.
          emptyMessage:
              'No data. HTTP request metrics are not included on the free '
              'plan — Render returns an empty result rather than an error.',
        ),
      ],
    );
  }
}

class _ChartPanel extends StatelessWidget {
  const _ChartPanel({
    required this.title,
    required this.load,
    this.emptyMessage = 'No data for this window.',
  });

  final String title;
  final Future<MetricChartData> Function() load;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final scheme = AdaptiveScheme.of(context);
    return LoadedPanel<MetricChartData>(
      title: title,
      load: load,
      builder: (context, data) => data.isEmpty
          ? SizedBox(
              height: 90,
              child: Center(
                child: Text(
                  emptyMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: scheme.textDim),
                ),
              ),
            )
          : MetricChart(title: '', data: data),
    );
  }
}

/// "3m ago", from whatever shape the field arrived in.
String _ago(Object? timestamp) {
  final at = switch (timestamp) {
    DateTime value => value,
    String value => DateTime.tryParse(value),
    _ => null,
  };
  if (at == null) return '—';

  final delta = DateTime.now().toUtc().difference(at.toUtc());
  if (delta.inMinutes < 1) return 'just now';
  if (delta.inHours < 1) return '${delta.inMinutes}m ago';
  if (delta.inDays < 1) return '${delta.inHours}h ago';
  return '${delta.inDays}d ago';
}

/// The first seven characters of a commit sha, or null if there is no commit —
/// an image-backed service deploys without one.
String? _shortSha(String? sha) =>
    sha == null || sha.length < 7 ? sha : sha.substring(0, 7);
