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
  Future<List<BlueprintWithCursor>> listBlueprints({Object? ownerId, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/blueprints',
      query: {
        'ownerId': ownerId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(BlueprintWithCursor.fromJson).toList();
  }


  /// Validate Blueprint
  ///
  /// Validate a `render.yaml` Blueprint file without creating or modifying any resources. This endpoint checks the syntax and structure of the Blueprint, validates that all required fields are present, and returns a plan indicating the resources that would be created.
  ///
  /// Requests to this endpoint use `Content-Type: multipart/form-data`. The request body (including the Blueprint file) cannot exceed 10MB in size.
  Future<Map<String, Object?>> validateBlueprint() async {
    final json = await _client.sendObject(
      'POST',
      '/blueprints/validate',
    );
    return json;
  }


  /// Retrieve Blueprint
  ///
  /// Retrieve the Blueprint with the provided ID.
  Future<Map<String, Object?>> retrieveBlueprint(String blueprintId) async {
    final json = await _client.sendObject(
      'GET',
      '/blueprints/$blueprintId',
    );
    return json;
  }


  /// Update Blueprint
  ///
  /// Update the Blueprint with the provided ID.
  Future<Map<String, Object?>> updateBlueprint(String blueprintId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/blueprints/$blueprintId',
      body: body,
    );
    return json;
  }


  /// Disconnect Blueprint
  ///
  /// Disconnect the Blueprint with the provided ID.
  ///
  /// Disconnecting a Blueprint stops automatic resource syncing via the associated `render.yaml` file. It does not _delete_ any services or other resources that were managed by the blueprint.
  Future<void> disconnectBlueprint(String blueprintId) async {
    await _client.send(
      'DELETE',
      '/blueprints/$blueprintId',
    );
  }


  /// List Blueprint syncs
  ///
  /// List syncs for the Blueprint with the provided ID.
  Future<List<SyncWithCursor>> listBlueprintSyncs(String blueprintId, {Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/blueprints/$blueprintId/syncs',
      query: {
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(SyncWithCursor.fromJson).toList();
  }


}
