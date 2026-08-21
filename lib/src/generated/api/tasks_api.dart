// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/tasks` endpoints.
class TasksEndpoints {
  const TasksEndpoints(this._client);

  final RenderApiClient _client;

  /// List tasks
  ///
  /// List workflow tasks that match the provided filters. If no filters are provided, all task definitions accessible by the authenticated user are returned.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [taskSlug] An array of task slugs in the format workflow-slug/task-name. An optional version can be appended (workflow-slug/task-name:version). If no version is provided, the latest version is used.
  ///
  /// [workflowVersionId] An array of workflow version IDs
  ///
  /// [workflowId] An array of workflow IDs
  Future<List<TaskWithCursor>> listTasks({
    String? cursor,
    int? limit,
    List<String>? ownerId,
    List<String>? taskSlug,
    List<String>? workflowVersionId,
    List<String>? workflowId,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/tasks',
      query: {
        'cursor': cursor,
        'limit': limit,
        'ownerId': ownerId,
        'taskSlug': taskSlug,
        'workflowVersionId': workflowVersionId,
        'workflowId': workflowId,
      },
    );
    return _client.decode(
      'GET',
      '/tasks',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(TaskWithCursor.fromJson)
          .toList(),
    );
  }

  /// Retrieve task
  ///
  /// Retrieve the workflow task with the provided ID.
  Future<GetTaskResponse> getTask({required String taskId}) async {
    final json = await _client.sendObject('GET', '/tasks/$taskId');
    return _client.decode(
      'GET',
      '/tasks/$taskId',
      json,
      () => GetTaskResponse.fromJson(json),
    );
  }
}
