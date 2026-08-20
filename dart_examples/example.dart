// A minimal tour of package:render_api.
//
//   export RENDER_API_KEY=rnd_...
//   dart run example/example.dart
//
// The two smoke tests beside this one go further: raw_smoke.dart exercises both
// call forms against a live account, flat_smoke.dart mirrors Render's own Node
// examples.
import 'dart:io';

import 'package:render_api/render_api.dart';

Future<void> main() async {
  // Reads RENDER_API_KEY from the environment. On the web there is none, so
  // pass `token:` explicitly there.
  final render = RenderApi();

  try {
    // The flat form, spelled the way Render's documentation spells it.
    final workflows = await render.listWorkflows(limit: 10);
    stdout.writeln('${workflows.length} workflow service(s):');
    for (final entry in workflows) {
      // List endpoints return a `<Thing>WithCursor`, so reach through it.
      final workflow = entry.workflow;
      stdout.writeln(
        '  ${workflow.name}  ${workflow.id}  ${workflow.region.wireValue}',
      );
    }

    // The same call by the grouped route, for when the grouping reads better.
    final owners = await render.raw.owners.listOwners(limit: 5);
    stdout.writeln('${owners.length} owner(s)');

    // Free Postgres instances are deleted 30 days after creation, which is the
    // sort of thing worth noticing early.
    for (final entry in await render.listPostgres(limit: 20)) {
      final expires = entry.postgres.expiresAt;
      if (expires == null) continue;
      stdout.writeln(
        '${entry.postgres.name} expires in '
        '${expires.difference(DateTime.now()).inDays} days',
      );
    }
  } on RenderAuthException {
    stderr.writeln('RENDER_API_KEY is missing or rejected.');
    exitCode = 1;
  } on RenderApiException catch (e) {
    // Errors carry a hint where Render's response is misleading — it answers
    // 500, not 404, for an unknown task run id.
    stderr.writeln('${e.statusCode} ${e.path}: ${e.message}');
    if (e.hint != null) stderr.writeln('hint: ${e.hint}');
    exitCode = 1;
  } finally {
    render.close();
  }
}
