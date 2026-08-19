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
  Future<List<TaskRunWithCursor>> listTaskRuns({Object? cursor, Object? limit, Object? taskSlug, Object? rootTaskRunId, Object? ownerId, Object? workflowVersionId, Object? workflowId}) async {
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
  Future<Map<String, Object?>> createTask({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/task-runs',
      body: body,
    );
    return json;
  }


  /// Stream realtime events (SSE)
  ///
  /// Establishes a unidirectional event stream. The server sends events as lines
  /// formatted per the SSE spec. Clients SHOULD set `Accept: text/event-stream`
  /// and keep the connection open.
  Future<void> streamTaskRunsEvents({required Object? taskRunIds}) async {
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
  Future<Map<String, Object?>> getTaskRun(String taskRunId) async {
    final json = await _client.sendObject(
      'GET',
      '/task-runs/$taskRunId',
    );
    return json;
  }


  /// Cancel task run
  ///
  /// Cancel a running task run with the provided ID.
  Future<void> cancelTaskRun(String taskRunId) async {
    await _client.send(
      'DELETE',
      '/task-runs/$taskRunId',
    );
  }


}
