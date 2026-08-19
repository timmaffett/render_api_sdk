// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/redis` endpoints.
class RedisEndpoints {
  const RedisEndpoints(this._client);

  final RenderApiClient _client;

  /// List Redis instances
  ///
  /// List Redis instances matching the provided filters. If no filters are provided, all Redis instances are returned.
  /// This API is deprecated in favor of the Key Value API.
  Future<List<RedisWithCursor>> listRedis({Object? name, Object? region, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? environmentId, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/redis',
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
    return json.whereType<Map<String, Object?>>().map(RedisWithCursor.fromJson).toList();
  }


  /// Create Redis instance
  ///
  /// Create a new Redis instance. This API is deprecated in favor of the Key Value API.
  Future<RedisDetail> createRedis({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/redis',
      body: body,
    );
    return RedisDetail.fromJson(json);
  }


  /// Retrieve Redis instance
  ///
  /// Retrieve a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<RedisDetail> retrieveRedis(String redisId) async {
    final json = await _client.sendObject(
      'GET',
      '/redis/$redisId',
    );
    return RedisDetail.fromJson(json);
  }


  /// Update Redis instance
  ///
  /// Update a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<RedisDetail> updateRedis(String redisId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/redis/$redisId',
      body: body,
    );
    return RedisDetail.fromJson(json);
  }


  /// Delete Redis instance
  ///
  /// Delete a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<void> deleteRedis(String redisId) async {
    await _client.send(
      'DELETE',
      '/redis/$redisId',
    );
  }


  /// Retrieve Redis connection info
  ///
  /// Retrieve connection info for a Redis instance by ID. Connection info includes sensitive information.
  /// This API is deprecated in favor of the Key Value API.
  Future<RedisConnectionInfo> retrieveRedisConnectionInfo(String redisId) async {
    final json = await _client.sendObject(
      'GET',
      '/redis/$redisId/connection-info',
    );
    return RedisConnectionInfo.fromJson(json);
  }


  /// Suspend Redis instance
  ///
  /// Suspend a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<void> suspendRedis(String redisId) async {
    await _client.send(
      'POST',
      '/redis/$redisId/suspend',
    );
  }


  /// Resume Redis instance
  ///
  /// Resume a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<void> resumeRedis(String redisId) async {
    await _client.send(
      'POST',
      '/redis/$redisId/resume',
    );
  }


}
