# Metrics

`render.raw.metrics` — 20 operations on `/metrics`.

| Method | | |
| --- | --- | --- |
| [`getActiveConnections`](#getactiveconnections) | `GET /metrics/active-connections` | Get active connection count |
| [`getBandwidth`](#getbandwidth) | `GET /metrics/bandwidth` | Get bandwidth usage |
| [`getBandwidthSources`](#getbandwidthsources) | `GET /metrics/bandwidth-sources` | Get bandwidth usage breakdown by traffic source |
| [`getCpu`](#getcpu) | `GET /metrics/cpu` | Get CPU usage |
| [`getCpuLimit`](#getcpulimit) | `GET /metrics/cpu-limit` | Get CPU limit |
| [`getCpuTarget`](#getcputarget) | `GET /metrics/cpu-target` | Get CPU target |
| [`getDiskCapacity`](#getdiskcapacity) | `GET /metrics/disk-capacity` | Get disk capacity |
| [`getDiskUsage`](#getdiskusage) | `GET /metrics/disk-usage` | Get disk usage |
| [`getHttpLatency`](#gethttplatency) | `GET /metrics/http-latency` | Get HTTP latency |
| [`getHttpRequests`](#gethttprequests) | `GET /metrics/http-requests` | Get HTTP request count |
| [`getInstanceCount`](#getinstancecount) | `GET /metrics/instance-count` | Get instance count |
| [`getMemory`](#getmemory) | `GET /metrics/memory` | Get memory usage |
| [`getMemoryLimit`](#getmemorylimit) | `GET /metrics/memory-limit` | Get memory limit |
| [`getMemoryTarget`](#getmemorytarget) | `GET /metrics/memory-target` | Get memory target |
| [`getReplicationLag`](#getreplicationlag) | `GET /metrics/replication-lag` | Get replica lag |
| [`getTaskRunsCompleted`](#gettaskrunscompleted) | `GET /metrics/task-runs-completed` | Get task runs completed count |
| [`getTaskRunsQueued`](#gettaskrunsqueued) | `GET /metrics/task-runs-queued` | Get task runs queued count |
| [`listApplicationFilterValues`](#listapplicationfiltervalues) | `GET /metrics/filters/application` | List queryable instance values |
| [`listHttpFilterValues`](#listhttpfiltervalues) | `GET /metrics/filters/http` | List queryable status codes and host values |
| [`listPathFilterValues`](#listpathfiltervalues) | `GET /metrics/filters/path` | List queryable paths |

---

## getActiveConnections

**Get active connection count**

Get the number of active connections for one or more Postgres databases or Redis instances.


```dart
Future<List<GetActiveConnectionsResponse>> getActiveConnections({String? startTime, String? endTime, double? resolutionSeconds, String? resource})
```

`GET /metrics/active-connections`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources Postgres ids or Redis ids |

Returns `List<GetActiveConnectionsResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetActiveConnectionsResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetActiveConnectionsResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-active-connections)

## getBandwidth

**Get bandwidth usage**

Get bandwidth usage for one or more resources.


```dart
Future<List<GetBandwidthResponse>> getBandwidth({String? startTime, String? endTime, String? resource, String? service})
```

`GET /metrics/bandwidth`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `List<GetBandwidthResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetBandwidthResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetBandwidthResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-bandwidth)

## getBandwidthSources

**Get bandwidth usage breakdown by traffic source**

Get bandwidth usage for one or more resources broken down by traffic source (HTTP, WebSocket, NAT, PrivateLink).

Returns hourly data points with traffic source breakdown. Traffic source data is available from March 9, 2025 onwards.
Queries for earlier dates will return a 400 Bad Request error.


```dart
Future<GetBandwidthSourcesResponse> getBandwidthSources({String? startTime, String? endTime, String? resource, String? service})
```

`GET /metrics/bandwidth-sources`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `GetBandwidthSourcesResponse`.

| Field | Type | |
| --- | --- | --- |
| `data` | `List<GetBandwidthSourcesResponseDataItem>?` |  |

[Render documentation](https://api-docs.render.com/reference/get-bandwidth-sources)

## getCpu

**Get CPU usage**

Get CPU usage for one or more resources.


```dart
Future<List<GetCpuResponse>> getCpu({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance, String? aggregationMethod})
```

`GET /metrics/cpu`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |
| `aggregationMethod` | `String` | query | no | The aggregation method to apply to multiple time series |

Returns `List<GetCpuResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetCpuResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetCpuResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-cpu)

## getCpuLimit

**Get CPU limit**

Get the CPU limit for one or more resources.


```dart
Future<List<GetCpuLimitResponse>> getCpuLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance})
```

`GET /metrics/cpu-limit`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |

Returns `List<GetCpuLimitResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetCpuLimitResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetCpuLimitResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-cpu-limit)

## getCpuTarget

**Get CPU target**

Get CPU target for one or more resources.


```dart
Future<List<GetCpuTargetResponse>> getCpuTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance})
```

`GET /metrics/cpu-target`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |

Returns `List<GetCpuTargetResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetCpuTargetResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetCpuTargetResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-cpu-target)

## getDiskCapacity

**Get disk capacity**

Get persistent disk capacity for one or more resources.


```dart
Future<List<GetDiskCapacityResponse>> getDiskCapacity({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service})
```

`GET /metrics/disk-capacity`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `List<GetDiskCapacityResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetDiskCapacityResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetDiskCapacityResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-disk-capacity)

## getDiskUsage

**Get disk usage**

Get persistent disk usage for one or more resources.


```dart
Future<List<GetDiskUsageResponse>> getDiskUsage({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service})
```

`GET /metrics/disk-usage`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `List<GetDiskUsageResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetDiskUsageResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetDiskUsageResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-disk-usage)

## getHttpLatency

**Get HTTP latency**

Get HTTP latency metrics for one or more resources.


```dart
Future<List<GetHttpLatencyResponse>> getHttpLatency({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, double? quantile})
```

`GET /metrics/http-latency`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `host` | `String` | query | no | The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together |
| `path` | `String` | query | no | The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together |
| `quantile` | `double` | query | no | The quantile of latencies to fetch. When multiple quantile query params are provided, they are ORed together |

Returns `List<GetHttpLatencyResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetHttpLatencyResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetHttpLatencyResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-http-latency)

## getHttpRequests

**Get HTTP request count**

Get the HTTP request count for one or more resources.


```dart
Future<List<GetHttpRequestsResponse>> getHttpRequests({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, String? aggregateBy})
```

`GET /metrics/http-requests`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `host` | `String` | query | no | The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together |
| `path` | `String` | query | no | The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together |
| `aggregateBy` | `String` | query | no | The field to aggregate by |

Returns `List<GetHttpRequestsResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetHttpRequestsResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetHttpRequestsResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-http-requests)

## getInstanceCount

**Get instance count**

Get the instance count for one or more resources.


```dart
Future<List<GetInstanceCountResponse>> getInstanceCount({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service})
```

`GET /metrics/instance-count`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `List<GetInstanceCountResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetInstanceCountResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetInstanceCountResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-instance-count)

## getMemory

**Get memory usage**

Get memory usage for one or more resources.


```dart
Future<List<GetMemoryResponse>> getMemory({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance})
```

`GET /metrics/memory`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |

Returns `List<GetMemoryResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetMemoryResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetMemoryResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-memory)

## getMemoryLimit

**Get memory limit**

Get the memory limit for one or more resources.


```dart
Future<List<GetMemoryLimitResponse>> getMemoryLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance})
```

`GET /metrics/memory-limit`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |

Returns `List<GetMemoryLimitResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetMemoryLimitResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetMemoryLimitResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-memory-limit)

## getMemoryTarget

**Get memory target**

Get memory target for one or more resources.


```dart
Future<List<GetMemoryTargetResponse>> getMemoryTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance})
```

`GET /metrics/memory-target`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `instance` | `String` | query | no | Instance ID to query. When multiple instance ID query params are provided, they are ORed together |

Returns `List<GetMemoryTargetResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetMemoryTargetResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetMemoryTargetResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-memory-target)

## getReplicationLag

**Get replica lag**

Get seconds of replica lag of a Postgres replica.


```dart
Future<List<GetReplicationLagResponse>> getReplicationLag({String? startTime, String? endTime, double? resolutionSeconds, String? resource})
```

`GET /metrics/replication-lag`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Postgres ID to query. When multiple resource query params are provided, they are ORed together |

Returns `List<GetReplicationLagResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetReplicationLagResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetReplicationLagResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-replication-lag)

## getTaskRunsCompleted

**Get task runs completed count**

Get the total number of task runs completed for one or more tasks. Optionally filter by state (succeeded/failed) or aggregate by state.


```dart
Future<List<GetTaskRunsCompletedResponse>> getTaskRunsCompleted({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? state, String? aggregateBy})
```

`GET /metrics/task-runs-completed`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Task ID to query. When multiple task IDs are provided, they are ORed together |
| `state` | `String` | query | no | The state of task runs to filter to. When multiple state query params are provided, they are ORed together |
| `aggregateBy` | `String` | query | no | The field to aggregate by |

Returns `List<GetTaskRunsCompletedResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetTaskRunsCompletedResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetTaskRunsCompletedResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-task-runs-completed)

## getTaskRunsQueued

**Get task runs queued count**

Get the total number of task runs queued for one or more tasks.


```dart
Future<List<GetTaskRunsQueuedResponse>> getTaskRunsQueued({String? startTime, String? endTime, double? resolutionSeconds, String? resource})
```

`GET /metrics/task-runs-queued`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Task ID to query. When multiple task IDs are provided, they are ORed together |

Returns `List<GetTaskRunsQueuedResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `labels` | `List<GetTaskRunsQueuedResponseLabelsItem>` | List of labels describing the time series |
| `values` | `List<GetTaskRunsQueuedResponseValuesItem>` | The values of the time series |
| `unit` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-task-runs-queued)

## listApplicationFilterValues

**List queryable instance values**

List instance values to filter by for one or more resources.


```dart
Future<List<ListApplicationFilterValuesResponse>> listApplicationFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service})
```

`GET /metrics/filters/application`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |

Returns `List<ListApplicationFilterValuesResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `filter` | `Filter?` |  |
| `values` | `List<String>?` |  |

[Render documentation](https://api-docs.render.com/reference/list-application-filter-values)

## listHttpFilterValues

**List queryable status codes and host values**

List status codes and host values to filter by for one or more resources.


```dart
Future<List<ListHttpFilterValuesResponse>> listHttpFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode})
```

`GET /metrics/filters/http`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `host` | `String` | query | no | The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together |
| `statusCode` | `String` | query | no | The status codes of HTTP requests to filter to. When multiple status code query params are provided, they are ORed together |

Returns `List<ListHttpFilterValuesResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `filter` | `ListHttpFilterValuesFilter?` |  |
| `values` | `List<String>?` |  |

[Render documentation](https://api-docs.render.com/reference/list-http-filter-values)

## listPathFilterValues

**List queryable paths**

The path suggestions are based on the most recent 5000 log lines as filtered by the provided filters

```dart
Future<List<Object?>> listPathFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode, String? path})
```

`GET /metrics/filters/path`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `resolutionSeconds` | `double` | query | no | The resolution of the returned data |
| `resource` | `String` | query | no | Service ID to query. When multiple service ids are provided, they are ORed together |
| `service` | `String` | query | no | This parameter is deprecated. Please use `resource` instead |
| `host` | `String` | query | no | The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together |
| `statusCode` | `String` | query | no | The status codes of HTTP requests to filter to. When multiple status code query params are provided, they are ORed together |
| `path` | `String` | query | no | The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together |

Returns `List<Object?>` — each element carries:

[Render documentation](https://api-docs.render.com/reference/list-path-filter-values)

