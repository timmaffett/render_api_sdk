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
  Future<List<EnvGroupMeta>> listEnvGroups({Object? name, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? environmentId, Object? cursor, Object? limit}) async {
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
  Future<Map<String, Object?>> createEnvGroup({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/env-groups',
      body: body,
    );
    return json;
  }


  /// Retrieve environment group
  ///
  /// Retrieve an environment group by ID.
  Future<Map<String, Object?>> retrieveEnvGroup(String envGroupId) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId',
    );
    return json;
  }


  /// Update environment group
  ///
  /// Update the attributes of an environment group.
  Future<Map<String, Object?>> updateEnvGroup(String envGroupId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/env-groups/$envGroupId',
      body: body,
    );
    return json;
  }


  /// Delete environment group
  ///
  /// Delete the environment group with the provided ID, including all environment variables and secret files it contains.
  Future<void> deleteEnvGroup(String envGroupId) async {
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
  Future<Map<String, Object?>> linkServiceToEnvGroup(String envGroupId, String serviceId) async {
    final json = await _client.sendObject(
      'POST',
      '/env-groups/$envGroupId/services/$serviceId',
    );
    return json;
  }


  /// Unlink service
  ///
  /// Unlink a particular service from a particular environment group.
  ///
  /// The service will lose access to the environment variables and secret files in the group.
  Future<void> unlinkServiceFromEnvGroup(String envGroupId, String serviceId) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/services/$serviceId',
    );
  }


  /// Retrieve environment variable
  ///
  /// Retrieve a particular environment variable in a particular environment group.
  Future<EnvVar> retrieveEnvGroupEnvVar(String envGroupId, String envVarKey) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
    );
    return EnvVar.fromJson(json);
  }


  /// Add or update environment variable
  ///
  /// Add or update a particular environment variable in a particular environment group.
  Future<Map<String, Object?>> updateEnvGroupEnvVar(String envGroupId, String envVarKey, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
      body: body,
    );
    return json;
  }


  /// Remove environment variable
  ///
  /// Remove a particular environment variable from a particular environment group.
  Future<void> deleteEnvGroupEnvVar(String envGroupId, String envVarKey) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/env-vars/$envVarKey',
    );
  }


  /// Retrieve secret file
  ///
  /// Retrieve a particular secret file in a particular environment group.
  Future<SecretFile> retrieveEnvGroupSecretFile(String envGroupId, String envVarKey) async {
    final json = await _client.sendObject(
      'GET',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
    );
    return SecretFile.fromJson(json);
  }


  /// Add or update secret file
  ///
  /// Add or update a particular secret file in an particular environment group.
  Future<Map<String, Object?>> updateEnvGroupSecretFile(String envGroupId, String envVarKey, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
      body: body,
    );
    return json;
  }


  /// Remove secret file
  ///
  /// Remove a particular secret file from a particular environment group.
  Future<void> deleteEnvGroupSecretFile(String envGroupId, String envVarKey) async {
    await _client.send(
      'DELETE',
      '/env-groups/$envGroupId/secret-files/$envVarKey',
    );
  }


}
