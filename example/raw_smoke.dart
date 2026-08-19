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

    // A generated call and the hand-written facade against the same resource.
    final rawWorkflows = await render.raw.workflows.listWorkflows(limit: 10);
    final facadeWorkflows = await render.workflows.list().toList();
    print('workflows:   raw=${rawWorkflows.length} facade=${facadeWorkflows.length}');
    print('facade slug: ${facadeWorkflows.first.slug}');

    // A typed error still surfaces through the generated layer.
    try {
      await render.raw.services.retrieveService(serviceId: 'srv-nope');
      print('ERROR: expected a failure');
    } on RenderException catch (e) {
      print('typed error: ${e.runtimeType}');
    }
  } finally {
    render.close();
  }
}
