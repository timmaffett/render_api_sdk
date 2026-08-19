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
  Future<List<TaskWithCursor>> listTasks({Object? cursor, Object? limit, Object? ownerId, Object? taskSlug, Object? workflowVersionId, Object? workflowId}) async {
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
    return json.whereType<Map<String, Object?>>().map(TaskWithCursor.fromJson).toList();
  }


  /// Retrieve task
  ///
  /// Retrieve the workflow task with the provided ID.
  Future<Map<String, Object?>> getTask(String taskId) async {
    final json = await _client.sendObject(
      'GET',
      '/tasks/$taskId',
    );
    return json;
  }


}
