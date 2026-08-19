// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/workflows` endpoints.
class WorkflowsEndpoints {
  const WorkflowsEndpoints(this._client);

  final RenderApiClient _client;

  /// List workflows
  ///
  /// List workflows that match the provided filters. If no filters are provided, all workflows accessible by the authenticated user are returned.
  ///
  /// [name] Filter by name
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [workflowId] The IDs of the workflows to return resources for
  ///
  /// [environmentId] Filter for resources that belong to an environment
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<WorkflowWithCursor>> listWorkflows({List<String>? name, List<String>? ownerId, List<String>? workflowId, List<String>? environmentId, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/workflows',
      query: {
        'name': name,
        'ownerId': ownerId,
        'workflowID': workflowId,
        'environmentId': environmentId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(WorkflowWithCursor.fromJson).toList();
  }


  /// Create a workflow
  ///
  /// Create a new workflow service with the specified configuration.
  Future<Map<String, Object?>> createWorkflow({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/workflows',
      body: body,
    );
    return json;
  }


  /// Retrieve workflow
  ///
  /// Retrieve the workflow service with the provided ID.
  Future<Map<String, Object?>> getWorkflow({required String workflowId}) async {
    final json = await _client.sendObject(
      'GET',
      '/workflows/$workflowId',
    );
    return json;
  }


  /// Update workflow
  ///
  /// Update the workflow service with the provided ID.
  Future<Map<String, Object?>> updateWorkflow({required String workflowId, required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/workflows/$workflowId',
      body: body,
    );
    return json;
  }


  /// Delete workflow
  ///
  /// Delete the workflow service with the provided ID.
  Future<void> deleteWorkflow({required String workflowId}) async {
    await _client.send(
      'DELETE',
      '/workflows/$workflowId',
    );
  }


}
