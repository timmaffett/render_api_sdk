import 'dart:async';

import '../client.dart';
import '../models/enums.dart';
import '../models/workflow.dart';
import '../pagination.dart';

/// Workflow service and workflow version endpoints.
///
/// Note two platform limits that no amount of client design can work around:
/// Blueprints (`render.yaml`) do not support Workflows, and Docker-based
/// workflows cannot be created through the API at all — only in the Dashboard.
/// [create] therefore covers native runtimes only.
class WorkflowsApi {
  const WorkflowsApi(this._client);

  final RenderApiClient _client;

  /// Lists workflows one page at a time.
  Future<Page<Workflow>> listPage({
    String? cursor,
    int limit = 20,
    List<String>? names,
    List<String>? ownerIds,
    List<String>? workflowIds,
    List<String>? environmentIds,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/workflows',
      query: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
        'name': names,
        'ownerId': ownerIds,
        'workflowID': workflowIds,
        'environmentId': environmentIds,
      },
    );
    return Page.fromJson(json, 'workflow', Workflow.fromJson);
  }

  /// Lists workflows across all pages.
  Stream<Workflow> list({
    int pageSize = 20,
    int? max,
    List<String>? names,
    List<String>? ownerIds,
    List<String>? environmentIds,
  }) =>
      paginate(
        (cursor, limit) => listPage(
          cursor: cursor,
          limit: limit,
          names: names,
          ownerIds: ownerIds,
          environmentIds: environmentIds,
        ),
        limit: pageSize,
        max: max,
      );

  Future<Workflow> get(String workflowId) async {
    final json = await _client.sendObject('GET', '/workflows/$workflowId');
    return Workflow.fromJson(json);
  }

  /// Creates a workflow service.
  ///
  /// [repo] must be a repository the Render Git app can read. When it cannot,
  /// Render responds `500 internal server error` with no explanation — the
  /// resulting [RenderServerException] carries a hint saying so.
  Future<Workflow> create({
    required String name,
    required String ownerId,
    required String repo,
    required String buildCommand,
    required String runCommand,
    WorkflowRuntime runtime = WorkflowRuntime.node,
    Region region = Region.oregon,
    String? branch,
    String? rootDir,
    AutoDeployTrigger? autoDeployTrigger,
    Map<String, String>? envVars,
  }) async {
    final json = await _client.sendObject(
      'POST',
      '/workflows',
      body: {
        'name': name,
        'ownerId': ownerId,
        'runCommand': runCommand,
        'region': region.wireValue,
        'buildConfig': {
          'repo': repo,
          'buildCommand': buildCommand,
          'runtime': runtime.wireValue,
          if (branch != null) 'branch': branch,
          if (rootDir != null) 'rootDir': rootDir,
        },
        if (autoDeployTrigger != null)
          'autoDeployTrigger': autoDeployTrigger.wireValue,
        if (envVars != null && envVars.isNotEmpty)
          'envVars': [
            for (final e in envVars.entries) {'key': e.key, 'value': e.value},
          ],
      },
    );
    return Workflow.fromJson(json);
  }

  /// Updates a workflow. Only the provided fields change.
  Future<Workflow> update(
    String workflowId, {
    String? name,
    String? runCommand,
    AutoDeployTrigger? autoDeployTrigger,
    WorkflowBuildConfig? buildConfig,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/workflows/$workflowId',
      body: {
        if (name != null) 'name': name,
        if (runCommand != null) 'runCommand': runCommand,
        if (autoDeployTrigger != null)
          'autoDeployTrigger': autoDeployTrigger.wireValue,
        if (buildConfig != null) 'buildConfig': buildConfig.toJson(),
      },
    );
    return Workflow.fromJson(json);
  }

  /// Deletes a workflow.
  ///
  /// The Render CLI has no equivalent command, so this is the only scriptable
  /// way to clean up workflows short of the Dashboard.
  Future<void> delete(String workflowId) =>
      _client.send('DELETE', '/workflows/$workflowId');

  /// Lists versions of a workflow, newest first.
  Future<Page<WorkflowVersion>> listVersionsPage({
    String? cursor,
    int limit = 20,
    List<String>? workflowIds,
    List<String>? ownerIds,
    List<String>? workflowVersionIds,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/workflowversions',
      query: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
        'workflowID': workflowIds,
        'ownerId': ownerIds,
        'workflowVersionId': workflowVersionIds,
      },
    );
    return Page.fromJson(json, 'workflowVersion', WorkflowVersion.fromJson);
  }

  /// Lists versions across all pages.
  Stream<WorkflowVersion> listVersions({
    String? workflowId,
    int pageSize = 20,
    int? max,
  }) =>
      paginate(
        (cursor, limit) => listVersionsPage(
          cursor: cursor,
          limit: limit,
          workflowIds: workflowId == null ? null : [workflowId],
        ),
        limit: pageSize,
        max: max,
      );

  Future<WorkflowVersion> getVersion(String workflowVersionId) async {
    final json =
        await _client.sendObject('GET', '/workflowversions/$workflowVersionId');
    return WorkflowVersion.fromJson(json);
  }

  /// Builds and registers a new version.
  ///
  /// Creating a workflow does **not** build one automatically when the target
  /// commit already exists, so this is usually required to get tasks
  /// registered for the first time. Pass [commit] to build a specific one.
  Future<void> deployVersion(String workflowId, {String? commit}) =>
      _client.send(
        'POST',
        '/workflowversions',
        body: {
          'workflowId': workflowId,
          if (commit != null) 'commit': commit,
        },
      );

  /// Waits for [workflowVersionId] to finish building and registering.
  ///
  /// Returns the terminal version — check [WorkflowVersion.status] for
  /// `ready`, `buildFailed` or `registrationFailed`.
  Future<WorkflowVersion> waitForVersion(
    String workflowVersionId, {
    Duration pollInterval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 20),
  }) async {
    final deadline = DateTime.now().add(timeout);

    while (true) {
      final version = await getVersion(workflowVersionId);
      if (version.status.isTerminal) return version;

      if (DateTime.now().isAfter(deadline)) {
        throw TimeoutException(
          'Workflow version $workflowVersionId was still '
          '${version.status.name} after ${timeout.inMinutes} minutes.',
        );
      }
      await Future<void>.delayed(pollInterval);
    }
  }
}
