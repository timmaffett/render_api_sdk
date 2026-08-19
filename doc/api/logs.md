# Logs

`render.raw.logs` — 10 operations on `/logs`.

| Method | | |
| --- | --- | --- |
| [`deleteOwnerLogStream`](#deleteownerlogstream) | `DELETE /logs/streams/owner/{ownerId}` | Delete log stream |
| [`deleteResourceLogStream`](#deleteresourcelogstream) | `DELETE /logs/streams/resource/{resourceId}` | Delete log stream override |
| [`getOwnerLogStream`](#getownerlogstream) | `GET /logs/streams/owner/{ownerId}` | Retrieve log stream |
| [`getResourceLogStream`](#getresourcelogstream) | `GET /logs/streams/resource/{resourceId}` | Retrieve log stream override |
| [`listLogs`](#listlogs) | `GET /logs` | List logs |
| [`listLogsValues`](#listlogsvalues) | `GET /logs/values` | List log label values |
| [`listResourceLogStreams`](#listresourcelogstreams) | `GET /logs/streams/resource` | List log stream overrides |
| [`subscribeLogs`](#subscribelogs) | `GET /logs/subscribe` | Subscribe to new logs |
| [`updateOwnerLogStream`](#updateownerlogstream) | `PUT /logs/streams/owner/{ownerId}` | Update log stream |
| [`updateResourceLogStream`](#updateresourcelogstream) | `PUT /logs/streams/resource/{resourceId}` | Update log stream override |

---

## deleteOwnerLogStream

**Delete log stream**

Removes the log stream for the specified workspace.

```dart
Future<void> deleteOwnerLogStream({required String ownerId})
```

`DELETE /logs/streams/owner/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-owner-log-stream)

## deleteResourceLogStream

**Delete log stream override**

Removes the log stream override for the specified resource. After deletion, the resource will use the workspace's default log stream setting.

```dart
Future<void> deleteResourceLogStream({required String resourceId})
```

`DELETE /logs/streams/resource/{resourceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `resourceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-resource-log-stream)

## getOwnerLogStream

**Retrieve log stream**

Returns log stream information for the specified workspace.

```dart
Future<GetOwnerLogStreamResponse> getOwnerLogStream({required String ownerId})
```

`GET /logs/streams/owner/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `GetOwnerLogStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String?` | The ID of the owner. |
| `endpoint` | `String?` | The endpoint to stream logs to. |
| `preview` | `Preview?` | Whether to send logs or drop them. |

[Render documentation](https://api-docs.render.com/reference/get-owner-log-stream)

## getResourceLogStream

**Retrieve log stream override**

Returns log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.

```dart
Future<GetResourceLogStreamResponse> getResourceLogStream({required String resourceId})
```

`GET /logs/streams/resource/{resourceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `resourceId` | `String` | path | yes |  |

Returns `GetResourceLogStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `resourceId` | `String?` | The ID of the resource. |
| `endpoint` | `String?` | The endpoint to stream logs to. Must be present if setting is send. Cannot be present if setting is drop. |
| `setting` | `Preview?` | Whether to send logs or drop them. |

[Render documentation](https://api-docs.render.com/reference/get-resource-log-stream)

## listLogs

**List logs**

List logs matching the provided filters. Logs are paginated by start and end timestamps.
There are more logs to fetch if `hasMore` is true in the response. Provide the `nextStartTime`
and `nextEndTime` timestamps as the `startTime` and `endTime` query parameters to fetch the next page of logs.

You can query for logs across multiple resources, but all resources must be in the same region and belong to the same owner.


```dart
Future<ListLogsResponse> listLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit})
```

`GET /logs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | query | yes | The ID of the workspace to return logs for |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `direction` | `String` | query | no | The direction to query logs for. Backward will return most recent logs first. Forward will start with the oldest logs in the time range.  |
| `resource` | `List<String>` | query | yes | Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group. |
| `instance` | `List<String>` | query | no | Filter logs by the instance they were emitted from. An instance is the id of a specific running server. |
| `host` | `List<String>` | query | no | Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `statusCode` | `List<String>` | query | no | Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `method` | `List<String>` | query | no | Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `task` | `List<String>` | query | no | Filter logs by their task(s) |
| `taskRun` | `List<String>` | query | no | Filter logs by their task run id(s) |
| `sandbox` | `List<String>` | query | no | Filter logs by sandbox ID. |
| `level` | `List<String>` | query | no | Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `type` | `List<String>` | query | no | Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint. |
| `text` | `List<String>` | query | no | Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `path` | `List<String>` | query | no | Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `ListLogsResponse`.

| Field | Type | |
| --- | --- | --- |
| `hasMore` | `bool` | True if there are more logs to fetch |
| `nextStartTime` | `DateTime` | The start time to use in the next query to fetch the next set of logs |
| `nextEndTime` | `DateTime` | The end time to use in the next query to fetch the next set of logs |
| `logs` | `List<ListLogsResponseLogsItem>` |  |

[Render documentation](https://api-docs.render.com/reference/list-logs)

## listLogsValues

**List log label values**

List all values for a given log label in the logs matching the provided filters.

```dart
Future<List<Object?>> listLogsValues({required String ownerId, required String label, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit})
```

`GET /logs/values`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | query | yes | The ID of the workspace to return log label values for |
| `label` | `String` | query | yes | The label to query logs for |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `direction` | `String` | query | no | The direction to query logs for. Backward will return most recent logs first. Forward will start with the oldest logs in the time range.  |
| `resource` | `List<String>` | query | yes | Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group. |
| `instance` | `List<String>` | query | no | Filter logs by the instance they were emitted from. An instance is the id of a specific running server. |
| `host` | `List<String>` | query | no | Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `statusCode` | `List<String>` | query | no | Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `method` | `List<String>` | query | no | Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `task` | `List<String>` | query | no | Filter logs by their task(s) |
| `taskRun` | `List<String>` | query | no | Filter logs by their task run id(s) |
| `sandbox` | `List<String>` | query | no | Filter logs by sandbox ID. |
| `level` | `List<String>` | query | no | Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `type` | `List<String>` | query | no | Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint. |
| `text` | `List<String>` | query | no | Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `path` | `List<String>` | query | no | Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<Object?>` — each element carries:

[Render documentation](https://api-docs.render.com/reference/list-logs-values)

## listResourceLogStreams

**List log stream overrides**

Lists log stream overrides for the provided workspace that match the provided filters. These overrides take precedence over the workspace's default log stream.

```dart
Future<List<ListResourceLogStreamsResponse>> listResourceLogStreams({List<String>? ownerId, List<String>? logStreamId, List<String>? resourceId, List<String>? setting, String? cursor, int? limit})
```

`GET /logs/streams/resource`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `logStreamId` | `List<String>` | query | no | Filter log streams by their id. |
| `resourceId` | `List<String>` | query | no | IDs of resources (server, cron job, postgres, or redis) to filter by |
| `setting` | `List<String>` | query | no | Filter log streams by their setting. |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<ListResourceLogStreamsResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `resourceId` | `String?` | The ID of the resource. |
| `endpoint` | `String?` | The endpoint to stream logs to. Must be present if setting is send. Cannot be present if setting is drop. |
| `setting` | `Preview?` | Whether to send logs or drop them. |

[Render documentation](https://api-docs.render.com/reference/list-resource-log-streams)

## subscribeLogs

**Subscribe to new logs**

Open a websocket connection to subscribe to logs matching the provided filters. Logs are streamed in real-time as they are generated.

You can query for logs across multiple resources, but all resources must be in the same region and belong to the same owner.


```dart
Future<void> subscribeLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit})
```

`GET /logs/subscribe`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | query | yes | The ID of the workspace to return logs for |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `direction` | `String` | query | no | The direction to query logs for. Backward will return most recent logs first. Forward will start with the oldest logs in the time range.  |
| `resource` | `List<String>` | query | yes | Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group. |
| `instance` | `List<String>` | query | no | Filter logs by the instance they were emitted from. An instance is the id of a specific running server. |
| `host` | `List<String>` | query | no | Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `statusCode` | `List<String>` | query | no | Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `method` | `List<String>` | query | no | Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `task` | `List<String>` | query | no | Filter logs by their task(s) |
| `taskRun` | `List<String>` | query | no | Filter logs by their task run id(s) |
| `sandbox` | `List<String>` | query | no | Filter logs by sandbox ID. |
| `level` | `List<String>` | query | no | Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `type` | `List<String>` | query | no | Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint. |
| `text` | `List<String>` | query | no | Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `path` | `List<String>` | query | no | Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported. |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/subscribe-logs)

## updateOwnerLogStream

**Update log stream**

Updates log stream information for the specified workspace. All logs for resources owned by this workspace will be sent to this log stream unless overridden by individual resources.

```dart
Future<UpdateOwnerLogStreamResponse> updateOwnerLogStream({required String ownerId, required UpdateOwnerLogStreamRequest body})
```

`PUT /logs/streams/owner/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `body` | `UpdateOwnerLogStreamRequest` | body | yes |  |

Returns `UpdateOwnerLogStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String?` | The ID of the owner. |
| `endpoint` | `String?` | The endpoint to stream logs to. |
| `preview` | `Preview?` | Whether to send logs or drop them. |

[Render documentation](https://api-docs.render.com/reference/update-owner-log-stream)

## updateResourceLogStream

**Update log stream override**

Updates log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.

```dart
Future<UpdateResourceLogStreamResponse> updateResourceLogStream({required String resourceId, required UpdateResourceLogStreamRequest body})
```

`PUT /logs/streams/resource/{resourceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `resourceId` | `String` | path | yes |  |
| `body` | `UpdateResourceLogStreamRequest` | body | yes |  |

Returns `UpdateResourceLogStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `resourceId` | `String?` | The ID of the resource. |
| `endpoint` | `String?` | The endpoint to stream logs to. Must be present if setting is send. Cannot be present if setting is drop. |
| `setting` | `Preview?` | Whether to send logs or drop them. |

[Render documentation](https://api-docs.render.com/reference/update-resource-log-stream)

