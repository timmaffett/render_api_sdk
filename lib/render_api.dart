/// A typed Dart client for the Render REST API.
///
/// The whole API over `https://api.render.com/v1` — services, Postgres, key
/// value stores, cron jobs, disks, environment groups, projects, metrics,
/// logs, notifications and workflows: 208 operations across 26 resource
/// groups, generated from Render's OpenAPI specification.
///
/// ```dart
/// final render = RenderApi(); // token from the RENDER_API_KEY env var
/// for (final entry in await render.listServices(limit: 20)) {
///   print('${entry.service.name}  ${entry.service.type.wireValue}');
/// }
/// render.close();
/// ```
///
/// Every operation has two spellings. The flat form above mirrors Render's own
/// Node examples; the grouped form says where it came from, and the two are
/// the same call:
///
/// ```dart
/// await render.raw.services.listServices(limit: 20);
/// ```
///
/// To *run* workflow tasks rather than administer them, see
/// [`package:render_workflows`](https://pub.dev/packages/render_workflows),
/// which adds run polling, SSE streaming and a typed result.
library;

import 'package:http/http.dart' as http;

import 'src/client.dart';
import 'src/generated/endpoints.dart';

export 'src/client.dart'
    show RenderApiClient, kRenderBaseUrl, kRenderLocalDevUrl;
export 'src/exceptions.dart' hide exceptionFor, hintFor;
export 'src/generated/endpoints.dart' show RenderEndpoints;
export 'src/generated/flat.dart';
export 'src/generated/generated.dart';

/// Entry point to the Render API.
///
/// Groups the endpoints by resource. Construct one and keep it: it owns an
/// HTTP client, so call [close] when finished.
class RenderApi {
  /// Creates a client.
  ///
  /// [token] defaults to the `RENDER_API_KEY` environment variable. There is
  /// no environment on the web, so a token must be passed explicitly there.
  RenderApi({
    String? token,
    String? baseUrl,
    http.Client? httpClient,
    int maxRetries = 3,
    Duration timeout = const Duration(seconds: 30),
  }) : this.fromClient(
         RenderApiClient(
           token: token,
           baseUrl: baseUrl,
           httpClient: httpClient,
           maxRetries: maxRetries,
           timeout: timeout,
         ),
       );

  /// Wraps an existing [RenderApiClient] — useful for tests, or for pointing
  /// at a different transport.
  RenderApi.fromClient(this.client) : raw = RenderEndpoints(client);

  /// Points at the CLI's local task server (`render workflows dev`).
  ///
  /// Only task endpoints are simulated there. For running tasks, prefer
  /// `package:render_workflows`, which is built for it.
  factory RenderApi.localDev({String? url, http.Client? httpClient}) =>
      RenderApi.fromClient(
        RenderApiClient.localDev(url: url, httpClient: httpClient),
      );

  /// The underlying transport. Use it for endpoints this package does not
  /// model yet.
  final RenderApiClient client;

  /// Every endpoint in the Render API, grouped by resource.
  ///
  /// The same operations the flat form exposes, reached by the group they
  /// belong to — useful when reading unfamiliar code, since the group names
  /// the part of Render being touched.
  ///
  /// ```dart
  /// final services = await render.raw.services.listServices();
  /// ```
  final RenderEndpoints raw;

  /// Releases the underlying HTTP client.
  void close() => client.close();
}
