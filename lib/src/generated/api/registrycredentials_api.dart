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
  Future<List<RegistryCredential>> listRegistryCredentials({Object? name, Object? username, Object? type, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? cursor, Object? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(RegistryCredential.fromJson).toList();
  }


  /// Create registry credential
  ///
  /// Create a new registry credential.
  Future<RegistryCredential> createRegistryCredential({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/registrycredentials',
      body: body,
    );
    return RegistryCredential.fromJson(json);
  }


  /// Retrieve registry credential
  ///
  /// Retrieve the registry credential with the provided ID.
  Future<RegistryCredential> retrieveRegistryCredential(String registryCredentialId) async {
    final json = await _client.sendObject(
      'GET',
      '/registrycredentials/$registryCredentialId',
    );
    return RegistryCredential.fromJson(json);
  }


  /// Update registry credential
  ///
  /// Update the registry credential with the provided ID. Services that use this credential must be redeployed to use updated values.
  Future<RegistryCredential> updateRegistryCredential(String registryCredentialId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/registrycredentials/$registryCredentialId',
      body: body,
    );
    return RegistryCredential.fromJson(json);
  }


  /// Delete registry credential
  ///
  /// Delete the registry credential with the provided ID.
  Future<void> deleteRegistryCredential(String registryCredentialId) async {
    await _client.send(
      'DELETE',
      '/registrycredentials/$registryCredentialId',
    );
  }


}
