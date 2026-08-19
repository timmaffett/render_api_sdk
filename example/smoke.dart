// Live smoke test against the real Render API.
//
//   dart run example/smoke.dart            # read-only
//   dart run example/smoke.dart --cleanup  # also deletes the dart-wf-* strays
//
// Requires RENDER_API_KEY. Task runs cost a fraction of a cent.
import 'dart:io';

import 'package:render_api/render_api.dart';

const _workflowName = 'render-dart-workflow-test';

Future<void> main(List<String> args) async {
  final render = RenderApi();
  var failures = 0;

  void check(String label, bool ok, [Object? detail]) {
    stdout.writeln('${ok ? '  ok  ' : ' FAIL '} $label'
        '${detail == null ? '' : '  -> $detail'}');
    if (!ok) failures++;
  }

  try {
    stdout.writeln('\n-- workflows --');
    final workflows = await render.workflows.list().toList();
    check('list workflows', workflows.isNotEmpty, '${workflows.length} found');

    final target = workflows.where((w) => w.name == _workflowName).firstOrNull;
    check('found $_workflowName', target != null, target?.id);
    if (target == null) return;

    check('runtime is node', target.buildConfig.runtime == WorkflowRuntime.node);
    check('root dir is workflows', target.buildConfig.rootDir == 'workflows');
    check('task slug helper', target.taskSlug('sumSquares') ==
        '$_workflowName/sumSquares');

    stdout.writeln('\n-- versions --');
    final versions =
        await render.workflows.listVersions(workflowId: target.id).toList();
    check('list versions', versions.isNotEmpty, '${versions.length} found');
    final ready = versions.where((v) => v.status.isSuccess).toList();
    check('a version is ready', ready.isNotEmpty,
        ready.isEmpty ? versions.first.rawStatus : ready.first.id);

    stdout.writeln('\n-- tasks --');
    final tasks = await render.tasks.list(max: 50).toList();
    final names = tasks.map((t) => t.name).toSet();
    check('registered tasks include our Dart tasks',
        names.containsAll({'calculateSquare', 'sumSquares', 'boom'}),
        names.take(6).join(', '));

    stdout.writeln('\n-- run a task (fan-out) --');
    final sum = await render.taskRuns.run(
      target.taskSlug('sumSquares'),
      [
        [2, 3, 4]
      ],
      timeout: const Duration(minutes: 3),
    );
    check('sumSquares succeeded', sum.status.isSuccess, sum.status.name);
    check('sumSquares == 29', sum.result == 29, sum.result);
    check('duration recorded', sum.duration != null, sum.duration);

    stdout.writeln('\n-- child runs --');
    final children = await render.taskRuns
        .list(rootTaskRunIds: [sum.id], max: 20)
        .toList();
    check('three child runs', children.children.length == 3,
        '${children.children.length} of ${children.length} total');

    stdout.writeln('\n-- failure path --');
    final boom = await render.taskRuns.run(
      target.taskSlug('boom'),
      const [],
      timeout: const Duration(minutes: 3),
    );
    check('boom failed', boom.status == TaskRunStatus.failed, boom.status.name);
    check('Dart message survived', boom.error?.contains('sku-42') ?? false,
        boom.error?.split('\n').first);

    stdout.writeln('\n-- guardrails --');
    try {
      await render.taskRuns
          .start(target.taskSlug('boom'), ['x' * (5 * 1024 * 1024)]);
      check('4 MB input rejected locally', false, 'no error thrown');
    } on ArgumentError catch (e) {
      check('4 MB input rejected locally', true,
          e.message.toString().split('.').first);
    }

    try {
      await render.workflows.get('wfl-does-not-exist');
      check('404 mapped to typed error', false, 'no error thrown');
    } on RenderNotFoundException catch (e) {
      check('404 mapped to typed error', true, e.hint?.split('.').first);
    }

    if (args.contains('--cleanup')) {
      stdout.writeln('\n-- cleanup --');
      final strays =
          workflows.where((w) => w.name.startsWith('dart-wf-')).toList();
      for (final w in strays) {
        await render.workflows.delete(w.id);
        stdout.writeln('  deleted ${w.name} (${w.id})');
      }
      check('strays removed', true, '${strays.length} deleted');
    }
  } on RenderException catch (e) {
    stdout.writeln('\nRender error:\n$e');
    failures++;
  } finally {
    render.close();
  }

  stdout.writeln(failures == 0
      ? '\nAll checks passed.'
      : '\n$failures check(s) failed.');
  exit(failures == 0 ? 0 : 1);
}
