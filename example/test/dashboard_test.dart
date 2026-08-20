// Renders each page against canned Render responses.
//
//   flutter test
//
// No token and no network: render_api's `RenderApi.fromClient` takes any
// `http.Client`, so a MockClient stands in for api.render.com. That makes
// these tests the one place the example is verified end to end on a machine
// without an Xcode new enough to build for macOS.
//
// They also pin the two things about the package every caller meets: list
// endpoints return `<Thing>WithCursor` wrappers, and errors carry a hint worth
// showing verbatim.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:render_api/render_api.dart';
import 'package:render_dashboard/src/data/render_client.dart';
import 'package:render_dashboard/src/pages/databases_page.dart';
import 'package:render_dashboard/src/pages/services_page.dart';
import 'package:render_dashboard/src/pages/workspace_page.dart';
import 'package:auris/auris.dart';

RenderClient clientReturning(Map<String, Object?> Function(Uri) respond) {
  final http.Client mock = MockClient((request) async {
    final body = respond(request.url);
    return http.Response(
      jsonEncode(body['json']),
      body['status'] as int? ?? 200,
      headers: const {'content-type': 'application/json'},
    );
  });
  return RenderClient.fromApi(
    RenderApi.fromClient(RenderApiClient(token: 'test', httpClient: mock)),
  );
}

void main() {
  // Every page reads AurisScheme off the theme, so these render under the
  // real AurisTheme rather than a bare ThemeData.
  Widget themed(Widget child) => MaterialApp(
    theme: AurisTheme.dark(),
    home: Scaffold(body: child),
  );

  testWidgets('services page lists what GET /services returned', (
    tester,
  ) async {
    final client = clientReturning(
      (url) => {
        'json': [
          {
            'service': {
              'id': 'srv-abc',
              'name': 'render-web-dart',
              'type': 'web_service',
              'repo': 'https://github.com/timmaffett/render_web_dart',
              'branch': 'main',
              'rootDir': '',
              'ownerId': 'own-1',
              'createdAt': '2026-08-20T00:00:00Z',
              'updatedAt': '2026-08-20T00:00:00Z',
              'autoDeploy': 'yes',
              'suspenders': <Object?>[],
              'serviceDetails': {
                'runtime': 'docker',
                'plan': 'free',
                'region': 'oregon',
              },
            },
            'cursor': 'c1',
          },
        ],
      },
    );
    addTearDown(client.close);

    await tester.pumpWidget(themed(ServicesPage(client: client)));
    await tester.pumpAndSettle();

    // AurisPanel renders its title uppercased, which is the house style.
    expect(find.text('RENDER-WEB-DART'), findsOneWidget);
    // The card reads serviceDetails, which arrives untyped because the spec
    // models it as a oneOf across five service types.
    expect(find.text('DOCKER'), findsOneWidget);
    expect(find.text('oregon'), findsOneWidget);
  });

  testWidgets('an empty list explains the disjoint-list trap', (tester) async {
    final client = clientReturning((_) => {'json': <Object?>[]});
    addTearDown(client.close);

    await tester.pumpWidget(themed(ServicesPage(client: client)));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Workflow services do not appear here'),
      findsOneWidget,
    );
  });

  testWidgets('a hinted error shows the hint verbatim', (tester) async {
    // Exactly what Render answers for a plan-gated metric. The status code
    // says the request was malformed; it was not.
    final client = clientReturning(
      (_) => {
        'status': 400,
        'json': {'message': 'query is not allowed for plan: Hobby'},
      },
    );
    addTearDown(client.close);

    await tester.pumpWidget(themed(DatabasesPage(client: client)));
    await tester.pumpAndSettle();

    expect(find.text('REQUEST FAILED'), findsOneWidget);
    expect(find.textContaining('instance plan'), findsOneWidget);
  });

  testWidgets('401 signs out rather than showing an error', (tester) async {
    final client = clientReturning(
      (_) => {
        'status': 401,
        'json': {'message': 'unauthorized'},
      },
    );
    addTearDown(client.close);

    var signedOut = false;
    await tester.pumpWidget(
      themed(
        WorkspacePage(client: client, onUnauthorized: () => signedOut = true),
      ),
    );
    await tester.pumpAndSettle();

    expect(signedOut, isTrue);
  });
}
