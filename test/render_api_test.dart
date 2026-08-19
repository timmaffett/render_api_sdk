import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:render_api/render_api.dart';
import 'package:test/test.dart';

/// Builds an API whose transport is driven by [handler], so tests need no
/// credentials and no network.
RenderApi apiWith(Future<http.Response> Function(http.Request) handler,
        {int maxRetries = 3}) =>
    RenderApi(
      token: 'test-token',
      maxRetries: maxRetries,
      httpClient: MockClient(handler),
    );

http.Response json(Object? body, [int status = 200]) => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json'},
    );

void main() {
  group('authentication', () {
    test('rejects construction without a token', () {
      expect(
        () => RenderApi(token: ''),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message.toString(),
          'message',
          contains('RENDER_API_KEY'),
        )),
      );
    });

    test('sends a bearer token and JSON accept header', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json({'id': 'wfl-1', 'name': 'w'});
      });

      await api.workflows.get('wfl-1');

      expect(seen.headers['Authorization'], 'Bearer test-token');
      expect(seen.headers['Accept'], 'application/json');
      expect(seen.url.path, endsWith('/workflows/wfl-1'));
    });
  });

  group('error mapping', () {
    test('402 explains that Workflows require billing', () async {
      final api = apiWith((_) async => http.Response('payment required', 402));

      await expectLater(
        api.workflows.get('wfl-1'),
        throwsA(isA<RenderPaymentRequiredException>()
            .having((e) => e.hint, 'hint', contains('payment method'))),
      );
    });

    test('500 on workflow creation blames repository access', () async {
      // The real API returns exactly this, with no usable detail, when its Git
      // app cannot read the repo. The hint is the whole point of the client.
      final api = apiWith((_) async => http.Response('internal server error', 500));

      await expectLater(
        api.workflows.create(
          name: 'w',
          ownerId: 'tea-1',
          repo: 'https://github.com/o/r',
          buildCommand: 'npm install',
          runCommand: 'node index.js',
        ),
        throwsA(isA<RenderServerException>()
            .having((e) => e.hint, 'hint', contains('grant'))),
      );
    });

    test('404 is typed and mentions workspace scoping', () async {
      final api = apiWith((_) async => http.Response('', 404));

      await expectLater(
        api.workflows.get('nope'),
        throwsA(isA<RenderNotFoundException>()
            .having((e) => e.statusCode, 'statusCode', 404)),
      );
    });

    test('429 surfaces Retry-After', () async {
      final api = apiWith(
        (_) async => http.Response('slow down', 429, headers: {'retry-after': '7'}),
        maxRetries: 0,
      );

      await expectLater(
        api.tasks.get('tsk-1'),
        throwsA(isA<RenderRateLimitException>()
            .having((e) => e.retryAfter, 'retryAfter', const Duration(seconds: 7))),
      );
    });
  });

  group('retry policy', () {
    test('retries 5xx on GET', () async {
      var calls = 0;
      final api = apiWith((_) async {
        calls++;
        return calls < 3 ? http.Response('boom', 503) : json({'id': 'tsk-1', 'name': 't'});
      });

      final task = await api.tasks.get('tsk-1');
      expect(task.id, 'tsk-1');
      expect(calls, 3);
    });

    test('does NOT retry 5xx on POST, which could double-create', () async {
      var calls = 0;
      final api = apiWith((_) async {
        calls++;
        return http.Response('boom', 500);
      });

      await expectLater(
        api.taskRuns.start('wf/t', const []),
        throwsA(isA<RenderServerException>()),
      );
      expect(calls, 1);
    });
  });

  group('task runs', () {
    test('start posts the slug and positional input', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json({
          'id': 'trn-1',
          'taskId': 'tsk-1',
          'status': 'pending',
          'parentTaskRunId': '',
          'rootTaskRunId': '',
          'retries': 0,
          'attempts': <Object?>[],
        }, 202);
      });

      final run = await api.taskRuns.start('wf/sumSquares', [
        [2, 3, 4]
      ]);

      final body = jsonDecode(seen.body) as Map<String, Object?>;
      expect(body['task'], 'wf/sumSquares');
      expect(body['input'], [
        [2, 3, 4]
      ]);
      expect(run.status, TaskRunStatus.pending);
      expect(run.isChildRun, isFalse, reason: 'empty parent id means root');
    });

    test('rejects input over the 4 MB limit before sending', () async {
      var called = false;
      final api = apiWith((_) async {
        called = true;
        return json({});
      });

      expect(
        () => api.taskRuns.start('wf/t', ['x' * (5 * 1024 * 1024)]),
        throwsA(isA<ArgumentError>()
            .having((e) => e.message.toString(), 'message', contains('4 MB'))),
      );
      expect(called, isFalse, reason: 'must not hit the network');
    });

    test('treats both completed and succeeded as terminal success', () {
      for (final wire in ['completed', 'succeeded']) {
        final status = TaskRunStatus.fromWire(wire);
        expect(status.isTerminal, isTrue, reason: wire);
        expect(status.isSuccess, isTrue, reason: wire);
      }
      expect(TaskRunStatus.fromWire('running').isTerminal, isFalse);
      expect(TaskRunStatus.fromWire('failed').isSuccess, isFalse);
    });

    test('decodes an unknown status instead of throwing', () {
      // Workflows is beta; a new status must not break existing clients.
      final status = TaskRunStatus.fromWire('quarantined');
      expect(status, TaskRunStatus.unknown);
      expect(status.isTerminal, isFalse);
    });

    test('details unwrap the single result value', () {
      final details = TaskRunDetails.fromJson({
        'id': 'trn-1',
        'taskId': 'tsk-1',
        'status': 'completed',
        'parentTaskRunId': '',
        'rootTaskRunId': '',
        'retries': 0,
        'attempts': <Object?>[],
        'results': [29],
        'input': [
          [2, 3, 4]
        ],
      });

      expect(details.result, 29);
      expect(details.isTerminal, isTrue);
    });

    test('waitFor polls until terminal', () async {
      final statuses = ['pending', 'running', 'completed'];
      var i = 0;
      final api = apiWith((_) async => json({
            'id': 'trn-1',
            'taskId': 'tsk-1',
            'status': statuses[i < statuses.length - 1 ? i++ : i],
            'parentTaskRunId': '',
            'rootTaskRunId': '',
            'retries': 0,
            'attempts': <Object?>[],
            'results': [42],
            'input': <Object?>[],
          }));

      final done = await api.taskRuns
          .waitFor('trn-1', pollInterval: const Duration(milliseconds: 1));
      expect(done.status, TaskRunStatus.completed);
      expect(done.result, 42);
    });
  });

  group('pagination', () {
    test('unwraps the resource envelope and follows cursors', () async {
      final pages = [
        [
          for (var i = 0; i < 2; i++)
            {
              'task': {'id': 'tsk-$i', 'name': 'task$i'},
              'cursor': 'c$i',
            }
        ],
        [
          {
            'task': {'id': 'tsk-2', 'name': 'task2'},
            'cursor': 'c2',
          }
        ],
      ];
      var call = 0;
      final api = apiWith((_) async => json(pages[call++]));

      final tasks = await api.tasks.list(pageSize: 2).toList();

      expect(tasks.map((t) => t.id), ['tsk-0', 'tsk-1', 'tsk-2']);
      expect(call, 2, reason: 'short second page ends the listing');
    });

    test('stops at max', () async {
      final api = apiWith((_) async => json([
            for (var i = 0; i < 20; i++)
              {
                'task': {'id': 'tsk-$i', 'name': 't'},
                'cursor': 'c$i',
              }
          ]));

      final tasks = await api.tasks.list(pageSize: 20, max: 3).toList();
      expect(tasks, hasLength(3));
    });

    test('empty listing yields nothing', () async {
      final api = apiWith((_) async => json(<Object?>[]));
      expect(await api.tasks.list().toList(), isEmpty);
    });
  });

  group('workflows', () {
    test('create sends a nested buildConfig', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json({'id': 'wfl-1', 'name': 'w'}, 201);
      });

      await api.workflows.create(
        name: 'w',
        ownerId: 'tea-1',
        repo: 'https://github.com/o/r',
        buildCommand: 'npm install && npm run build',
        runCommand: 'node index.js',
        rootDir: 'workflows',
      );

      final body = jsonDecode(seen.body) as Map<String, Object?>;
      final build = body['buildConfig']! as Map<String, Object?>;
      expect(build['runtime'], 'node');
      expect(build['rootDir'], 'workflows');
      expect(body['region'], 'oregon');
    });

    test('taskSlug composes from the slug, falling back to the name', () {
      final withSlug = Workflow.fromJson({
        'id': 'wfl-1',
        'name': 'Pretty Name',
        'slug': 'pretty-name',
        'buildConfig': <String, Object?>{},
      });
      expect(withSlug.taskSlug('go'), 'pretty-name/go');

      final noSlug = Workflow.fromJson({
        'id': 'wfl-2',
        'name': 'fallback',
        'buildConfig': <String, Object?>{},
      });
      expect(noSlug.taskSlug('go'), 'fallback/go');
    });

    test('version status distinguishes failure modes', () {
      expect(WorkflowVersionStatus.fromWire('ready').isSuccess, isTrue);
      expect(WorkflowVersionStatus.fromWire('build_failed').isTerminal, isTrue);
      expect(
          WorkflowVersionStatus.fromWire('registration_failed').isSuccess, isFalse);
      expect(WorkflowVersionStatus.fromWire('building').isTerminal, isFalse);
    });
  });

  group('query encoding', () {
    test('repeats keys for multi-value filters', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json(<Object?>[]);
      });

      await api.taskRuns.listPage(workflowIds: ['a', 'b'], limit: 5);

      expect(seen.url.queryParametersAll['workflowId'], ['a', 'b']);
      expect(seen.url.queryParameters['limit'], '5');
    });

    test('omits null and empty filters', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json(<Object?>[]);
      });

      await api.taskRuns.listPage(taskSlugs: const [], ownerIds: null);

      expect(seen.url.queryParameters.containsKey('taskSlug'), isFalse);
      expect(seen.url.queryParameters.containsKey('ownerId'), isFalse);
    });
  });
}
