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
  Future<CreateWorkflowResponse> createWorkflow({required CreateWorkflowRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/workflows',
      body: body.toJson(),
    );
    return CreateWorkflowResponse.fromJson(json);
  }


  /// Retrieve workflow
  ///
  /// Retrieve the workflow service with the provided ID.
  Future<GetWorkflowResponse> getWorkflow({required String workflowId}) async {
    final json = await _client.sendObject(
      'GET',
      '/workflows/$workflowId',
    );
    return GetWorkflowResponse.fromJson(json);
  }


  /// Update workflow
  ///
  /// Update the workflow service with the provided ID.
  Future<UpdateWorkflowResponse> updateWorkflow({required String workflowId, required UpdateWorkflowRequest body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/workflows/$workflowId',
      body: body.toJson(),
    );
    return UpdateWorkflowResponse.fromJson(json);
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
