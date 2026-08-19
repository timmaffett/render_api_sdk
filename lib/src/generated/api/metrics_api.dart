// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';

/// Generated bindings for the `/metrics` endpoints.
class MetricsEndpoints {
  const MetricsEndpoints(this._client);

  final RenderApiClient _client;

  /// Get CPU usage
  ///
  /// Get CPU usage for one or more resources.
  Future<List<Object?>> getCpu({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance, Object? aggregationMethod}) async {
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
    return json;
  }


  /// Get CPU limit
  ///
  /// Get the CPU limit for one or more resources.
  Future<List<Object?>> getCpuLimit({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance}) async {
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
    return json;
  }


  /// Get CPU target
  ///
  /// Get CPU target for one or more resources.
  Future<List<Object?>> getCpuTarget({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance}) async {
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
    return json;
  }


  /// Get memory usage
  ///
  /// Get memory usage for one or more resources.
  Future<List<Object?>> getMemory({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance}) async {
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
    return json;
  }


  /// Get memory limit
  ///
  /// Get the memory limit for one or more resources.
  Future<List<Object?>> getMemoryLimit({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance}) async {
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
    return json;
  }


  /// Get memory target
  ///
  /// Get memory target for one or more resources.
  Future<List<Object?>> getMemoryTarget({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? instance}) async {
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
    return json;
  }


  /// Get HTTP request count
  ///
  /// Get the HTTP request count for one or more resources.
  Future<List<Object?>> getHttpRequests({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? host, Object? path, Object? aggregateBy}) async {
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
    return json;
  }


  /// Get HTTP latency
  ///
  /// Get HTTP latency metrics for one or more resources.
  Future<List<Object?>> getHttpLatency({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? host, Object? path, Object? quantile}) async {
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
    return json;
  }


  /// Get bandwidth usage
  ///
  /// Get bandwidth usage for one or more resources.
  Future<List<Object?>> getBandwidth({Object? startTime, Object? endTime, Object? resource, Object? service}) async {
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
    return json;
  }


  /// Get bandwidth usage breakdown by traffic source
  ///
  /// Get bandwidth usage for one or more resources broken down by traffic source (HTTP, WebSocket, NAT, PrivateLink).
  ///
  /// Returns hourly data points with traffic source breakdown. Traffic source data is available from March 9, 2025 onwards.
  /// Queries for earlier dates will return a 400 Bad Request error.
  Future<Map<String, Object?>> getBandwidthSources({Object? startTime, Object? endTime, Object? resource, Object? service}) async {
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
    return json;
  }


  /// Get disk usage
  ///
  /// Get persistent disk usage for one or more resources.
  Future<List<Object?>> getDiskUsage({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service}) async {
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
    return json;
  }


  /// Get disk capacity
  ///
  /// Get persistent disk capacity for one or more resources.
  Future<List<Object?>> getDiskCapacity({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service}) async {
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
    return json;
  }


  /// Get instance count
  ///
  /// Get the instance count for one or more resources.
  Future<List<Object?>> getInstanceCount({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service}) async {
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
    return json;
  }


  /// Get active connection count
  ///
  /// Get the number of active connections for one or more Postgres databases or Redis instances.
  Future<List<Object?>> getActiveConnections({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource}) async {
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
    return json;
  }


  /// Get replica lag
  ///
  /// Get seconds of replica lag of a Postgres replica.
  Future<List<Object?>> getReplicationLag({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource}) async {
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
    return json;
  }


  /// List queryable instance values
  ///
  /// List instance values to filter by for one or more resources.
  Future<List<Object?>> listApplicationFilterValues({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service}) async {
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
    return json;
  }


  /// List queryable status codes and host values
  ///
  /// List status codes and host values to filter by for one or more resources.
  Future<List<Object?>> listHttpFilterValues({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? host, Object? statusCode}) async {
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
    return json;
  }


  /// List queryable paths
  ///
  /// The path suggestions are based on the most recent 5000 log lines as filtered by the provided filters
  Future<List<Object?>> listPathFilterValues({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? service, Object? host, Object? statusCode, Object? path}) async {
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
  Future<List<Object?>> getTaskRunsQueued({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource}) async {
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
    return json;
  }


  /// Get task runs completed count
  ///
  /// Get the total number of task runs completed for one or more tasks. Optionally filter by state (succeeded/failed) or aggregate by state.
  Future<List<Object?>> getTaskRunsCompleted({Object? startTime, Object? endTime, Object? resolutionSeconds, Object? resource, Object? state, Object? aggregateBy}) async {
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
    return json;
  }


}
