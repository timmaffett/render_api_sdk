import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/async_view.dart';
import '../widgets/responsive_scaffold.dart';
import 'service_detail_page.dart';

/// Every service in the workspace.
///
/// The dashboard groups these under projects and environments; this page is
/// flat, and says which environment each belongs to instead. It deliberately
/// mirrors the dashboard's own columns — name, status, runtime, region.
///
/// Workflow services are **not** here. `GET /services` and `GET /workflows`
/// return disjoint sets, which reads as a missing service until you know it,
/// so the empty state says so.
class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key, required this.client, this.onUnauthorized});

  final RenderClient client;
  final VoidCallback? onUnauthorized;

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<render.Service>> _future = widget.client.services();

  void _reload() => setState(() => _future = widget.client.services());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _reload(),
      child: AsyncView<List<render.Service>>(
        future: _future,
        onUnauthorized: widget.onUnauthorized,
        emptyMessage:
            'No services.\n\nWorkflow services do not appear here — they come '
            'from GET /workflows, which is a separate list.',
        builder: (context, services) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) =>
              _ServiceCard(service: services[i], client: widget.client),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.client});

  final render.Service service;
  final RenderClient client;

  @override
  Widget build(BuildContext context) {
    // serviceDetails is a oneOf across five service types, so it arrives
    // untyped and a static site has no runtime, plan or region at all.
    final details = service.serviceDetails as Map<String, Object?>? ?? const {};
    String detail(String key) => (details[key] ?? '—').toString();

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ServiceDetailPage(client: client, service: service),
        ),
      ),
      child: AurisPanel(
        title: service.name,
        code: codeFor(context, service.id),
        child: Column(
          children: [
            AurisDataRow(
              label: 'type',
              value: service.type.wireValue,
              trailing: AurisBadge(
                detail('runtime').toUpperCase(),
                variant: switch (detail('runtime')) {
                  'docker' => AurisBadgeVariant.gold,
                  '—' => AurisBadgeVariant.slate,
                  _ => AurisBadgeVariant.amber,
                },
              ),
            ),
            AurisDataRow(label: 'plan', value: detail('plan')),
            AurisDataRow(label: 'region', value: detail('region')),
            AurisDataRow(
              label: 'repo',
              value: (service.repo ?? '—').replaceFirst(
                'https://github.com/',
                '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
