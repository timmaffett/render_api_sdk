// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/key-value` endpoints.
class KeyValueEndpoints {
  const KeyValueEndpoints(this._client);

  final RenderApiClient _client;

  /// List Key Value instances
  ///
  /// List Key Value instances matching the provided filters. If no filters are provided, all Key Value instances are returned.
  ///
  /// [name] Filter by name
  ///
  /// [region] Filter by resource region
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
  Future<List<KeyValueWithCursor>> listKeyValue({
    List<String>? name,
    List<String>? region,
    String? createdBefore,
    String? createdAfter,
    String? updatedBefore,
    String? updatedAfter,
    List<String>? ownerId,
    List<String>? environmentId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/key-value',
      query: {
        'name': name,
        'region': region,
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
    return _client.decode(
      'GET',
      '/key-value',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(KeyValueWithCursor.fromJson)
          .toList(),
    );
  }

  /// Create Key Value instance
  ///
  /// Create a new Key Value instance.
  Future<KeyValueDetail> createKeyValue({
    required KeyValuePostinput body,
  }) async {
    final json = await _client.sendObject(
      'POST',
      '/key-value',
      body: body.toJson(),
    );
    return _client.decode(
      'POST',
      '/key-value',
      json,
      () => KeyValueDetail.fromJson(json),
    );
  }

  /// Retrieve Key Value instance
  ///
  /// Retrieve a Key Value instance by ID.
  Future<KeyValueDetail> retrieveKeyValue({required String redisId}) async {
    final json = await _client.sendObject('GET', '/key-value/$redisId');
    return _client.decode(
      'GET',
      '/key-value/$redisId',
      json,
      () => KeyValueDetail.fromJson(json),
    );
  }

  /// Update Key Value instance
  ///
  /// Update a Key Value instance by ID. Note that changing your plan, max memory policy, or persistence mode will restart your Key Value instance.
  Future<KeyValueDetail> updateKeyValue({
    required String redisId,
    required KeyValuePatchinput body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/key-value/$redisId',
      body: body.toJson(),
    );
    return _client.decode(
      'PATCH',
      '/key-value/$redisId',
      json,
      () => KeyValueDetail.fromJson(json),
    );
  }

  /// Delete Key Value instance
  ///
  /// Delete a Key Value instance by ID.
  Future<void> deleteKeyValue({required String redisId}) async {
    await _client.send('DELETE', '/key-value/$redisId');
  }

  /// Retrieve Key Value connection info
  ///
  /// Retrieve connection info for a Key Value instance by ID. Connection info includes sensitive information.
  Future<KeyValueConnectionInfo> retrieveKeyValueConnectionInfo({
    required String redisId,
  }) async {
    final json = await _client.sendObject(
      'GET',
      '/key-value/$redisId/connection-info',
    );
    return _client.decode(
      'GET',
      '/key-value/$redisId/connection-info',
      json,
      () => KeyValueConnectionInfo.fromJson(json),
    );
  }

  /// Suspend Key Value instance
  ///
  /// Suspend a Key Value instance by ID.
  Future<void> suspendKeyValue({required String redisId}) async {
    await _client.send('POST', '/key-value/$redisId/suspend');
  }

  /// Resume Key Value instance
  ///
  /// Resume a Key Value instance by ID.
  Future<void> resumeKeyValue({required String redisId}) async {
    await _client.send('POST', '/key-value/$redisId/resume');
  }
}
