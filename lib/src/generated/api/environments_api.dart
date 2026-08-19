// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/environments` endpoints.
class EnvironmentsEndpoints {
  const EnvironmentsEndpoints(this._client);

  final RenderApiClient _client;

  /// List environments
  ///
  /// List a particular project's environments matching the provided filters. If no filters are provided, all environments are returned.
  Future<List<EnvironmentWithCursor>> listEnvironments({Object? name, required Object? projectId, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? environmentId, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/environments',
      query: {
        'name': name,
        'projectId': projectId,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'ownerId': ownerId,
        'environmentId': environmentId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(EnvironmentWithCursor.fromJson).toList();
  }


  /// Create environment
  ///
  /// Create a new environment belonging to the project with the provided ID.
  Future<Environment> createEnvironment({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/environments',
      body: body,
    );
    return Environment.fromJson(json);
  }


  /// Retrieve environment
  ///
  /// Retrieve the environment with the provided ID.
  Future<Environment> retrieveEnvironment(String environmentId) async {
    final json = await _client.sendObject(
      'GET',
      '/environments/$environmentId',
    );
    return Environment.fromJson(json);
  }


  /// Update environment
  ///
  /// Update the details of the environment with the provided ID.
  Future<Environment> updateEnvironment(String environmentId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/environments/$environmentId',
      body: body,
    );
    return Environment.fromJson(json);
  }


  /// Delete environment
  ///
  /// Delete the environment with the provided ID.
  ///
  /// Requires the environment to be empty (i.e., it must contain no services or other resources). Otherwise, deletion fails with a `409` response.
  ///
  /// To delete a non-empty environment, do one of the following:
  /// - First move or delete all contained services and other resources.
  /// - Delete the environment in the [Render Dashboard](https://dashboard.render.com).
  Future<void> deleteEnvironment(String environmentId) async {
    await _client.send(
      'DELETE',
      '/environments/$environmentId',
    );
  }


  /// Add resources to environment
  ///
  /// Add resources to the environment with the provided ID.
  Future<Environment> addResourcesToEnvironment(String environmentId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/environments/$environmentId/resources',
      body: body,
    );
    return Environment.fromJson(json);
  }


  /// Remove resources from environment
  ///
  /// Remove resources from the environment with the provided ID.
  Future<void> removeResourcesFromEnvironment(String environmentId, {required Object? resourceIds}) async {
    await _client.send(
      'DELETE',
      '/environments/$environmentId/resources',
      query: {
        'resourceIds': resourceIds,
      },
    );
  }


}
