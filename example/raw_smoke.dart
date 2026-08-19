import 'package:render_api/render_api.dart';

Future<void> main() async {
  final render = RenderApi();
  try {
    final owners = await render.raw.owners.listOwners(limit: 5);
    print('owners:      ${owners.length}');

    final services = await render.raw.services.listServices(limit: 5);
    print('services:    ${services.length}');

    final projects = await render.raw.projects.listProjects(limit: 5);
    print('projects:    ${projects.length}');

    // The flat and grouped forms are the same call by different routes.
    final flat = await render.listWorkflows(limit: 10);
    final grouped = await render.raw.workflows.listWorkflows(limit: 10);
    print('workflows:   flat=${flat.length} grouped=${grouped.length}');

    // Inline response schemas are typed too, not handed back as maps.
    if (flat.isNotEmpty) {
      final one = await render.getWorkflow(workflowId: flat.first.workflow.id);
      print('typed:       ${one.name} (${one.buildConfig.runtime.wireValue})');
    }

    // A typed error still surfaces through the generated layer.
    try {
      await render.retrieveService(serviceId: 'srv-nope');
      print('ERROR: expected a failure');
    } on RenderException catch (e) {
      print('typed error: ${e.runtimeType}');
    }
  } finally {
    render.close();
  }
}
