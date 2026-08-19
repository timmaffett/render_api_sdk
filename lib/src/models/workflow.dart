import 'enums.dart';

DateTime? _date(Object? v) => v == null ? null : DateTime.tryParse(v as String);

/// How Render builds a workflow from source.
class WorkflowBuildConfig {
  const WorkflowBuildConfig({
    required this.repo,
    required this.buildCommand,
    required this.runtime,
    this.branch,
    this.rootDir,
  });

  factory WorkflowBuildConfig.fromJson(Map<String, Object?> json) =>
      WorkflowBuildConfig(
        repo: json['repo'] as String? ?? '',
        buildCommand: json['buildCommand'] as String? ?? '',
        runtime: WorkflowRuntime.fromWire(json['runtime'] as String?),
        branch: json['branch'] as String?,
        rootDir: json['rootDir'] as String?,
      );

  /// Repository URL Render builds from. It must be one the Render Git app has
  /// been granted access to — otherwise creation fails with a bare 500.
  final String repo;

  final String buildCommand;
  final WorkflowRuntime runtime;
  final String? branch;

  /// Subdirectory of the repository to build from.
  final String? rootDir;

  Map<String, Object?> toJson() => {
        'repo': repo,
        'buildCommand': buildCommand,
        'runtime': runtime.wireValue,
        if (branch != null) 'branch': branch,
        if (rootDir != null) 'rootDir': rootDir,
      };
}

/// A workflow service: the deployable unit that owns a set of tasks.
class Workflow {
  const Workflow({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.buildConfig,
    required this.runCommand,
    required this.region,
    this.slug,
    this.environmentId,
    this.autoDeployTrigger,
    this.createdAt,
    this.updatedAt,
  });

  factory Workflow.fromJson(Map<String, Object?> json) => Workflow(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        buildConfig: WorkflowBuildConfig.fromJson(
          json['buildConfig'] as Map<String, Object?>? ?? const {},
        ),
        runCommand: json['runCommand'] as String? ?? '',
        region: Region.fromWire(json['region'] as String?),
        slug: json['slug'] as String?,
        environmentId: json['environmentId'] as String?,
        autoDeployTrigger:
            AutoDeployTrigger.fromWire(json['autoDeployTrigger'] as String?),
        createdAt: _date(json['createdAt']),
        updatedAt: _date(json['updatedAt']),
      );

  final String id;
  final String name;
  final String ownerId;
  final WorkflowBuildConfig buildConfig;
  final String runCommand;
  final Region region;

  /// The slug used to build task identifiers, as `slug/task-name`.
  final String? slug;

  final String? environmentId;
  final AutoDeployTrigger? autoDeployTrigger;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// The identifier used to start a run of [taskName] in this workflow.
  String taskSlug(String taskName) => '${slug ?? name}/$taskName';

  @override
  String toString() => 'Workflow($id, $name)';
}

/// A built, registered version of a workflow. Tasks belong to a version, so a
/// version must reach [WorkflowVersionStatus.ready] before its tasks can run.
class WorkflowVersion {
  const WorkflowVersion({
    required this.id,
    required this.workflowId,
    required this.name,
    required this.status,
    required this.rawStatus,
    this.createdAt,
  });

  factory WorkflowVersion.fromJson(Map<String, Object?> json) => WorkflowVersion(
        id: json['id'] as String? ?? '',
        workflowId: json['workflowId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        status: WorkflowVersionStatus.fromWire(json['status'] as String?),
        rawStatus: json['status'] as String? ?? '',
        createdAt: _date(json['createdAt']),
      );

  final String id;
  final String workflowId;
  final String name;
  final WorkflowVersionStatus status;

  /// The status exactly as Render sent it.
  final String rawStatus;

  final DateTime? createdAt;

  @override
  String toString() => 'WorkflowVersion($id, ${status.name})';
}

/// A registered task definition.
class Task {
  const Task({
    required this.id,
    required this.name,
    this.workflowId,
    this.workflowVersionId,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, Object?> json) => Task(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        workflowId: json['workflowId'] as String?,
        workflowVersionId: json['workflowVersionId'] as String?,
        createdAt: _date(json['createdAt']),
      );

  final String id;
  final String name;
  final String? workflowId;
  final String? workflowVersionId;
  final DateTime? createdAt;

  @override
  String toString() => 'Task($id, $name)';
}
