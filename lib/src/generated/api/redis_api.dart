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
  Future<List<RedisWithCursor>> listRedis({List<String>? name, List<String>? region, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) async {
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
  Future<RedisDetail> retrieveRedis({required String redisId}) async {
    final json = await _client.sendObject(
      'GET',
      '/redis/$redisId',
    );
    return RedisDetail.fromJson(json);
  }


  /// Update Redis instance
  ///
  /// Update a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<RedisDetail> updateRedis({required String redisId, required Map<String, Object?> body}) async {
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
  Future<void> deleteRedis({required String redisId}) async {
    await _client.send(
      'DELETE',
      '/redis/$redisId',
    );
  }


  /// Retrieve Redis connection info
  ///
  /// Retrieve connection info for a Redis instance by ID. Connection info includes sensitive information.
  /// This API is deprecated in favor of the Key Value API.
  Future<RedisConnectionInfo> retrieveRedisConnectionInfo({required String redisId}) async {
    final json = await _client.sendObject(
      'GET',
      '/redis/$redisId/connection-info',
    );
    return RedisConnectionInfo.fromJson(json);
  }


  /// Suspend Redis instance
  ///
  /// Suspend a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<void> suspendRedis({required String redisId}) async {
    await _client.send(
      'POST',
      '/redis/$redisId/suspend',
    );
  }


  /// Resume Redis instance
  ///
  /// Resume a Redis instance by ID. This API is deprecated in favor of the Key Value API.
  Future<void> resumeRedis({required String redisId}) async {
    await _client.send(
      'POST',
      '/redis/$redisId/resume',
    );
  }


}
