# Postgres

`render.raw.postgres` — 21 operations on `/postgres`.

| Method | | |
| --- | --- | --- |
| [`createPostgres`](#createpostgres) | `POST /postgres` | Create Postgres instance |
| [`createPostgresExport`](#createpostgresexport) | `POST /postgres/{postgresId}/export` | Create Postgres export |
| [`createPostgresUser`](#createpostgresuser) | `POST /postgres/{postgresId}/credentials` | Create PostgreSQL User |
| [`deletePostgres`](#deletepostgres) | `DELETE /postgres/{postgresId}` | Delete Postgres instance |
| [`deletePostgresUser`](#deletepostgresuser) | `DELETE /postgres/{postgresId}/credentials/{username}` | Delete PostgreSQL User |
| [`failoverPostgres`](#failoverpostgres) | `POST /postgres/{postgresId}/failover` | Failover Postgres instance |
| [`listPostgres`](#listpostgres) | `GET /postgres` | List Postgres instances |
| [`listPostgresExport`](#listpostgresexport) | `GET /postgres/{postgresId}/export` | List Postgres exports |
| [`listPostgresProcesses`](#listpostgresprocesses) | `GET /postgres/{postgresId}/query/processes` | List live queries |
| [`listPostgresSizes`](#listpostgressizes) | `GET /postgres/{postgresId}/query/sizes` | List database, table, and index sizes |
| [`listPostgresTableScans`](#listpostgrestablescans) | `GET /postgres/{postgresId}/query/table-scans` | List table scans |
| [`listPostgresTopQueries`](#listpostgrestopqueries) | `GET /postgres/{postgresId}/query/top-queries` | List top queries |
| [`listPostgresUsers`](#listpostgresusers) | `GET /postgres/{postgresId}/credentials` | List PostgreSQL Users |
| [`recoverPostgres`](#recoverpostgres) | `POST /postgres/{postgresId}/recovery` | Trigger point-in-time recovery |
| [`restartPostgres`](#restartpostgres) | `POST /postgres/{postgresId}/restart` | Restart Postgres instance |
| [`resumePostgres`](#resumepostgres) | `POST /postgres/{postgresId}/resume` | Resume Postgres instance |
| [`retrievePostgres`](#retrievepostgres) | `GET /postgres/{postgresId}` | Retrieve Postgres instance |
| [`retrievePostgresConnectionInfo`](#retrievepostgresconnectioninfo) | `GET /postgres/{postgresId}/connection-info` | Retrieve Postgres connection info |
| [`retrievePostgresRecoveryInfo`](#retrievepostgresrecoveryinfo) | `GET /postgres/{postgresId}/recovery` | Retrieve point-in-time recovery status |
| [`suspendPostgres`](#suspendpostgres) | `POST /postgres/{postgresId}/suspend` | Suspend Postgres instance |
| [`updatePostgres`](#updatepostgres) | `PATCH /postgres/{postgresId}` | Update Postgres instance |

---

## createPostgres

**Create Postgres instance**

Create a new Postgres instance.


```dart
Future<PostgresDetail> createPostgres({required PostgresPostinput body})
```

`POST /postgres`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `PostgresPostinput` | body | yes |  |

Returns `PostgresDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `expiresAt` | `DateTime?` | The time at which the database will be expire. Applies to free tier databases only. |
| `dashboardUrl` | `String` | The URL to view the Postgres instance in the Render Dashboard |
| `databaseName` | `String` |  |
| `databaseUser` | `String` |  |
| `environmentId` | `String?` |  |
| `highAvailabilityEnabled` | `bool` |  |
| `maintenance` | `PostgresDetailMaintenance?` |  |
| `name` | `String` |  |
| `owner` | `Owner` |  |
| `plan` | `PostgresPostinputPlan` |  |
| `diskSizeGb` | `int?` |  |
| `parameterOverrides` | `Map<String, Object?>?` |  |
| `primaryPostgresId` | `String?` |  |
| `region` | `Region` | Defaults to "oregon" |
| `readReplicas` | `List<ReadReplica>` |  |
| `role` | `DatabaseRole` |  |
| `status` | `DatabaseStatus` |  |
| `version` | `PostgresVersion` | The PostgreSQL version |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `diskAutoscalingEnabled` | `bool` |  |
| `connectionPool` | `String` | What connection pool to use (if any) out of 'pgbouncer' and 'none' |

[Render documentation](https://api-docs.render.com/reference/create-postgres)

## createPostgresExport

**Create Postgres export**

Create an [export](https://render.com/docs/postgresql-backups#logical-backups) of a Postgres instance by ID.


```dart
Future<void> createPostgresExport({required String postgresId})
```

`POST /postgres/{postgresId}/export`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/create-postgres-export)

## createPostgresUser

**Create PostgreSQL User**

Create a new PostgreSQL user for the Render Postgres instance with the provided ID. This becomes the database's new "default" user.


```dart
Future<void> createPostgresUser({required String postgresId, required CreatePostgresUserRequest body})
```

`POST /postgres/{postgresId}/credentials`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |
| `body` | `CreatePostgresUserRequest` | body | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/create-postgres-user)

## deletePostgres

**Delete Postgres instance**

Delete a Postgres instance by ID. This operation is irreversible, and
all data will be lost.


```dart
Future<void> deletePostgres({required String postgresId})
```

`DELETE /postgres/{postgresId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-postgres)

## deletePostgresUser

**Delete PostgreSQL User**

Delete a PostgreSQL user from the Render Postgres instance with the provided ID.


```dart
Future<void> deletePostgresUser({required String postgresId, required String username})
```

`DELETE /postgres/{postgresId}/credentials/{username}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |
| `username` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-postgres-user)

## failoverPostgres

**Failover Postgres instance**

Failover a [highly available Postgres](https://render.com/docs/postgresql-high-availability) instance.


```dart
Future<void> failoverPostgres({required String postgresId})
```

`POST /postgres/{postgresId}/failover`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/failover-postgres)

## listPostgres

**List Postgres instances**

List Postgres instances matching the provided filters. If no filters are provided, all Postgres instances are returned.


```dart
Future<List<PostgresWithCursor>> listPostgres({List<String>? name, List<String>? region, List<String>? suspended, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, bool? includeReplicas, String? cursor, int? limit})
```

`GET /postgres`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `region` | `List<String>` | query | no | Filter by resource region |
| `suspended` | `List<String>` | query | no | Filter resources based on whether they're suspended or not suspended |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `includeReplicas` | `bool` | query | no | Include replicas in the response |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<PostgresWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `postgres` | `Postgres` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres)

## listPostgresExport

**List Postgres exports**

List [exports](https://render.com/docs/postgresql-backups#logical-backups) for a Postgres instance by ID. Returns a URL to download the export.


```dart
Future<List<ListPostgresExportResponse>> listPostgresExport({required String postgresId})
```

`GET /postgres/{postgresId}/export`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `List<ListPostgresExportResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `createdAt` | `DateTime` |  |
| `url` | `String?` | URL to download the Postgres export |

[Render documentation](https://api-docs.render.com/reference/list-postgres-export)

## listPostgresProcesses

**List live queries**

List currently running queries (from `pg_stat_activity`) on a Postgres instance by ID.


```dart
Future<ListPostgresProcessesResponse> listPostgresProcesses({required String postgresId})
```

`GET /postgres/{postgresId}/query/processes`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `ListPostgresProcessesResponse`.

| Field | Type | |
| --- | --- | --- |
| `processes` | `List<ListPostgresProcessesResponseProcessesItem>` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres-processes)

## listPostgresSizes

**List database, table, and index sizes**

List the sizes of databases, tables, and indexes on a Postgres instance by ID.


```dart
Future<ListPostgresSizesResponse> listPostgresSizes({required String postgresId})
```

`GET /postgres/{postgresId}/query/sizes`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `ListPostgresSizesResponse`.

| Field | Type | |
| --- | --- | --- |
| `sizes` | `List<ListPostgresSizesResponseSizesItem>` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres-sizes)

## listPostgresTableScans

**List table scans**

List the number of sequential scans performed against each table on a Postgres instance by ID.


```dart
Future<ListPostgresTableScansResponse> listPostgresTableScans({required String postgresId})
```

`GET /postgres/{postgresId}/query/table-scans`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `ListPostgresTableScansResponse`.

| Field | Type | |
| --- | --- | --- |
| `tableScans` | `List<ListPostgresTableScansResponseTableScansItem>` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres-table-scans)

## listPostgresTopQueries

**List top queries**

List the top 50 queries by total execution time (from `pg_stat_statements`) on a Postgres instance by ID.


```dart
Future<ListPostgresTopQueriesResponse> listPostgresTopQueries({required String postgresId})
```

`GET /postgres/{postgresId}/query/top-queries`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `ListPostgresTopQueriesResponse`.

| Field | Type | |
| --- | --- | --- |
| `topQueries` | `List<ListPostgresTopQueriesResponseTopQueriesItem>` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres-top-queries)

## listPostgresUsers

**List PostgreSQL Users**

List PostgreSQL users for the Render Postgres instance with the provided ID.


```dart
Future<List<ListPostgresUsersResponse>> listPostgresUsers({required String postgresId})
```

`GET /postgres/{postgresId}/credentials`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `List<ListPostgresUsersResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `username` | `String?` |  |
| `default_` | `bool?` |  |
| `createdAt` | `String?` |  |
| `openConnections` | `int?` |  |

[Render documentation](https://api-docs.render.com/reference/list-postgres-users)

## recoverPostgres

**Trigger point-in-time recovery**

Trigger [point-in-time recovery](https://render.com/docs/postgresql-backups) on the Postgres instance with the provided ID.


```dart
Future<PostgresDetail> recoverPostgres({required String postgresId, required RecoverPostgresRequest body})
```

`POST /postgres/{postgresId}/recovery`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |
| `body` | `RecoverPostgresRequest` | body | yes |  |

Returns `PostgresDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `expiresAt` | `DateTime?` | The time at which the database will be expire. Applies to free tier databases only. |
| `dashboardUrl` | `String` | The URL to view the Postgres instance in the Render Dashboard |
| `databaseName` | `String` |  |
| `databaseUser` | `String` |  |
| `environmentId` | `String?` |  |
| `highAvailabilityEnabled` | `bool` |  |
| `maintenance` | `PostgresDetailMaintenance?` |  |
| `name` | `String` |  |
| `owner` | `Owner` |  |
| `plan` | `PostgresPostinputPlan` |  |
| `diskSizeGb` | `int?` |  |
| `parameterOverrides` | `Map<String, Object?>?` |  |
| `primaryPostgresId` | `String?` |  |
| `region` | `Region` | Defaults to "oregon" |
| `readReplicas` | `List<ReadReplica>` |  |
| `role` | `DatabaseRole` |  |
| `status` | `DatabaseStatus` |  |
| `version` | `PostgresVersion` | The PostgreSQL version |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `diskAutoscalingEnabled` | `bool` |  |
| `connectionPool` | `String` | What connection pool to use (if any) out of 'pgbouncer' and 'none' |

[Render documentation](https://api-docs.render.com/reference/recover-postgres)

## restartPostgres

**Restart Postgres instance**

Restart a Postgres instance by ID.


```dart
Future<void> restartPostgres({required String postgresId})
```

`POST /postgres/{postgresId}/restart`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/restart-postgres)

## resumePostgres

**Resume Postgres instance**

Resume a Postgres instance by ID.


```dart
Future<void> resumePostgres({required String postgresId})
```

`POST /postgres/{postgresId}/resume`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/resume-postgres)

## retrievePostgres

**Retrieve Postgres instance**

Retrieve a Postgres instance by ID.


```dart
Future<PostgresDetail> retrievePostgres({required String postgresId})
```

`GET /postgres/{postgresId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `PostgresDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `expiresAt` | `DateTime?` | The time at which the database will be expire. Applies to free tier databases only. |
| `dashboardUrl` | `String` | The URL to view the Postgres instance in the Render Dashboard |
| `databaseName` | `String` |  |
| `databaseUser` | `String` |  |
| `environmentId` | `String?` |  |
| `highAvailabilityEnabled` | `bool` |  |
| `maintenance` | `PostgresDetailMaintenance?` |  |
| `name` | `String` |  |
| `owner` | `Owner` |  |
| `plan` | `PostgresPostinputPlan` |  |
| `diskSizeGb` | `int?` |  |
| `parameterOverrides` | `Map<String, Object?>?` |  |
| `primaryPostgresId` | `String?` |  |
| `region` | `Region` | Defaults to "oregon" |
| `readReplicas` | `List<ReadReplica>` |  |
| `role` | `DatabaseRole` |  |
| `status` | `DatabaseStatus` |  |
| `version` | `PostgresVersion` | The PostgreSQL version |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `diskAutoscalingEnabled` | `bool` |  |
| `connectionPool` | `String` | What connection pool to use (if any) out of 'pgbouncer' and 'none' |

[Render documentation](https://api-docs.render.com/reference/retrieve-postgres)

## retrievePostgresConnectionInfo

**Retrieve Postgres connection info**

Retrieve connection info for a Postgres instance by ID. Connection info includes sensitive information.


```dart
Future<PostgresConnectionInfo> retrievePostgresConnectionInfo({required String postgresId})
```

`GET /postgres/{postgresId}/connection-info`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `PostgresConnectionInfo`.

| Field | Type | |
| --- | --- | --- |
| `password` | `String` |  |
| `internalConnectionString` | `String` |  |
| `externalConnectionString` | `String` |  |
| `internalConnectionPoolString` | `String?` |  |
| `externalConnectionPoolString` | `String?` |  |
| `psqlCommand` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-postgres-connection-info)

## retrievePostgresRecoveryInfo

**Retrieve point-in-time recovery status**

Retrieve information on the availability of Postgres point-in-time recovery for a Postgres instance by ID.


```dart
Future<RetrievePostgresRecoveryInfoResponse> retrievePostgresRecoveryInfo({required String postgresId})
```

`GET /postgres/{postgresId}/recovery`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `RetrievePostgresRecoveryInfoResponse`.

| Field | Type | |
| --- | --- | --- |
| `recoveryStatus` | `RecoveryStatus` | Availability of point-in-time recovery. |
| `startsAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-postgres-recovery-info)

## suspendPostgres

**Suspend Postgres instance**

Suspend a Postgres instance by ID.


```dart
Future<void> suspendPostgres({required String postgresId})
```

`POST /postgres/{postgresId}/suspend`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/suspend-postgres)

## updatePostgres

**Update Postgres instance**

Update a Postgres instance by ID.


```dart
Future<PostgresDetail> updatePostgres({required String postgresId, required PostgresPatchinput body})
```

`PATCH /postgres/{postgresId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `postgresId` | `String` | path | yes |  |
| `body` | `PostgresPatchinput` | body | yes |  |

Returns `PostgresDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `expiresAt` | `DateTime?` | The time at which the database will be expire. Applies to free tier databases only. |
| `dashboardUrl` | `String` | The URL to view the Postgres instance in the Render Dashboard |
| `databaseName` | `String` |  |
| `databaseUser` | `String` |  |
| `environmentId` | `String?` |  |
| `highAvailabilityEnabled` | `bool` |  |
| `maintenance` | `PostgresDetailMaintenance?` |  |
| `name` | `String` |  |
| `owner` | `Owner` |  |
| `plan` | `PostgresPostinputPlan` |  |
| `diskSizeGb` | `int?` |  |
| `parameterOverrides` | `Map<String, Object?>?` |  |
| `primaryPostgresId` | `String?` |  |
| `region` | `Region` | Defaults to "oregon" |
| `readReplicas` | `List<ReadReplica>` |  |
| `role` | `DatabaseRole` |  |
| `status` | `DatabaseStatus` |  |
| `version` | `PostgresVersion` | The PostgreSQL version |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `diskAutoscalingEnabled` | `bool` |  |
| `connectionPool` | `String` | What connection pool to use (if any) out of 'pgbouncer' and 'none' |

[Render documentation](https://api-docs.render.com/reference/update-postgres)

