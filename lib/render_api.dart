/// A typed Dart client for the Render REST API.
///
/// Covers the workflows surface — workflow services, versions, task
/// definitions and task runs — over `https://api.render.com/v1`.
///
/// ```dart
/// final render = RenderApi();            // reads RENDER_API_KEY
/// final run = await render.taskRuns.run('my-workflow/sumSquares', [[2, 3, 4]]);
/// print(run.result);                     // 29
/// render.close();
/// ```
library;

import 'package:http/http.dart' as http;

import 'src/api/tasks_api.dart';
import 'src/api/task_runs_api.dart';
import 'src/api/workflows_api.dart';
import 'src/client.dart';
import 'src/generated/endpoints.dart';

export 'src/api/task_runs_api.dart' show TaskRunsApi, TaskRunListX;
export 'src/api/tasks_api.dart' show TasksApi;
export 'src/api/workflows_api.dart' show WorkflowsApi;
export 'src/client.dart'
    show RenderApiClient, kRenderBaseUrl, kRenderLocalDevUrl;
export 'src/exceptions.dart' hide exceptionFor, hintFor;
export 'src/models/enums.dart';
export 'src/models/task_run.dart';
export 'src/models/workflow.dart';
export 'src/generated/generated.dart';
export 'src/generated/endpoints.dart' show RenderEndpoints;
export 'src/pagination.dart' show Page, paginate;

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
  RenderApi.fromClient(this.client)
      : workflows = WorkflowsApi(client),
        tasks = TasksApi(client),
        taskRuns = TaskRunsApi(client),
        raw = RenderEndpoints(client);

  /// Points at the CLI's local task server (`render workflows dev`).
  ///
  /// Only task endpoints are simulated there; workflow and version endpoints
  /// will fail.
  factory RenderApi.localDev({String? url, http.Client? httpClient}) =>
      RenderApi.fromClient(
        RenderApiClient.localDev(url: url, httpClient: httpClient),
      );

  /// The underlying transport. Use it for endpoints this package does not
  /// model yet.
  final RenderApiClient client;

  /// Workflow services and their versions.
  final WorkflowsApi workflows;

  /// Registered task definitions.
  final TasksApi tasks;

  /// Task runs: starting, inspecting, cancelling and watching.
  final TaskRunsApi taskRuns;

  /// Every endpoint in the Render API, generated from the spec — services,
  /// databases, deploys, metrics, environments and the rest.
  ///
  /// Complete but literal. Where a hand-written facade exists above
  /// ([workflows], [tasks], [taskRuns]), prefer it: those add pagination as a
  /// `Stream`, local validation, and errors that explain themselves.
  ///
  /// ```dart
  /// final services = await render.raw.services.listServices();
  /// ```
  final RenderEndpoints raw;

  /// Releases the underlying HTTP client.
  void close() => client.close();
}
