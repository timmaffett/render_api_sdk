// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/env-groups` endpoints.
class EnvGroupsEndpoints {
  const EnvGroupsEndpoints(this._client);

  final RenderApiClient _client;

  /// List environment groups
  ///
  /// List environment groups matching the provided filters. If no filters are provided, all environment groups are returned.
  ///
  /// [name] Filter by name
  ///
  /// [createdBefore] Filter for resources created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for resources created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedBefore] Filter for resources updated before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedAfter] Filter for resources updated after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [environmentId] Filter for resources that belong to an environment
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<EnvGroupMeta>> listEnvGroups({List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/env-groups',
      query: {
        'name': name,
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
    return json.whereType<Map<String, Object?>>().map(EnvGroupMeta.fromJson).toList();
  }


  /// Create environment group
  ///
  /// Create a new environment group.
  Future<EnvGroup> createEnvGroup({required EnvGroupPostinput body}) async {
    final json = await _client.sendObject(
      'POST',
      '/env-groups',
      body: body.toJson(),
    );
    return EnvGroup.fromJson(json);
  }


  /// Retrieve environment group
  ///
  /// Retrieve an environment group by ID.
  Future<EnvGroup> retrieveEnvGroup({required String envGroupId}) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId',
    );
    return EnvGroup.fromJson(json);
  }


  /// Update environment group
  ///
  /// Update the attributes of an environment group.
  Future<EnvGroup> updateEnvGroup({required String envGroupId, required EnvGroupPatchinput body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/env-groups/$envGroupId',
      body: body.toJson(),
    );
    return EnvGroup.fromJson(json);
  }


  /// Delete environment group
  ///
  /// Delete the environment group with the provided ID, including all environment variables and secret files it contains.
  Future<void> deleteEnvGroup({required String envGroupId}) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId',
    );
  }


  /// Link service
  ///
  /// Link a particular service to a particular environment group.
  ///
  /// The linked service will have access to the environment variables and secret files in the group.
  Future<EnvGroup> linkServiceToEnvGroup({required String envGroupId, required String serviceId}) async {
    final json = await _client.sendObject(
      'POST',
      '/env-groups/$envGroupId/services/$serviceId',
    );
    return EnvGroup.fromJson(json);
  }


  /// Unlink service
  ///
  /// Unlink a particular service from a particular environment group.
  ///
  /// The service will lose access to the environment variables and secret files in the group.
  Future<void> unlinkServiceFromEnvGroup({required String envGroupId, required String serviceId}) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/services/$serviceId',
    );
  }


  /// Retrieve environment variable
  ///
  /// Retrieve a particular environment variable in a particular environment group.
  Future<EnvVar> retrieveEnvGroupEnvVar({required String envGroupId, required String envVarKey}) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
    );
    return EnvVar.fromJson(json);
  }


  /// Add or update environment variable
  ///
  /// Add or update a particular environment variable in a particular environment group.
  Future<EnvGroup> updateEnvGroupEnvVar({required String envGroupId, required String envVarKey, required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
      body: body,
    );
    return EnvGroup.fromJson(json);
  }


  /// Remove environment variable
  ///
  /// Remove a particular environment variable from a particular environment group.
  Future<void> deleteEnvGroupEnvVar({required String envGroupId, required String envVarKey}) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
    );
  }


  /// Retrieve secret file
  ///
  /// Retrieve a particular secret file in a particular environment group.
  Future<SecretFile> retrieveEnvGroupSecretFile({required String envGroupId, required String envVarKey}) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
    );
    return SecretFile.fromJson(json);
  }


  /// Add or update secret file
  ///
  /// Add or update a particular secret file in an particular environment group.
  Future<EnvGroup> updateEnvGroupSecretFile({required String envGroupId, required String envVarKey, required UpdateEnvGroupSecretFileRequest body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
      body: body.toJson(),
    );
    return EnvGroup.fromJson(json);
  }


  /// Remove secret file
  ///
  /// Remove a particular secret file from a particular environment group.
  Future<void> deleteEnvGroupSecretFile({required String envGroupId, required String envVarKey}) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
    );
  }


}
