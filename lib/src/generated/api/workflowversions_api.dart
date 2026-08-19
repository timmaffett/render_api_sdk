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
  Future<List<WorkflowVersionWithCursor>> listWorkflowVersions({Object? ownerId, Object? workflowId, Object? workflowVersionId, Object? cursor, Object? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(WorkflowVersionWithCursor.fromJson).toList();
  }


  /// Deploy a workflow version
  ///
  /// Creates and deploys a new version of a workflow.
  Future<void> createWorkflowVersion({required Map<String, Object?> body}) async {
    await _client.send(
      'POST',
      '/workflowversions',
      body: body,
    );
  }


  /// Retrieve workflow version
  ///
  /// Retrieve the specific workflow service version with the provided ID.
  Future<Map<String, Object?>> getWorkflowVersion(String workflowVersionId) async {
    final json = await _client.sendObject(
      'GET',
      '/workflowversions/$workflowVersionId',
    );
    return json;
  }


}
