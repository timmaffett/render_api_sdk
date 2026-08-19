# Redis

`render.raw.redis` — 8 operations on `/redis`.

| Method | | |
| --- | --- | --- |
| [`createRedis`](#createredis) | `POST /redis` | Create Redis instance |
| [`deleteRedis`](#deleteredis) | `DELETE /redis/{redisId}` | Delete Redis instance |
| [`listRedis`](#listredis) | `GET /redis` | List Redis instances |
| [`resumeRedis`](#resumeredis) | `POST /redis/{redisId}/resume` | Resume Redis instance |
| [`retrieveRedis`](#retrieveredis) | `GET /redis/{redisId}` | Retrieve Redis instance |
| [`retrieveRedisConnectionInfo`](#retrieveredisconnectioninfo) | `GET /redis/{redisId}/connection-info` | Retrieve Redis connection info |
| [`suspendRedis`](#suspendredis) | `POST /redis/{redisId}/suspend` | Suspend Redis instance |
| [`updateRedis`](#updateredis) | `PATCH /redis/{redisId}` | Update Redis instance |

---

## createRedis

**Create Redis instance**

Create a new Redis instance. This API is deprecated in favor of the Key Value API.


```dart
Future<RedisDetail> createRedis({required RedisPostinput body})
```

`POST /redis`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `RedisPostinput` | body | yes |  |

Returns `RedisDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Redis instance |
| `createdAt` | `DateTime` | The creation time of the Redis instance |
| `updatedAt` | `DateTime` | The last updated time of the Redis instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `RedisPlan` |  |
| `name` | `String` | The name of the Redis instance |
| `owner` | `Owner` |  |
| `options` | `RedisOptions` | Options for a Redis instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Redis instance |
| `environmentId` | `String?` | The ID of the environment the Redis instance is associated with |
| `version` | `String` | The version of Redis |
| `maintenance` | `RedisDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/create-redis)

## deleteRedis

**Delete Redis instance**

Delete a Redis instance by ID. This API is deprecated in favor of the Key Value API.


```dart
Future<void> deleteRedis({required String redisId})
```

`DELETE /redis/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-redis)

## listRedis

**List Redis instances**

List Redis instances matching the provided filters. If no filters are provided, all Redis instances are returned.
This API is deprecated in favor of the Key Value API.


```dart
Future<List<RedisWithCursor>> listRedis({List<String>? name, List<String>? region, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit})
```

`GET /redis`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `region` | `List<String>` | query | no | Filter by resource region |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<RedisWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `redis` | `Redis` | A Redis instance |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-redis)

## resumeRedis

**Resume Redis instance**

Resume a Redis instance by ID. This API is deprecated in favor of the Key Value API.


```dart
Future<void> resumeRedis({required String redisId})
```

`POST /redis/{redisId}/resume`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/resume-redis)

## retrieveRedis

**Retrieve Redis instance**

Retrieve a Redis instance by ID. This API is deprecated in favor of the Key Value API.


```dart
Future<RedisDetail> retrieveRedis({required String redisId})
```

`GET /redis/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `RedisDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Redis instance |
| `createdAt` | `DateTime` | The creation time of the Redis instance |
| `updatedAt` | `DateTime` | The last updated time of the Redis instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `RedisPlan` |  |
| `name` | `String` | The name of the Redis instance |
| `owner` | `Owner` |  |
| `options` | `RedisOptions` | Options for a Redis instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Redis instance |
| `environmentId` | `String?` | The ID of the environment the Redis instance is associated with |
| `version` | `String` | The version of Redis |
| `maintenance` | `RedisDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-redis)

## retrieveRedisConnectionInfo

**Retrieve Redis connection info**

Retrieve connection info for a Redis instance by ID. Connection info includes sensitive information.
This API is deprecated in favor of the Key Value API.


```dart
Future<RedisConnectionInfo> retrieveRedisConnectionInfo({required String redisId})
```

`GET /redis/{redisId}/connection-info`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `RedisConnectionInfo`.

| Field | Type | |
| --- | --- | --- |
| `internalConnectionString` | `String` | The connection string to use from within Render |
| `externalConnectionString` | `String` | The connection string to use from outside Render |
| `redisClicommand` | `String` | The Redis CLI command to connect to the Redis instance |

[Render documentation](https://api-docs.render.com/reference/retrieve-redis-connection-info)

## suspendRedis

**Suspend Redis instance**

Suspend a Redis instance by ID. This API is deprecated in favor of the Key Value API.


```dart
Future<void> suspendRedis({required String redisId})
```

`POST /redis/{redisId}/suspend`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/suspend-redis)

## updateRedis

**Update Redis instance**

Update a Redis instance by ID. This API is deprecated in favor of the Key Value API.


```dart
Future<RedisDetail> updateRedis({required String redisId, required RedisPatchinput body})
```

`PATCH /redis/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |
| `body` | `RedisPatchinput` | body | yes |  |

Returns `RedisDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Redis instance |
| `createdAt` | `DateTime` | The creation time of the Redis instance |
| `updatedAt` | `DateTime` | The last updated time of the Redis instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `RedisPlan` |  |
| `name` | `String` | The name of the Redis instance |
| `owner` | `Owner` |  |
| `options` | `RedisOptions` | Options for a Redis instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Redis instance |
| `environmentId` | `String?` | The ID of the environment the Redis instance is associated with |
| `version` | `String` | The version of Redis |
| `maintenance` | `RedisDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/update-redis)

