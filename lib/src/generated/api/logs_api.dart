// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';

/// Generated bindings for the `/logs` endpoints.
class LogsEndpoints {
  const LogsEndpoints(this._client);

  final RenderApiClient _client;

  /// List logs
  ///
  /// List logs matching the provided filters. Logs are paginated by start and end timestamps.
  /// There are more logs to fetch if `hasMore` is true in the response. Provide the `nextStartTime`
  /// and `nextEndTime` timestamps as the `startTime` and `endTime` query parameters to fetch the next page of logs.
  ///
  /// You can query for logs across multiple resources, but all resources must be in the same region and belong to the same owner.
  Future<Map<String, Object?>> listLogs({required Object? ownerId, Object? startTime, Object? endTime, Object? direction, required Object? resource, Object? instance, Object? host, Object? statusCode, Object? method, Object? task, Object? taskRun, Object? sandbox, Object? level, Object? type, Object? text, Object? path, Object? limit}) async {
    final json = await _client.sendObject(
      'GET',
      '/logs',
      query: {
        'ownerId': ownerId,
        'startTime': startTime,
        'endTime': endTime,
        'direction': direction,
        'resource': resource,
        'instance': instance,
        'host': host,
        'statusCode': statusCode,
        'method': method,
        'task': task,
        'taskRun': taskRun,
        'sandbox': sandbox,
        'level': level,
        'type': type,
        'text': text,
        'path': path,
        'limit': limit,
      },
    );
    return json;
  }


  /// Subscribe to new logs
  ///
  /// Open a websocket connection to subscribe to logs matching the provided filters. Logs are streamed in real-time as they are generated.
  ///
  /// You can query for logs across multiple resources, but all resources must be in the same region and belong to the same owner.
  Future<void> subscribeLogs({required Object? ownerId, Object? startTime, Object? endTime, Object? direction, required Object? resource, Object? instance, Object? host, Object? statusCode, Object? method, Object? task, Object? taskRun, Object? sandbox, Object? level, Object? type, Object? text, Object? path, Object? limit}) async {
    await _client.send(
      'GET',
      '/logs/subscribe',
      query: {
        'ownerId': ownerId,
        'startTime': startTime,
        'endTime': endTime,
        'direction': direction,
        'resource': resource,
        'instance': instance,
        'host': host,
        'statusCode': statusCode,
        'method': method,
        'task': task,
        'taskRun': taskRun,
        'sandbox': sandbox,
        'level': level,
        'type': type,
        'text': text,
        'path': path,
        'limit': limit,
      },
    );
  }


  /// List log label values
  ///
  /// List all values for a given log label in the logs matching the provided filters.
  Future<List<Object?>> listLogsValues({required Object? ownerId, required Object? label, Object? startTime, Object? endTime, Object? direction, required Object? resource, Object? instance, Object? host, Object? statusCode, Object? method, Object? task, Object? taskRun, Object? sandbox, Object? level, Object? type, Object? text, Object? path, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/logs/values',
      query: {
        'ownerId': ownerId,
        'label': label,
        'startTime': startTime,
        'endTime': endTime,
        'direction': direction,
        'resource': resource,
        'instance': instance,
        'host': host,
        'statusCode': statusCode,
        'method': method,
        'task': task,
        'taskRun': taskRun,
        'sandbox': sandbox,
        'level': level,
        'type': type,
        'text': text,
        'path': path,
        'limit': limit,
      },
    );
    return json;
  }


  /// Retrieve log stream
  ///
  /// Returns log stream information for the specified workspace.
  Future<Map<String, Object?>> getOwnerLogStream(String ownerId) async {
    final json = await _client.sendObject(
      'GET',
      '/logs/streams/owner/$ownerId',
    );
    return json;
  }


  /// Update log stream
  ///
  /// Updates log stream information for the specified workspace. All logs for resources owned by this workspace will be sent to this log stream unless overridden by individual resources.
  Future<Map<String, Object?>> updateOwnerLogStream(String ownerId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/logs/streams/owner/$ownerId',
      body: body,
    );
    return json;
  }


  /// Delete log stream
  ///
  /// Removes the log stream for the specified workspace.
  Future<void> deleteOwnerLogStream(String ownerId) async {
    await _client.send(
      'DELETE',
      '/logs/streams/owner/$ownerId',
    );
  }


  /// List log stream overrides
  ///
  /// Lists log stream overrides for the provided workspace that match the provided filters. These overrides take precedence over the workspace's default log stream.
  Future<List<Object?>> listResourceLogStreams({Object? ownerId, Object? logStreamId, Object? resourceId, Object? setting, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/logs/streams/resource',
      query: {
        'ownerId': ownerId,
        'logStreamId': logStreamId,
        'resourceId': resourceId,
        'setting': setting,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json;
  }


  /// Retrieve log stream override
  ///
  /// Returns log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.
  Future<Map<String, Object?>> getResourceLogStream(String resourceId) async {
    final json = await _client.sendObject(
      'GET',
      '/logs/streams/resource/$resourceId',
    );
    return json;
  }


  /// Update log stream override
  ///
  /// Updates log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.
  Future<Map<String, Object?>> updateResourceLogStream(String resourceId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/logs/streams/resource/$resourceId',
      body: body,
    );
    return json;
  }


  /// Delete log stream override
  ///
  /// Removes the log stream override for the specified resource. After deletion, the resource will use the workspace's default log stream setting.
  Future<void> deleteResourceLogStream(String resourceId) async {
    await _client.send(
      'DELETE',
      '/logs/streams/resource/$resourceId',
    );
  }


}
