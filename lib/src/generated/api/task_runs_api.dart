// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/task-runs` endpoints.
class TaskRunsEndpoints {
  const TaskRunsEndpoints(this._client);

  final RenderApiClient _client;

  /// List task runs
  ///
  /// List task runs that match the provided filters. If no filters are provided, all task runs accessible by the authenticated user are returned.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [taskSlug] An array of task slugs in the format workflow-slug/task-name. An optional version can be appended (workflow-slug/task-name:version). If no version is provided, the latest version is used.
  ///
  /// [rootTaskRunId] An array of root task run IDs to filter on
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [workflowVersionId] An array of workflow version IDs
  ///
  /// [workflowId] An array of workflow IDs
  Future<List<TaskRunWithCursor>> listTaskRuns({String? cursor, int? limit, List<String>? taskSlug, List<String>? rootTaskRunId, List<String>? ownerId, List<String>? workflowVersionId, List<String>? workflowId}) async {
    final json = await _client.sendList(
      'GET',
      '/task-runs',
      query: {
        'cursor': cursor,
        'limit': limit,
        'taskSlug': taskSlug,
        'rootTaskRunId': rootTaskRunId,
        'ownerId': ownerId,
        'workflowVersionId': workflowVersionId,
        'workflowId': workflowId,
      },
    );
    return json.whereType<Map<String, Object?>>().map(TaskRunWithCursor.fromJson).toList();
  }


  /// Run task
  ///
  /// Kicks off a run of the workflow task with the provided ID, passing the provided input data.
  Future<CreateTaskResponse> createTask({required CreateTaskRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/task-runs',
      body: body.toJson(),
    );
    return CreateTaskResponse.fromJson(json);
  }


  /// Stream realtime events (SSE)
  ///
  /// Establishes a unidirectional event stream. The server sends events as lines
  /// formatted per the SSE spec. Clients SHOULD set `Accept: text/event-stream`
  /// and keep the connection open.
  ///
  /// [taskRunIds] Filter to a subset of task run IDs.
  Future<void> streamTaskRunsEvents({required List<String> taskRunIds}) async {
    await _client.send(
      'GET',
      '/task-runs/events',
      query: {
        'taskRunIds': taskRunIds,
      },
    );
  }


  /// Retrieve task run
  ///
  /// Retrieve the workflow task run with the provided ID.
  Future<GetTaskRunResponse> getTaskRun({required String taskRunId}) async {
    final json = await _client.sendObject(
      'GET',
      '/task-runs/$taskRunId',
    );
    return GetTaskRunResponse.fromJson(json);
  }


  /// Cancel task run
  ///
  /// Cancel a running task run with the provided ID.
  Future<void> cancelTaskRun({required String taskRunId}) async {
    await _client.send(
      'DELETE',
      '/task-runs/$taskRunId',
    );
  }


}
