import '../client.dart';
import '../models/workflow.dart';
import '../pagination.dart';

/// Registered task definition endpoints.
class TasksApi {
  const TasksApi(this._client);

  final RenderApiClient _client;

  Future<Page<Task>> listPage({String? cursor, int limit = 20}) async {
    final json = await _client.sendList(
      'GET',
      '/tasks',
      query: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
    );
    return Page.fromJson(json, 'task', Task.fromJson);
  }

  /// Lists every task the API key can see, across all pages.
  Stream<Task> list({int pageSize = 20, int? max}) => paginate(
        (cursor, limit) => listPage(cursor: cursor, limit: limit),
        limit: pageSize,
        max: max,
      );

  Future<Task> get(String taskId) async {
    final json = await _client.sendObject('GET', '/tasks/$taskId');
    return Task.fromJson(json);
  }
}
