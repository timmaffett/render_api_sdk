// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/workflowversions` endpoints.
class WorkflowversionsEndpoints {
  const WorkflowversionsEndpoints(this._client);

  final RenderApiClient _client;

  /// List workflow versions
  ///
  /// List known versions of the workflow service with the provided ID.
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [workflowId] The IDs of the workflows to return resources for
  ///
  /// [workflowVersionId] The IDs of the workflow versions to return resources for
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<WorkflowVersionWithCursor>> listWorkflowVersions({
    List<String>? ownerId,
    List<String>? workflowId,
    List<String>? workflowVersionId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/workflowversions',
      query: {
        'ownerId': ownerId,
        'workflowID': workflowId,
        'workflowVersionId': workflowVersionId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return _client.decode(
      'GET',
      '/workflowversions',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(WorkflowVersionWithCursor.fromJson)
          .toList(),
    );
  }

  /// Deploy a workflow version
  ///
  /// Creates and deploys a new version of a workflow.
  Future<void> createWorkflowVersion({
    required CreateWorkflowVersionRequest body,
  }) async {
    await _client.send('POST', '/workflowversions', body: body.toJson());
  }

  /// Retrieve workflow version
  ///
  /// Retrieve the specific workflow service version with the provided ID.
  Future<GetWorkflowVersionResponse> getWorkflowVersion({
    required String workflowVersionId,
  }) async {
    final json = await _client.sendObject(
      'GET',
      '/workflowversions/$workflowVersionId',
    );
    return _client.decode(
      'GET',
      '/workflowversions/$workflowVersionId',
      json,
      () => GetWorkflowVersionResponse.fromJson(json),
    );
  }
}
