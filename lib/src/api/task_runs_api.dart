import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../client.dart';
import '../models/enums.dart';
import '../models/task_run.dart';
import '../pagination.dart';

/// Task run endpoints: starting runs, inspecting them, and watching them
/// reach a terminal state.
class TaskRunsApi {
  const TaskRunsApi(this._client);

  final RenderApiClient _client;

  /// Starts a run of [taskSlug] and returns immediately.
  ///
  /// [taskSlug] is `workflow-slug/task-name`, optionally pinned to a version
  /// with `workflow-slug/task-name:version`. [input] is the task's positional
  /// arguments; a task taking no arguments gets an empty list.
  ///
  /// Render caps a run's input at 4 MB, which this checks locally so the
  /// failure names the real problem rather than surfacing an opaque rejection.
  Future<TaskRun> start(String taskSlug, List<Object?> input) async {
    _assertInputWithinLimit(taskSlug, input);
    final json = await _client.sendObject(
      'POST',
      '/task-runs',
      body: {'task': taskSlug, 'input': input},
    );
    return TaskRun.fromJson(json);
  }

  /// Retrieves a run, including its input, results and error.
  Future<TaskRunDetails> get(String taskRunId) async {
    final json = await _client.sendObject('GET', '/task-runs/$taskRunId');
    return TaskRunDetails.fromJson(json);
  }

  /// Cancels a run that has not finished. Throws if it is already terminal.
  Future<void> cancel(String taskRunId) =>
      _client.send('DELETE', '/task-runs/$taskRunId');

  /// Lists runs matching the given filters, one page at a time.
  Future<Page<TaskRun>> listPage({
    String? cursor,
    int limit = 20,
    List<String>? taskSlugs,
    List<String>? rootTaskRunIds,
    List<String>? ownerIds,
    List<String>? workflowIds,
    List<String>? workflowVersionIds,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/task-runs',
      query: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
        'taskSlug': taskSlugs,
        'rootTaskRunId': rootTaskRunIds,
        'ownerId': ownerIds,
        'workflowId': workflowIds,
        'workflowVersionId': workflowVersionIds,
      },
    );
    return Page.fromJson(json, 'taskRun', TaskRun.fromJson);
  }

  /// Lists runs across all pages.
  Stream<TaskRun> list({
    int pageSize = 20,
    int? max,
    List<String>? taskSlugs,
    List<String>? rootTaskRunIds,
    List<String>? ownerIds,
    List<String>? workflowIds,
    List<String>? workflowVersionIds,
  }) =>
      paginate(
        (cursor, limit) => listPage(
          cursor: cursor,
          limit: limit,
          taskSlugs: taskSlugs,
          rootTaskRunIds: rootTaskRunIds,
          ownerIds: ownerIds,
          workflowIds: workflowIds,
          workflowVersionIds: workflowVersionIds,
        ),
        limit: pageSize,
        max: max,
      );

  /// Starts a run and waits for it to finish.
  ///
  /// Polls rather than streaming, which works on every platform including
  /// Flutter Web. See [events] for the push-based alternative and its
  /// platform caveat.
  Future<TaskRunDetails> run(
    String taskSlug,
    List<Object?> input, {
    Duration pollInterval = const Duration(milliseconds: 500),
    Duration? timeout,
  }) async {
    final started = await start(taskSlug, input);
    return waitFor(started.id, pollInterval: pollInterval, timeout: timeout);
  }

  /// Polls [taskRunId] until it reaches a terminal state.
  ///
  /// Does not throw when the run fails — inspect [TaskRunDetails.error]. It
  /// throws only if [timeout] elapses first.
  Future<TaskRunDetails> waitFor(
    String taskRunId, {
    Duration pollInterval = const Duration(milliseconds: 500),
    Duration? timeout,
  }) async {
    final deadline = timeout == null ? null : DateTime.now().add(timeout);

    while (true) {
      final details = await get(taskRunId);
      if (details.isTerminal) return details;

      if (deadline != null && DateTime.now().isAfter(deadline)) {
        throw TimeoutException(
          'Task run $taskRunId did not finish within ${timeout!.inSeconds}s '
          '(last status: ${details.status.name}).',
        );
      }
      await Future<void>.delayed(pollInterval);
    }
  }

  /// Streams runs as they reach a terminal state, over server-sent events.
  ///
  /// **Not usable on Flutter Web with the default HTTP client.**
  /// `package:http`'s `BrowserClient` is backed by `XMLHttpRequest` and
  /// buffers the whole response, so this will yield nothing until the
  /// connection closes. On the web either inject a streaming-capable client
  /// (`package:fetch_client`) or use [waitFor], which polls.
  Stream<TaskRunDetails> events(
    List<String> taskRunIds, {
    http.Client? httpClient,
  }) async* {
    if (taskRunIds.isEmpty) return;

    final client = httpClient ?? http.Client();
    final query = taskRunIds.map((id) => 'taskRunIds=$id').join('&');
    final request = http.Request(
      'GET',
      Uri.parse('${_client.baseUrl}/task-runs/events?$query'),
    )..headers.addAll(_client.authHeaders(accept: 'text/event-stream'));

    try {
      final response = await client.send(request);
      final lines = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      final data = StringBuffer();
      await for (final line in lines) {
        if (line.isEmpty) {
          // Blank line terminates an SSE frame.
          final payload = data.toString();
          data.clear();
          if (payload.isEmpty) continue;
          final decoded = jsonDecode(payload);
          if (decoded is Map<String, Object?>) {
            yield TaskRunDetails.fromJson(decoded);
          }
        } else if (line.startsWith('data:')) {
          data.write(line.substring(5).trimLeft());
        }
        // `id:`, `event:` and `retry:` carry nothing this client needs.
      }
    } finally {
      if (httpClient == null) client.close();
    }
  }

  /// Render rejects invocations whose arguments exceed 4 MB. Checking here
  /// means the error names the cause instead of surfacing as a generic
  /// rejection from the API.
  static void _assertInputWithinLimit(String taskSlug, List<Object?> input) {
    const limitBytes = 4 * 1024 * 1024;
    final encoded = utf8.encode(jsonEncode(input)).length;
    if (encoded > limitBytes) {
      throw ArgumentError.value(
        input,
        'input',
        'Input for "$taskSlug" is ${(encoded / 1048576).toStringAsFixed(2)} MB, '
            'over Render\'s 4 MB per-invocation limit. Pass a reference '
            '(an object key, a row id) instead of the payload itself.',
      );
    }
  }
}

/// Convenience predicates over a batch of runs.
extension TaskRunListX on Iterable<TaskRun> {
  bool get allTerminal => every((r) => r.isTerminal);
  Iterable<TaskRun> get failed => where((r) => r.status == TaskRunStatus.failed);
  Iterable<TaskRun> get children => where((r) => r.isChildRun);
}
