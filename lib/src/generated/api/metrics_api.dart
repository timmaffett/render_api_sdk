// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/metrics` endpoints.
class MetricsEndpoints {
  const MetricsEndpoints(this._client);

  final RenderApiClient _client;

  /// Get CPU usage
  ///
  /// Get CPU usage for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  ///
  /// [aggregationMethod] The aggregation method to apply to multiple time series
  Future<List<GetCpuResponse>> getCpu({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance, String? aggregationMethod}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/cpu',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
        'aggregationMethod': aggregationMethod,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetCpuResponse.fromJson).toList();
  }


  /// Get CPU limit
  ///
  /// Get the CPU limit for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  Future<List<GetCpuLimitResponse>> getCpuLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/cpu-limit',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetCpuLimitResponse.fromJson).toList();
  }


  /// Get CPU target
  ///
  /// Get CPU target for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  Future<List<GetCpuTargetResponse>> getCpuTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/cpu-target',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetCpuTargetResponse.fromJson).toList();
  }


  /// Get memory usage
  ///
  /// Get memory usage for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  Future<List<GetMemoryResponse>> getMemory({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/memory',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetMemoryResponse.fromJson).toList();
  }


  /// Get memory limit
  ///
  /// Get the memory limit for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  Future<List<GetMemoryLimitResponse>> getMemoryLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/memory-limit',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetMemoryLimitResponse.fromJson).toList();
  }


  /// Get memory target
  ///
  /// Get memory target for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [instance] Instance ID to query. When multiple instance ID query params are provided, they are ORed together
  Future<List<GetMemoryTargetResponse>> getMemoryTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/memory-target',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'instance': instance,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetMemoryTargetResponse.fromJson).toList();
  }


  /// Get HTTP request count
  ///
  /// Get the HTTP request count for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [host] The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together
  ///
  /// [path] The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together
  ///
  /// [aggregateBy] The field to aggregate by
  Future<List<GetHttpRequestsResponse>> getHttpRequests({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, String? aggregateBy}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/http-requests',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'host': host,
        'path': path,
        'aggregateBy': aggregateBy,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetHttpRequestsResponse.fromJson).toList();
  }


  /// Get HTTP latency
  ///
  /// Get HTTP latency metrics for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [host] The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together
  ///
  /// [path] The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together
  ///
  /// [quantile] The quantile of latencies to fetch. When multiple quantile query params are provided, they are ORed together
  Future<List<GetHttpLatencyResponse>> getHttpLatency({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, double? quantile}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/http-latency',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'host': host,
        'path': path,
        'quantile': quantile,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetHttpLatencyResponse.fromJson).toList();
  }


  /// Get bandwidth usage
  ///
  /// Get bandwidth usage for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<List<GetBandwidthResponse>> getBandwidth({String? startTime, String? endTime, String? resource, String? service}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/bandwidth',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resource': resource,
        'service': service,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetBandwidthResponse.fromJson).toList();
  }


  /// Get bandwidth usage breakdown by traffic source
  ///
  /// Get bandwidth usage for one or more resources broken down by traffic source (HTTP, WebSocket, NAT, PrivateLink).
  ///
  /// Returns hourly data points with traffic source breakdown. Traffic source data is available from March 9, 2025 onwards.
  /// Queries for earlier dates will return a 400 Bad Request error.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<GetBandwidthSourcesResponse> getBandwidthSources({String? startTime, String? endTime, String? resource, String? service}) async {
    final json = await _client.sendObject(
      'GET',
      '/metrics/bandwidth-sources',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resource': resource,
        'service': service,
      },
    );
    return GetBandwidthSourcesResponse.fromJson(json);
  }


  /// Get disk usage
  ///
  /// Get persistent disk usage for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<List<GetDiskUsageResponse>> getDiskUsage({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/disk-usage',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetDiskUsageResponse.fromJson).toList();
  }


  /// Get disk capacity
  ///
  /// Get persistent disk capacity for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<List<GetDiskCapacityResponse>> getDiskCapacity({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/disk-capacity',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetDiskCapacityResponse.fromJson).toList();
  }


  /// Get instance count
  ///
  /// Get the instance count for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources can be service ids, Postgres ids, or Redis ids
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<List<GetInstanceCountResponse>> getInstanceCount({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/instance-count',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetInstanceCountResponse.fromJson).toList();
  }


  /// Get active connection count
  ///
  /// Get the number of active connections for one or more Postgres databases or Redis instances.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Resource ID to query. When multiple resource query params are provided, they are ORed together. Resources Postgres ids or Redis ids
  Future<List<GetActiveConnectionsResponse>> getActiveConnections({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/active-connections',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetActiveConnectionsResponse.fromJson).toList();
  }


  /// Get replica lag
  ///
  /// Get seconds of replica lag of a Postgres replica.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Postgres ID to query. When multiple resource query params are provided, they are ORed together
  Future<List<GetReplicationLagResponse>> getReplicationLag({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/replication-lag',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetReplicationLagResponse.fromJson).toList();
  }


  /// List queryable instance values
  ///
  /// List instance values to filter by for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  Future<List<ListApplicationFilterValuesResponse>> listApplicationFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/filters/application',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
      },
    );
    return json.whereType<Map<String, Object?>>().map(ListApplicationFilterValuesResponse.fromJson).toList();
  }


  /// List queryable status codes and host values
  ///
  /// List status codes and host values to filter by for one or more resources.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [host] The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together
  ///
  /// [statusCode] The status codes of HTTP requests to filter to. When multiple status code query params are provided, they are ORed together
  Future<List<ListHttpFilterValuesResponse>> listHttpFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/filters/http',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'host': host,
        'statusCode': statusCode,
      },
    );
    return json.whereType<Map<String, Object?>>().map(ListHttpFilterValuesResponse.fromJson).toList();
  }


  /// List queryable paths
  ///
  /// The path suggestions are based on the most recent 5000 log lines as filtered by the provided filters
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Service ID to query. When multiple service ids are provided, they are ORed together
  ///
  /// [service] This parameter is deprecated. Please use `resource` instead
  ///
  /// [host] The hosts of HTTP requests to filter to. When multiple host query params are provided, they are ORed together
  ///
  /// [statusCode] The status codes of HTTP requests to filter to. When multiple status code query params are provided, they are ORed together
  ///
  /// [path] The paths of HTTP requests to filter to. When multiple path query params are provided, they are ORed together
  Future<List<Object?>> listPathFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode, String? path}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/filters/path',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'service': service,
        'host': host,
        'statusCode': statusCode,
        'path': path,
      },
    );
    return json;
  }


  /// Get task runs queued count
  ///
  /// Get the total number of task runs queued for one or more tasks.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Task ID to query. When multiple task IDs are provided, they are ORed together
  Future<List<GetTaskRunsQueuedResponse>> getTaskRunsQueued({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/task-runs-queued',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetTaskRunsQueuedResponse.fromJson).toList();
  }


  /// Get task runs completed count
  ///
  /// Get the total number of task runs completed for one or more tasks. Optionally filter by state (succeeded/failed) or aggregate by state.
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [resolutionSeconds] The resolution of the returned data
  ///
  /// [resource] Task ID to query. When multiple task IDs are provided, they are ORed together
  ///
  /// [state] The state of task runs to filter to. When multiple state query params are provided, they are ORed together
  ///
  /// [aggregateBy] The field to aggregate by
  Future<List<GetTaskRunsCompletedResponse>> getTaskRunsCompleted({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? state, String? aggregateBy}) async {
    final json = await _client.sendList(
      'GET',
      '/metrics/task-runs-completed',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'resolutionSeconds': resolutionSeconds,
        'resource': resource,
        'state': state,
        'aggregateBy': aggregateBy,
      },
    );
    return json.whereType<Map<String, Object?>>().map(GetTaskRunsCompletedResponse.fromJson).toList();
  }


}
