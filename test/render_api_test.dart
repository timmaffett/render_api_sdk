import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:render_api/render_api.dart';
import 'package:test/test.dart';

/// A minimal valid body, now that request bodies are typed rather than maps.
CreateWorkflowRequest workflowBody() => CreateWorkflowRequest(
      name: 'w',
      ownerId: 'tea-1',
      runCommand: 'node index.js',
      region: Region.oregon,
      buildConfig: CreateWorkflowRequestBuildConfig(
        repo: 'https://github.com/o/r',
        buildCommand: 'npm install',
        runtime: Runtime.node,
      ),
    );

/// Builds an API whose transport is driven by [handler], so tests need no
/// credentials and no network.
RenderApi apiWith(
  Future<http.Response> Function(http.Request) handler, {
  int maxRetries = 3,
}) =>
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
        return json(<Object?>[]);
      });

      await api.listOwners(limit: 5);

      expect(seen.headers['Authorization'], 'Bearer test-token');
      expect(seen.headers['Accept'], 'application/json');
      expect(seen.url.path, endsWith('/owners'));
    });
  });

  group('error mapping', () {
    test('402 explains that Workflows require billing', () async {
      final api = apiWith((_) async => http.Response('payment required', 402));

      await expectLater(
        api.listOwners(),
        throwsA(isA<RenderPaymentRequiredException>()
            .having((e) => e.hint, 'hint', contains('payment method'))),
      );
    });

    test('500 on workflow creation blames repository access', () async {
      // The live API returns exactly this, with no usable detail, when its Git
      // app cannot read the repo. Turning that into something actionable is
      // most of the reason this client exists.
      final api =
          apiWith((_) async => http.Response('internal server error', 500));

      await expectLater(
        api.createWorkflow(body: workflowBody()),
        throwsA(isA<RenderServerException>()
            .having((e) => e.hint, 'hint', contains('grant'))),
      );
    });

    test('404 is typed', () async {
      final api = apiWith((_) async => http.Response('', 404));

      await expectLater(
        api.retrieveService(serviceId: 'srv-nope'),
        throwsA(isA<RenderNotFoundException>()
            .having((e) => e.statusCode, 'statusCode', 404)),
      );
    });

    test('429 surfaces Retry-After', () async {
      final api = apiWith(
        (_) async =>
            http.Response('slow down', 429, headers: {'retry-after': '7'}),
        maxRetries: 0,
      );

      await expectLater(
        api.listOwners(),
        throwsA(isA<RenderRateLimitException>().having(
          (e) => e.retryAfter,
          'retryAfter',
          const Duration(seconds: 7),
        )),
      );
    });
  });

  group('retry policy', () {
    test('retries 5xx on GET', () async {
      var calls = 0;
      final api = apiWith((_) async {
        calls++;
        return calls < 3 ? http.Response('boom', 503) : json(<Object?>[]);
      });

      await api.listOwners();
      expect(calls, 3);
    });

    test('does NOT retry 5xx on POST, which could double-create', () async {
      var calls = 0;
      final api = apiWith((_) async {
        calls++;
        return http.Response('boom', 500);
      });

      await expectLater(
        api.createWorkflow(body: workflowBody()),
        throwsA(isA<RenderServerException>()),
      );
      expect(calls, 1);
    });
  });

  group('query encoding', () {
    test('repeats keys for multi-value filters', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json(<Object?>[]);
      });

      await api.listHeaders(
        serviceId: 'srv-1',
        name: const ['a', 'b'],
        limit: 5,
      );

      expect(seen.url.queryParametersAll['name'], ['a', 'b']);
      expect(seen.url.queryParameters['limit'], '5');
      expect(seen.url.path, contains('/services/srv-1/headers'));
    });

    test('omits null and empty filters', () async {
      late http.Request seen;
      final api = apiWith((req) async {
        seen = req;
        return json(<Object?>[]);
      });

      await api.listHeaders(serviceId: 'srv-1', name: const [], path: null);

      expect(seen.url.queryParameters.containsKey('name'), isFalse);
      expect(seen.url.queryParameters.containsKey('path'), isFalse);
    });
  });

  group('generated models', () {
    test('decode a typed response', () async {
      final api = apiWith((_) async => json({
            'id': 'wfl-1',
            'name': 'my-workflow',
            'ownerId': 'tea-1',
            'runCommand': 'node index.js',
            'region': 'oregon',
            'buildConfig': {
              'repo': 'https://github.com/o/r',
              'buildCommand': 'npm install',
              'runtime': 'node',
            },
          }));

      final workflow = await api.getWorkflow(workflowId: 'wfl-1');
      expect(workflow.name, 'my-workflow');
      expect(workflow.region, Region.oregon);
      expect(workflow.buildConfig.runtime.wireValue, 'node');
    });

    test('decode an unknown enum value instead of throwing', () {
      // Render ships new values without warning; a client that is otherwise
      // fine must not crash on one.
      expect(Region.fromWire('mars'), Region.unknown);
      expect(Region.fromWire('oregon'), Region.oregon);
    });
  });

  group('flat and grouped forms', () {
    test('are the same call by different routes', () async {
      final seen = <String>[];
      final api = apiWith((req) async {
        seen.add(req.url.path);
        return json(<Object?>[]);
      });

      await api.listWorkflows(limit: 3);
      await api.raw.workflows.listWorkflows(limit: 3);

      expect(seen, hasLength(2));
      expect(seen.first, seen.last);
    });
  });
}
