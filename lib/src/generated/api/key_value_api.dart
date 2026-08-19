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
  Future<List<KeyValueWithCursor>> listKeyValue({Object? name, Object? region, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? environmentId, Object? cursor, Object? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(KeyValueWithCursor.fromJson).toList();
  }


  /// Create Key Value instance
  ///
  /// Create a new Key Value instance.
  Future<KeyValueDetail> createKeyValue({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/key-value',
      body: body,
    );
    return KeyValueDetail.fromJson(json);
  }


  /// Retrieve Key Value instance
  ///
  /// Retrieve a Key Value instance by ID.
  Future<KeyValueDetail> retrieveKeyValue(String redisId) async {
    final json = await _client.sendObject(
      'GET',
      '/key-value/$redisId',
    );
    return KeyValueDetail.fromJson(json);
  }


  /// Update Key Value instance
  ///
  /// Update a Key Value instance by ID. Note that changing your plan, max memory policy, or persistence mode will restart your Key Value instance.
  Future<KeyValueDetail> updateKeyValue(String redisId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/key-value/$redisId',
      body: body,
    );
    return KeyValueDetail.fromJson(json);
  }


  /// Delete Key Value instance
  ///
  /// Delete a Key Value instance by ID.
  Future<void> deleteKeyValue(String redisId) async {
    await _client.send(
      'DELETE',
      '/key-value/$redisId',
    );
  }


  /// Retrieve Key Value connection info
  ///
  /// Retrieve connection info for a Key Value instance by ID. Connection info includes sensitive information.
  Future<KeyValueConnectionInfo> retrieveKeyValueConnectionInfo(String redisId) async {
    final json = await _client.sendObject(
      'GET',
      '/key-value/$redisId/connection-info',
    );
    return KeyValueConnectionInfo.fromJson(json);
  }


  /// Suspend Key Value instance
  ///
  /// Suspend a Key Value instance by ID.
  Future<void> suspendKeyValue(String redisId) async {
    await _client.send(
      'POST',
      '/key-value/$redisId/suspend',
    );
  }


  /// Resume Key Value instance
  ///
  /// Resume a Key Value instance by ID.
  Future<void> resumeKeyValue(String redisId) async {
    await _client.send(
      'POST',
      '/key-value/$redisId/resume',
    );
  }


}
