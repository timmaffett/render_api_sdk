// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/blueprints` endpoints.
class BlueprintsEndpoints {
  const BlueprintsEndpoints(this._client);

  final RenderApiClient _client;

  /// List Blueprints
  ///
  /// List Blueprints for the specified workspaces. If no workspaces are provided, returns all Blueprints the API key has access to.
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<BlueprintWithCursor>> listBlueprints({
    List<String>? ownerId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/blueprints',
      query: {'ownerId': ownerId, 'cursor': cursor, 'limit': limit},
    );
    return _client.decode(
      'GET',
      '/blueprints',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(BlueprintWithCursor.fromJson)
          .toList(),
    );
  }

  /// Validate Blueprint
  ///
  /// Validate a `render.yaml` Blueprint file without creating or modifying any resources. This endpoint checks the syntax and structure of the Blueprint, validates that all required fields are present, and returns a plan indicating the resources that would be created.
  ///
  /// Requests to this endpoint use `Content-Type: multipart/form-data`. The request body (including the Blueprint file) cannot exceed 10MB in size.
  Future<ValidateBlueprintResponse> validateBlueprint() async {
    final json = await _client.sendObject('POST', '/blueprints/validate');
    return _client.decode(
      'POST',
      '/blueprints/validate',
      json,
      () => ValidateBlueprintResponse.fromJson(json),
    );
  }

  /// Retrieve Blueprint
  ///
  /// Retrieve the Blueprint with the provided ID.
  Future<RetrieveBlueprintResponse> retrieveBlueprint({
    required String blueprintId,
  }) async {
    final json = await _client.sendObject('GET', '/blueprints/$blueprintId');
    return _client.decode(
      'GET',
      '/blueprints/$blueprintId',
      json,
      () => RetrieveBlueprintResponse.fromJson(json),
    );
  }

  /// Update Blueprint
  ///
  /// Update the Blueprint with the provided ID.
  Future<UpdateBlueprintResponse> updateBlueprint({
    required String blueprintId,
    required UpdateBlueprintRequest body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/blueprints/$blueprintId',
      body: body.toJson(),
    );
    return _client.decode(
      'PATCH',
      '/blueprints/$blueprintId',
      json,
      () => UpdateBlueprintResponse.fromJson(json),
    );
  }

  /// Disconnect Blueprint
  ///
  /// Disconnect the Blueprint with the provided ID.
  ///
  /// Disconnecting a Blueprint stops automatic resource syncing via the associated `render.yaml` file. It does not _delete_ any services or other resources that were managed by the blueprint.
  Future<void> disconnectBlueprint({required String blueprintId}) async {
    await _client.send('DELETE', '/blueprints/$blueprintId');
  }

  /// List Blueprint syncs
  ///
  /// List syncs for the Blueprint with the provided ID.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<SyncWithCursor>> listBlueprintSyncs({
    required String blueprintId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/blueprints/$blueprintId/syncs',
      query: {'cursor': cursor, 'limit': limit},
    );
    return _client.decode(
      'GET',
      '/blueprints/$blueprintId/syncs',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(SyncWithCursor.fromJson)
          .toList(),
    );
  }
}
