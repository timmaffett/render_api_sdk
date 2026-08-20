// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/registrycredentials` endpoints.
class RegistrycredentialsEndpoints {
  const RegistrycredentialsEndpoints(this._client);

  final RenderApiClient _client;

  /// List registry credentials
  ///
  /// List registry credentials matching the provided filters. If no filters are provided, returns all registry credentials you have permissions to view.
  ///
  /// [name] Filter for the name of a credential
  ///
  /// [username] Filter for the username of a credential
  ///
  /// [type] Filter for the registry type for the credential
  ///
  /// [createdBefore] Filter for services created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for services created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedBefore] Filter for services updated before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedAfter] Filter for services updated after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<RegistryCredential>> listRegistryCredentials({
    List<String>? name,
    List<String>? username,
    List<String>? type,
    String? createdBefore,
    String? createdAfter,
    String? updatedBefore,
    String? updatedAfter,
    List<String>? ownerId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/registrycredentials',
      query: {
        'name': name,
        'username': username,
        'type': type,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'ownerId': ownerId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json
        .whereType<Map<String, Object?>>()
        .map(RegistryCredential.fromJson)
        .toList();
  }

  /// Create registry credential
  ///
  /// Create a new registry credential.
  Future<RegistryCredential> createRegistryCredential({
    required CreateRegistryCredentialRequest body,
  }) async {
    final json = await _client.sendObject(
      'POST',
      '/registrycredentials',
      body: body.toJson(),
    );
    return RegistryCredential.fromJson(json);
  }

  /// Retrieve registry credential
  ///
  /// Retrieve the registry credential with the provided ID.
  Future<RegistryCredential> retrieveRegistryCredential({
    required String registryCredentialId,
  }) async {
    final json = await _client.sendObject(
      'GET',
      '/registrycredentials/$registryCredentialId',
    );
    return RegistryCredential.fromJson(json);
  }

  /// Update registry credential
  ///
  /// Update the registry credential with the provided ID. Services that use this credential must be redeployed to use updated values.
  Future<RegistryCredential> updateRegistryCredential({
    required String registryCredentialId,
    required UpdateRegistryCredentialRequest body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/registrycredentials/$registryCredentialId',
      body: body.toJson(),
    );
    return RegistryCredential.fromJson(json);
  }

  /// Delete registry credential
  ///
  /// Delete the registry credential with the provided ID.
  Future<void> deleteRegistryCredential({
    required String registryCredentialId,
  }) async {
    await _client.send('DELETE', '/registrycredentials/$registryCredentialId');
  }
}
