// Drives every loader in RenderClient against a live account.
//
//   RENDER_API_KEY=rnd_... dart run tool/live_smoke.dart
//
// The widget tests prove the pages render given data. This proves the data is
// real: that Render's actual responses deserialize into the models the pages
// name, which canned fixtures cannot show — a field Render renamed, or a null
// where the model expects a value, fails here and nowhere else.
//
// It runs on the plain Dart VM. render_client.dart imports no Flutter, which
// is what makes that possible, and is a good reason to keep it that way.
import 'dart:io';

import 'package:render_dashboard/src/data/render_client.dart';
import 'package:render_api/render_api.dart' as render;

Future<void> main() async {
  final token = Platform.environment['RENDER_API_KEY'];
  if (token == null || token.isEmpty) {
    stderr.writeln('RENDER_API_KEY is not set.');
    exit(1);
  }

  final client = RenderClient(token);
  var failures = 0;

  /// Runs one loader, reporting what came back rather than asserting a count —
  /// an empty account is not a failure, a deserialization error is.
  Future<List<T>> check<T>(
    String label,
    Future<List<T>> Function() load,
  ) async {
    try {
      final items = await load();
      final sample = items.isEmpty ? '' : '   e.g. ${_describe(items.first)}';
      stdout.writeln('  ok    ${label.padRight(22)} ${items.length}$sample');
      return items;
    } on render.RenderApiException catch (e) {
      failures++;
      stdout.writeln(
        '  FAIL  ${label.padRight(22)} ${e.statusCode}  ${e.hint ?? e.message}',
      );
      return <T>[];
    } on Object catch (e) {
      failures++;
      stdout.writeln('  FAIL  ${label.padRight(22)} $e');
      return <T>[];
    }
  }

  try {
    final owners = await check('owners', client.owners);
    if (owners.isNotEmpty) {
      final projects = await check(
        'projects',
        () => client.projects(ownerId: owners.first.id),
      );
      if (projects.isNotEmpty) {
        await check(
          'environments',
          () => client.environments(projects.first.id),
        );
      }
    }

    final services = await check('services', client.services);
    if (services.isNotEmpty) {
      // Deliberately not services.first: a static site has no runtime, no
      // instance and therefore no CPU or memory, so picking one would make
      // correct empty results look like failures.
      final subject = services.firstWhere(
        (s) => s.type == render.ServiceType.webService,
        orElse: () => services.first,
      );
      final id = subject.id;
      stdout.writeln('  --    metrics subject        ${subject.name}');
      await check('deploys', () => client.deploys(id));
      await check('events', () => client.events(id));
      await check('envVars', () => client.envVars(id));
      await check('cpu', () => client.cpu(id));
      await check('memory', () => client.memory(id));
      await check('bandwidth', () => client.bandwidth(id));
      // Expected empty on a free plan; see the note in render_client.dart.
      await check('httpRequests', () => client.httpRequests(id));
    }

    await check('postgres', client.postgres);
    await check('keyValue', client.keyValue);

    final workflows = await check('workflows', client.workflows);
    if (workflows.isNotEmpty) {
      final id = workflows.first.id;
      await check('tasks', () => client.tasks(id));
      await check('taskRuns', () => client.taskRuns(workflowId: id));
    }
  } finally {
    client.close();
  }

  stdout.writeln(
    failures == 0
        ? '\n  every loader returned a typed result.'
        : '\n  $failures loader(s) failed.',
  );
  exit(failures == 0 ? 0 : 1);
}

/// A one-line identity for whatever came back, without assuming a shape.
String _describe(Object? item) => switch (item) {
  render.Service s => s.name,
  render.Owner o => o.name,
  render.Project p => p.name,
  render.Postgres p => p.name,
  MetricSeries m => '${m.label} (${m.points.length} points)',
  _ => item.runtimeType.toString(),
};
