// Mirrors the official Node bindings one for one:
//
//   import renderApi from '@api/render-api';
//   renderApi.listHeaders({limit: '20', serviceId: 'serviceId'})
//
import 'package:render_api/render_api.dart';

Future<void> main() async {
  final render = RenderApi();
  try {
    // Flat form — the same spelling as the docs' Node examples.
    print('owners:    ${(await render.listOwners(limit: 5)).length}');
    print('projects:  ${(await render.listProjects(limit: 5)).length}');
    print('workflows: ${(await render.listWorkflows(limit: 10)).length}');

    // Grouped form — the same call by another route.
    print('grouped:   ${(await render.raw.workflows.listWorkflows(limit: 10)).length}');
  } finally {
    render.close();
  }
}
