// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

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
  ///
  /// [ownerId] The ID of the workspace to return logs for
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [direction] The direction to query logs for. Backward will return most recent logs first.
  /// Forward will start with the oldest logs in the time range.
  ///
  /// [resource] Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group.
  ///
  /// [instance] Filter logs by the instance they were emitted from. An instance is the id of a specific running server.
  ///
  /// [host] Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [statusCode] Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [method] Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [task] Filter logs by their task(s)
  ///
  /// [taskRun] Filter logs by their task run id(s)
  ///
  /// [sandbox] Filter logs by sandbox ID.
  ///
  /// [level] Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [type] Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint.
  ///
  /// [text] Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [path] Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<ListLogsResponse> listLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) async {
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
    return ListLogsResponse.fromJson(json);
  }


  /// Subscribe to new logs
  ///
  /// Open a websocket connection to subscribe to logs matching the provided filters. Logs are streamed in real-time as they are generated.
  ///
  /// You can query for logs across multiple resources, but all resources must be in the same region and belong to the same owner.
  ///
  /// [ownerId] The ID of the workspace to return logs for
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [direction] The direction to query logs for. Backward will return most recent logs first.
  /// Forward will start with the oldest logs in the time range.
  ///
  /// [resource] Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group.
  ///
  /// [instance] Filter logs by the instance they were emitted from. An instance is the id of a specific running server.
  ///
  /// [host] Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [statusCode] Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [method] Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [task] Filter logs by their task(s)
  ///
  /// [taskRun] Filter logs by their task run id(s)
  ///
  /// [sandbox] Filter logs by sandbox ID.
  ///
  /// [level] Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [type] Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint.
  ///
  /// [text] Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [path] Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<void> subscribeLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) async {
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
  ///
  /// [ownerId] The ID of the workspace to return log label values for
  ///
  /// [label] The label to query logs for
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [direction] The direction to query logs for. Backward will return most recent logs first.
  /// Forward will start with the oldest logs in the time range.
  ///
  /// [resource] Filter logs by their resource. A resource is the id of a server, cronjob, job, postgres, redis, workflow, or sandbox group.
  ///
  /// [instance] Filter logs by the instance they were emitted from. An instance is the id of a specific running server.
  ///
  /// [host] Filter request logs by their host. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [statusCode] Filter request logs by their status code. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [method] Filter request logs by their requests method. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [task] Filter logs by their task(s)
  ///
  /// [taskRun] Filter logs by their task run id(s)
  ///
  /// [sandbox] Filter logs by sandbox ID.
  ///
  /// [level] Filter logs by their severity level. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [type] Filter logs by their type. Types include `app` for application logs, `request` for request logs, and `build` for build logs. You can find the full set of types available for a query by using the `GET /logs/values` endpoint.
  ///
  /// [text] Filter by the text of the logs. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [path] Filter request logs by their path. [Wildcards and regex](https://render.com/docs/logging#wildcards-and-regular-expressions) are supported.
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<Object?>> listLogsValues({required String ownerId, required String label, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) async {
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
  Future<GetOwnerLogStreamResponse> getOwnerLogStream({required String ownerId}) async {
    final json = await _client.sendObject(
      'GET',
      '/logs/streams/owner/$ownerId',
    );
    return GetOwnerLogStreamResponse.fromJson(json);
  }


  /// Update log stream
  ///
  /// Updates log stream information for the specified workspace. All logs for resources owned by this workspace will be sent to this log stream unless overridden by individual resources.
  Future<UpdateOwnerLogStreamResponse> updateOwnerLogStream({required String ownerId, required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/logs/streams/owner/$ownerId',
      body: body,
    );
    return UpdateOwnerLogStreamResponse.fromJson(json);
  }


  /// Delete log stream
  ///
  /// Removes the log stream for the specified workspace.
  Future<void> deleteOwnerLogStream({required String ownerId}) async {
    await _client.send(
      'DELETE',
      '/logs/streams/owner/$ownerId',
    );
  }


  /// List log stream overrides
  ///
  /// Lists log stream overrides for the provided workspace that match the provided filters. These overrides take precedence over the workspace's default log stream.
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [logStreamId] Filter log streams by their id.
  ///
  /// [resourceId] IDs of resources (server, cron job, postgres, or redis) to filter by
  ///
  /// [setting] Filter log streams by their setting.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<ListResourceLogStreamsResponse>> listResourceLogStreams({List<String>? ownerId, List<String>? logStreamId, List<String>? resourceId, List<String>? setting, String? cursor, int? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(ListResourceLogStreamsResponse.fromJson).toList();
  }


  /// Retrieve log stream override
  ///
  /// Returns log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.
  Future<GetResourceLogStreamResponse> getResourceLogStream({required String resourceId}) async {
    final json = await _client.sendObject(
      'GET',
      '/logs/streams/resource/$resourceId',
    );
    return GetResourceLogStreamResponse.fromJson(json);
  }


  /// Update log stream override
  ///
  /// Updates log stream override information for the specified resource. A log stream override takes precedence over a workspace's default log stream.
  Future<UpdateResourceLogStreamResponse> updateResourceLogStream({required String resourceId, required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/logs/streams/resource/$resourceId',
      body: body,
    );
    return UpdateResourceLogStreamResponse.fromJson(json);
  }


  /// Delete log stream override
  ///
  /// Removes the log stream override for the specified resource. After deletion, the resource will use the workspace's default log stream setting.
  Future<void> deleteResourceLogStream({required String resourceId}) async {
    await _client.send(
      'DELETE',
      '/logs/streams/resource/$resourceId',
    );
  }


}
