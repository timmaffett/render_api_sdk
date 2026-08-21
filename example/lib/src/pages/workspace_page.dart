import 'package:auris/auris_widgets.dart';
import 'package:flutter/material.dart';
import 'package:render_api/render_api.dart' as render;

import '../data/render_client.dart';
import '../widgets/async_view.dart';
import '../widgets/responsive_scaffold.dart';

/// Workspaces, and the projects inside them.
///
/// This is the top of Render's hierarchy — workspace, then project, then
/// environment, then the resources themselves. The dashboard also files
/// anything outside a project under "Ungrouped Services", which is why the
/// services page is flat rather than nested under this one.
class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key, required this.client, this.onUnauthorized});

  final RenderClient client;
  final VoidCallback? onUnauthorized;

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<render.Owner>>(
      future: client.owners(),
      onUnauthorized: onUnauthorized,
      emptyMessage: 'No workspaces for this token.',
      builder: (context, owners) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final owner in owners) ...[
            AurisPanel(
              title: owner.name,
              code: codeFor(context, owner.id),
              accent: true,
              child: Column(
                children: [
                  AurisDataRow(label: 'email', value: owner.email),
                  AurisDataRow(label: 'type', value: owner.type.wireValue),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _Projects(client: client, ownerId: owner.id),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _Projects extends StatelessWidget {
  const _Projects({required this.client, required this.ownerId});

  final RenderClient client;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<render.Project>>(
      future: client.projects(ownerId: ownerId),
      emptyMessage: 'No projects — services can live outside one.',
      builder: (context, projects) => Column(
        children: [
          for (final project in projects)
            AurisPanel(
              title: project.name,
              code: codeFor(context, project.id),
              child: _Environments(client: client, projectId: project.id),
            ),
        ],
      ),
    );
  }
}

class _Environments extends StatelessWidget {
  const _Environments({required this.client, required this.projectId});

  final RenderClient client;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<render.Environment>>(
      future: client.environments(projectId),
      emptyMessage: 'No environments.',
      builder: (context, environments) => Column(
        children: [
          for (final environment in environments)
            // On a phone the id squeezes the name to "TESTING AND EXPERIM…",
            // so the name gets the row to itself; AurisDataRow needs one of
            // value or trailing, hence the empty trailing.
            AurisDataRow(
              label: environment.name,
              value: codeFor(context, environment.id),
              trailing: codeFor(context, environment.id) == null
                  ? const SizedBox.shrink()
                  : null,
            ),
        ],
      ),
    );
  }
}
