// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import 'dart:core';

// ignore_for_file: unnecessary_this, prefer_single_quotes

/// Controls deployment behavior when triggering a deploy.
///
/// - `deploy_only`: Deploy the last successful build without rebuilding (minimizes downtime)
/// - `build_and_deploy`: Build new code and deploy it (default behavior when not specified)
///
/// **Note:** `deploy_only` cannot be combined with `commitId`, `imageUrl` or `clearCache` parameters,
/// as those are build related fields.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DeployMode {
  deployOnly('deploy_only'),
  buildAndDeploy('build_and_deploy'),
  /// A value this package does not know about.
  unknown('');

  const DeployMode(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DeployMode fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}


class AddUpdateEnvVarInput {
  const AddUpdateEnvVarInput(this.json);

  factory AddUpdateEnvVarInput.fromJson(Map<String, Object?> json) =>
      AddUpdateEnvVarInput(json);

  /// The spec declares no fixed properties for this type, so
  /// the payload is preserved verbatim.
  final Map<String, Object?> json;

  Map<String, Object?> toJson() => json;
}


/// The type of event that occurred
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum AuditLogEvent {
  acceptOrgInviteEvent('AcceptOrgInviteEvent'),
  acceptTeamInviteEvent('AcceptTeamInviteEvent'),
  addOrgMemberEvent('AddOrgMemberEvent'),
  applyBlueprintEvent('ApplyBlueprintEvent'),
  changeEnvironmentProtectionEvent('ChangeEnvironmentProtectionEvent'),
  changeOrg2FaenforcementEvent('ChangeOrg2FAEnforcementEvent'),
  changeOrgAllowedLoginMethodsEvent('ChangeOrgAllowedLoginMethodsEvent'),
  changeOrgNameEvent('ChangeOrgNameEvent'),
  changeOrgRoleEvent('ChangeOrgRoleEvent'),
  changeTeam2FaenforcementEvent('ChangeTeam2FAEnforcementEvent'),
  changeTeamAllowedLoginMethodsEvent('ChangeTeamAllowedLoginMethodsEvent'),
  changeTeamMemberRoleEvent('ChangeTeamMemberRoleEvent'),
  changeWorkspaceDeployHandlingEvent('ChangeWorkspaceDeployHandlingEvent'),
  changeWorkspacePrivacyEvent('ChangeWorkspacePrivacyEvent'),
  createArtifactSourceEvent('CreateArtifactSourceEvent'),
  createCronJobEvent('CreateCronJobEvent'),
  createEnvVarsEvent('CreateEnvVarsEvent'),
  createEnvironmentEvent('CreateEnvironmentEvent'),
  createOrgDomainEvent('CreateOrgDomainEvent'),
  createOtelIntegrationEvent('CreateOtelIntegrationEvent'),
  createPostgresEvent('CreatePostgresEvent'),
  createPrivateLinkEvent('CreatePrivateLinkEvent'),
  createProjectEvent('CreateProjectEvent'),
  createRedisEvent('CreateRedisEvent'),
  createSsoconnectionEvent('CreateSSOConnectionEvent'),
  createSavedSearchEvent('CreateSavedSearchEvent'),
  createServerDiskEvent('CreateServerDiskEvent'),
  createServerEvent('CreateServerEvent'),
  createWebhookEvent('CreateWebhookEvent'),
  createWorkspaceEvent('CreateWorkspaceEvent'),
  deleteCronJobEvent('DeleteCronJobEvent'),
  deleteEnvGroupEvent('DeleteEnvGroupEvent'),
  deleteEnvVarsEvent('DeleteEnvVarsEvent'),
  deleteEnvironmentEvent('DeleteEnvironmentEvent'),
  deleteOrgDomainEvent('DeleteOrgDomainEvent'),
  deleteOtelIntegrationEvent('DeleteOtelIntegrationEvent'),
  deletePostgresEvent('DeletePostgresEvent'),
  deletePrivateLinkEvent('DeletePrivateLinkEvent'),
  deleteProjectEvent('DeleteProjectEvent'),
  deleteRedisEvent('DeleteRedisEvent'),
  deleteSsoconnectionEvent('DeleteSSOConnectionEvent'),
  deleteSavedSearchEvent('DeleteSavedSearchEvent'),
  deleteServerDiskEvent('DeleteServerDiskEvent'),
  deleteServerEvent('DeleteServerEvent'),
  deleteWebhookEvent('DeleteWebhookEvent'),
  deleteWorkspaceEvent('DeleteWorkspaceEvent'),
  documentDownloadEvent('DocumentDownloadEvent'),
  downloadDatabaseBackupEvent('DownloadDatabaseBackupEvent'),
  enableRedisInternalAuthEvent('EnableRedisInternalAuthEvent'),
  inviteToOrgEvent('InviteToOrgEvent'),
  inviteToTeamEvent('InviteToTeamEvent'),
  joinTeamEvent('JoinTeamEvent'),
  loginEvent('LoginEvent'),
  logoutEvent('LogoutEvent'),
  maintenanceModeEnabledEvent('MaintenanceModeEnabledEvent'),
  maintenanceModeUriupdatedEvent('MaintenanceModeURIUpdatedEvent'),
  moveEnvironmentResourceEvent('MoveEnvironmentResourceEvent'),
  provisionOrganizationScimtoken('ProvisionOrganizationSCIMToken'),
  removeOrgMemberEvent('RemoveOrgMemberEvent'),
  removeUserFromTeamEvent('RemoveUserFromTeamEvent'),
  restoreDiskSnapshotEvent('RestoreDiskSnapshotEvent'),
  resumePostgresEvent('ResumePostgresEvent'),
  resumeServiceEvent('ResumeServiceEvent'),
  revokeOrganizationScimtoken('RevokeOrganizationSCIMToken'),
  signNdaevent('SignNDAEvent'),
  endShellEvent('EndShellEvent'),
  startShellEvent('StartShellEvent'),
  suspendPostgresEvent('SuspendPostgresEvent'),
  suspendServiceEvent('SuspendServiceEvent'),
  updateEnvVarsEvent('UpdateEnvVarsEvent'),
  updateIpallowListEvent('UpdateIPAllowListEvent'),
  updateOtelIntegrationEvent('UpdateOtelIntegrationEvent'),
  updateSsoconnectionEvent('UpdateSSOConnectionEvent'),
  updateServiceNameEvent('UpdateServiceNameEvent'),
  updateWebhookEvent('UpdateWebhookEvent'),
  verifyOrgDomainEvent('VerifyOrgDomainEvent'),
  viewConnectionInfoEvent('ViewConnectionInfoEvent'),
  viewEnvVarValuesEvent('ViewEnvVarValuesEvent'),
  grantOauthAccessEvent('GrantOAuthAccessEvent'),
  revokeOauthAccessEvent('RevokeOAuthAccessEvent'),
  /// A value this package does not know about.
  unknown('');

  const AuditLogEvent(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static AuditLogEvent fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// The status of the event
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum AuditLogStatus {
  success('success'),
  error('error'),
  /// A value this package does not know about.
  unknown('');

  const AuditLogStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static AuditLogStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// The type of actor that performed the action
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum AuditLogActorType {
  user('user'),
  restApi('rest_api'),
  system('system'),
  /// A value this package does not know about.
  unknown('');

  const AuditLogActorType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static AuditLogActorType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class AuditLogActor {
  const AuditLogActor({
    required this.type,
    this.email,
    this.id,
  });

  factory AuditLogActor.fromJson(Map<String, Object?> json) => AuditLogActor(
        type: AuditLogActorType.fromWire(json['type']),
        email: json['email'] as String?,
        id: json['id'] as String?,
      );

  /// The type of actor that performed the action
  final AuditLogActorType type;
  /// Email address of the actor (if applicable)
  final String? email;
  /// Unique identifier of the actor (if applicable)
  final String? id;

  Map<String, Object?> toJson() => {
        'type': type.wireValue,
        if (email != null) 'email': email,
        if (id != null) 'id': id,
      };
}

class AuditLog {
  const AuditLog({
    required this.id,
    required this.timestamp,
    required this.event,
    required this.status,
    required this.actor,
    required this.metadata,
  });

  factory AuditLog.fromJson(Map<String, Object?> json) => AuditLog(
        id: json['id'] as String? ?? '',
        timestamp: parseDate(json['timestamp']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        event: AuditLogEvent.fromWire(json['event']),
        status: AuditLogStatus.fromWire(json['status']),
        actor: AuditLogActor.fromJson((json['actor'] as Map<String, Object?>?) ?? const {}),
        metadata: (json['metadata'] as Map<String, Object?>?) ?? const {},
      );

  /// Unique identifier for the audit log entry
  final String id;
  /// When the event occurred (ISO 8601 format)
  final DateTime timestamp;
  /// The type of event that occurred
  final AuditLogEvent event;
  /// The status of the event
  final AuditLogStatus status;
  final AuditLogActor actor;
  /// Additional context information about the event
  final Map<String, Object?> metadata;

  Map<String, Object?> toJson() => {
        'id': id,
        'timestamp': timestamp.toIso8601String(),
        'event': event.wireValue,
        'status': status.wireValue,
        'actor': actor.toJson(),
        'metadata': metadata,
      };
}



class AuditLogWithCursor {
  const AuditLogWithCursor({
    required this.cursor,
    required this.auditLog,
  });

  factory AuditLogWithCursor.fromJson(Map<String, Object?> json) => AuditLogWithCursor(
        cursor: json['cursor'] as String? ?? '',
        auditLog: AuditLog.fromJson((json['auditLog'] as Map<String, Object?>?) ?? const {}),
      );

  final String cursor;
  final AuditLog auditLog;

  Map<String, Object?> toJson() => {
        'cursor': cursor,
        'auditLog': auditLog.toJson(),
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum AutoDeploy {
  yes('yes'),
  no('no'),
  /// A value this package does not know about.
  unknown('');

  const AutoDeploy(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static AutoDeploy fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}


class BackgroundWorkerDetailsAutoscalingCriteriaCpu {
  const BackgroundWorkerDetailsAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory BackgroundWorkerDetailsAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class BackgroundWorkerDetailsAutoscalingCriteriaMemory {
  const BackgroundWorkerDetailsAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory BackgroundWorkerDetailsAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class BackgroundWorkerDetailsAutoscalingCriteria {
  const BackgroundWorkerDetailsAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory BackgroundWorkerDetailsAutoscalingCriteria.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsAutoscalingCriteria(
        cpu: BackgroundWorkerDetailsAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: BackgroundWorkerDetailsAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final BackgroundWorkerDetailsAutoscalingCriteriaCpu cpu;
  final BackgroundWorkerDetailsAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class BackgroundWorkerDetailsAutoscaling {
  const BackgroundWorkerDetailsAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory BackgroundWorkerDetailsAutoscaling.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: BackgroundWorkerDetailsAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final BackgroundWorkerDetailsAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class BackgroundWorkerDetailsDisk {
  const BackgroundWorkerDetailsDisk({
    required this.id,
    required this.name,
    required this.sizeGb,
    required this.mountPath,
  });

  factory BackgroundWorkerDetailsDisk.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsDisk(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        sizeGb: (json['sizeGB'] as num?)?.toInt() ?? 0,
        mountPath: json['mountPath'] as String? ?? '',
      );

  final String id;
  final String name;
  final int sizeGb;
  final String mountPath;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'sizeGB': sizeGb,
        'mountPath': mountPath,
      };
}

/// This field has been deprecated, runtime should be used in its place.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceEnv {
  docker('docker'),
  elixir('elixir'),
  go('go'),
  node('node'),
  python('python'),
  ruby('ruby'),
  rust('rust'),
  image('image'),
  /// A value this package does not know about.
  unknown('');

  const ServiceEnv(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceEnv fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Resource {
  const Resource({
    required this.id,
    required this.name,
  });

  factory Resource.fromJson(Map<String, Object?> json) => Resource(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );

  final String id;
  final String name;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}

/// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum Plan {
  starter('starter'),
  starterPlus('starter_plus'),
  standard('standard'),
  standardPlus('standard_plus'),
  pro('pro'),
  proPlus('pro_plus'),
  proMax('pro_max'),
  proUltra('pro_ultra'),
  free('free'),
  custom('custom'),
  starterLegacy('starter_legacy'),
  standardLegacy('standard_legacy'),
  standardPlusLegacy('standard_plus_legacy'),
  proLegacy('pro_legacy'),
  proPlusLegacy('pro_plus_legacy'),
  /// A value this package does not know about.
  unknown('');

  const Plan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static Plan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// This field has been deprecated. previews.generation should be used in its place.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PullRequestPreviewsEnabled {
  yes('yes'),
  no('no'),
  /// A value this package does not know about.
  unknown('');

  const PullRequestPreviewsEnabled(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PullRequestPreviewsEnabled fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Defaults to "off"
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PreviewsGeneration {
  off('off'),
  manual('manual'),
  automatic('automatic'),
  /// A value this package does not know about.
  unknown('');

  const PreviewsGeneration(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PreviewsGeneration fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Previews {
  const Previews({
    this.generation,
  });

  factory Previews.fromJson(Map<String, Object?> json) => Previews(
        generation: PreviewsGeneration.fromWire(json['generation']),
      );

  /// Defaults to "off"
  final PreviewsGeneration? generation;

  Map<String, Object?> toJson() => {
        if (generation != null) 'generation': generation!.wireValue,
      };
}

/// Defaults to "oregon"
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum Region {
  frankfurt('frankfurt'),
  oregon('oregon'),
  ohio('ohio'),
  singapore('singapore'),
  virginia('virginia'),
  /// A value this package does not know about.
  unknown('');

  const Region(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static Region fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Runtime
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceRuntime {
  docker('docker'),
  elixir('elixir'),
  go('go'),
  node('node'),
  python('python'),
  ruby('ruby'),
  rust('rust'),
  image('image'),
  /// A value this package does not know about.
  unknown('');

  const ServiceRuntime(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceRuntime fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum BuildPlan {
  starter('starter'),
  performance('performance'),
  /// A value this package does not know about.
  unknown('');

  const BuildPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static BuildPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class BackgroundWorkerDetails {
  const BackgroundWorkerDetails({
    this.autoscaling,
    this.disk,
    required this.env,
    required this.envSpecificDetails,
    required this.numInstances,
    this.parentServer,
    required this.plan,
    this.pullRequestPreviewsEnabled,
    this.previews,
    required this.region,
    required this.runtime,
    this.sshAddress,
    required this.buildPlan,
    this.maxShutdownDelaySeconds,
  });

  factory BackgroundWorkerDetails.fromJson(Map<String, Object?> json) => BackgroundWorkerDetails(
        autoscaling: json['autoscaling'] == null ? null : BackgroundWorkerDetailsAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : BackgroundWorkerDetailsDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        envSpecificDetails: json['envSpecificDetails'],
        numInstances: (json['numInstances'] as num?)?.toInt() ?? 0,
        parentServer: json['parentServer'] == null ? null : Resource.fromJson(json['parentServer']! as Map<String, Object?>),
        plan: Plan.fromWire(json['plan']),
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        sshAddress: json['sshAddress'] as String?,
        buildPlan: BuildPlan.fromWire(json['buildPlan']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final BackgroundWorkerDetailsAutoscaling? autoscaling;
  final BackgroundWorkerDetailsDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv env;
  final Object? envSpecificDetails;
  /// For a *manually* scaled service, this is the number of instances the service is scaled to. DOES NOT indicate the number of running instances for an *autoscaled* service.
  final int numInstances;
  final Resource? parentServer;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan plan;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region region;
  /// Runtime
  final ServiceRuntime runtime;
  /// The SSH address for the service. Only present for services that have SSH enabled.
  final String? sshAddress;
  final BuildPlan buildPlan;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        'env': env.wireValue,
        'envSpecificDetails': envSpecificDetails,
        'numInstances': numInstances,
        if (parentServer != null) 'parentServer': parentServer!.toJson(),
        'plan': plan.wireValue,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        'region': region.wireValue,
        'runtime': runtime.wireValue,
        if (sshAddress != null) 'sshAddress': sshAddress,
        'buildPlan': buildPlan.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


/// Defaults to `starter` when creating a new database.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PaidPlan {
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  proMax('pro_max'),
  proUltra('pro_ultra'),
  /// A value this package does not know about.
  unknown('');

  const PaidPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PaidPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class BackgroundWorkerDetailsPatch {
  const BackgroundWorkerDetailsPatch({
    this.envSpecificDetails,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.runtime,
    this.maxShutdownDelaySeconds,
  });

  factory BackgroundWorkerDetailsPatch.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPatch(
        envSpecificDetails: json['envSpecificDetails'],
        plan: PaidPlan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final Object? envSpecificDetails;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Runtime
  final ServiceRuntime? runtime;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (runtime != null) 'runtime': runtime!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


class BackgroundWorkerDetailsPostAutoscalingCriteriaCpu {
  const BackgroundWorkerDetailsPostAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory BackgroundWorkerDetailsPostAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPostAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class BackgroundWorkerDetailsPostAutoscalingCriteriaMemory {
  const BackgroundWorkerDetailsPostAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory BackgroundWorkerDetailsPostAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPostAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class BackgroundWorkerDetailsPostAutoscalingCriteria {
  const BackgroundWorkerDetailsPostAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory BackgroundWorkerDetailsPostAutoscalingCriteria.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPostAutoscalingCriteria(
        cpu: BackgroundWorkerDetailsPostAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: BackgroundWorkerDetailsPostAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final BackgroundWorkerDetailsPostAutoscalingCriteriaCpu cpu;
  final BackgroundWorkerDetailsPostAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class BackgroundWorkerDetailsPostAutoscaling {
  const BackgroundWorkerDetailsPostAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory BackgroundWorkerDetailsPostAutoscaling.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPostAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: BackgroundWorkerDetailsPostAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final BackgroundWorkerDetailsPostAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class ServiceDisk {
  const ServiceDisk({
    required this.name,
    required this.mountPath,
    this.sizeGb,
  });

  factory ServiceDisk.fromJson(Map<String, Object?> json) => ServiceDisk(
        name: json['name'] as String? ?? '',
        mountPath: json['mountPath'] as String? ?? '',
        sizeGb: (json['sizeGB'] as num?)?.toInt(),
      );

  final String name;
  final String mountPath;
  /// Defaults to 1
  final int? sizeGb;

  Map<String, Object?> toJson() => {
        'name': name,
        'mountPath': mountPath,
        if (sizeGb != null) 'sizeGB': sizeGb,
      };
}

class BackgroundWorkerDetailsPost {
  const BackgroundWorkerDetailsPost({
    this.autoscaling,
    this.disk,
    this.env,
    required this.runtime,
    this.envSpecificDetails,
    this.numInstances,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.region,
    this.maxShutdownDelaySeconds,
  });

  factory BackgroundWorkerDetailsPost.fromJson(Map<String, Object?> json) => BackgroundWorkerDetailsPost(
        autoscaling: json['autoscaling'] == null ? null : BackgroundWorkerDetailsPostAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : ServiceDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        envSpecificDetails: json['envSpecificDetails'],
        numInstances: (json['numInstances'] as num?)?.toInt(),
        plan: PaidPlan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final BackgroundWorkerDetailsPostAutoscaling? autoscaling;
  final ServiceDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv? env;
  /// Runtime
  final ServiceRuntime runtime;
  final Object? envSpecificDetails;
  /// Defaults to 1
  final int? numInstances;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region? region;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        if (env != null) 'env': env!.wireValue,
        'runtime': runtime.wireValue,
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (numInstances != null) 'numInstances': numInstances,
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (region != null) 'region': region!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum BlueprintWithCursorBlueprintStatus {
  created('created'),
  paused('paused'),
  inSync('in_sync'),
  syncing('syncing'),
  error('error'),
  /// A value this package does not know about.
  unknown('');

  const BlueprintWithCursorBlueprintStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static BlueprintWithCursorBlueprintStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class BlueprintWithCursorBlueprint {
  const BlueprintWithCursorBlueprint({
    required this.id,
    required this.name,
    required this.status,
    required this.autoSync,
    required this.repo,
    required this.branch,
    required this.path,
    this.lastSync,
  });

  factory BlueprintWithCursorBlueprint.fromJson(Map<String, Object?> json) => BlueprintWithCursorBlueprint(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        status: BlueprintWithCursorBlueprintStatus.fromWire(json['status']),
        autoSync: json['autoSync'] as bool? ?? false,
        repo: json['repo'] as String? ?? '',
        branch: json['branch'] as String? ?? '',
        path: json['path'] as String? ?? '',
        lastSync: parseDate(json['lastSync']),
      );

  final String id;
  final String name;
  final BlueprintWithCursorBlueprintStatus status;
  /// Automatically sync changes to render.yaml
  final bool autoSync;
  final String repo;
  final String branch;
  /// Path to the Blueprint file in the repository
  final String path;
  final DateTime? lastSync;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'status': status.wireValue,
        'autoSync': autoSync,
        'repo': repo,
        'branch': branch,
        'path': path,
        if (lastSync != null) 'lastSync': lastSync!.toIso8601String(),
      };
}

/// A Blueprint with a cursor
class BlueprintWithCursor {
  const BlueprintWithCursor({
    required this.blueprint,
    required this.cursor,
  });

  factory BlueprintWithCursor.fromJson(Map<String, Object?> json) => BlueprintWithCursor(
        blueprint: BlueprintWithCursorBlueprint.fromJson((json['blueprint'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final BlueprintWithCursorBlueprint blueprint;
  final String cursor;

  Map<String, Object?> toJson() => {
        'blueprint': blueprint.toJson(),
        'cursor': cursor,
      };
}


class BuildFilter {
  const BuildFilter({
    required this.paths,
    required this.ignoredPaths,
  });

  factory BuildFilter.fromJson(Map<String, Object?> json) => BuildFilter(
        paths: ((json['paths'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        ignoredPaths: ((json['ignoredPaths'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
      );

  final List<String> paths;
  final List<String> ignoredPaths;

  Map<String, Object?> toJson() => {
        'paths': paths.map((e) => e).toList(),
        'ignoredPaths': ignoredPaths.map((e) => e).toList(),
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum CacheProfile {
  noCache('no-cache'),
  originControlled('origin-controlled'),
  originControlledAll('origin-controlled-all'),
  /// A value this package does not know about.
  unknown('');

  const CacheProfile(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static CacheProfile fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Cache {
  const Cache({
    required this.profile,
  });

  factory Cache.fromJson(Map<String, Object?> json) => Cache(
        profile: CacheProfile.fromWire(json['profile']),
      );

  final CacheProfile profile;

  Map<String, Object?> toJson() => {
        'profile': profile.wireValue,
      };
}


class CidrBlockAndDescription {
  const CidrBlockAndDescription({
    required this.cidrBlock,
    required this.description,
  });

  factory CidrBlockAndDescription.fromJson(Map<String, Object?> json) => CidrBlockAndDescription(
        cidrBlock: json['cidrBlock'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );

  final String cidrBlock;
  /// User-provided description of the CIDR block
  final String description;

  Map<String, Object?> toJson() => {
        'cidrBlock': cidrBlock,
        'description': description,
      };
}


class CronJobDetails {
  const CronJobDetails({
    required this.env,
    required this.envSpecificDetails,
    this.lastSuccessfulRunAt,
    required this.plan,
    required this.region,
    required this.runtime,
    required this.schedule,
    required this.buildPlan,
  });

  factory CronJobDetails.fromJson(Map<String, Object?> json) => CronJobDetails(
        env: ServiceEnv.fromWire(json['env']),
        envSpecificDetails: json['envSpecificDetails'],
        lastSuccessfulRunAt: parseDate(json['lastSuccessfulRunAt']),
        plan: Plan.fromWire(json['plan']),
        region: Region.fromWire(json['region']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        schedule: json['schedule'] as String? ?? '',
        buildPlan: BuildPlan.fromWire(json['buildPlan']),
      );

  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv env;
  final Object? envSpecificDetails;
  final DateTime? lastSuccessfulRunAt;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan plan;
  /// Defaults to "oregon"
  final Region region;
  /// Runtime
  final ServiceRuntime runtime;
  final String schedule;
  final BuildPlan buildPlan;

  Map<String, Object?> toJson() => {
        'env': env.wireValue,
        'envSpecificDetails': envSpecificDetails,
        if (lastSuccessfulRunAt != null) 'lastSuccessfulRunAt': lastSuccessfulRunAt!.toIso8601String(),
        'plan': plan.wireValue,
        'region': region.wireValue,
        'runtime': runtime.wireValue,
        'schedule': schedule,
        'buildPlan': buildPlan.wireValue,
      };
}


class CronJobDetailsPatch {
  const CronJobDetailsPatch({
    this.envSpecificDetails,
    this.plan,
    this.schedule,
    this.runtime,
  });

  factory CronJobDetailsPatch.fromJson(Map<String, Object?> json) => CronJobDetailsPatch(
        envSpecificDetails: json['envSpecificDetails'],
        plan: PaidPlan.fromWire(json['plan']),
        schedule: json['schedule'] as String?,
        runtime: ServiceRuntime.fromWire(json['runtime']),
      );

  final Object? envSpecificDetails;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  final String? schedule;
  /// Runtime
  final ServiceRuntime? runtime;

  Map<String, Object?> toJson() => {
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (plan != null) 'plan': plan!.wireValue,
        if (schedule != null) 'schedule': schedule,
        if (runtime != null) 'runtime': runtime!.wireValue,
      };
}


class CronJobDetailsPost {
  const CronJobDetailsPost({
    this.env,
    required this.runtime,
    this.envSpecificDetails,
    this.plan,
    this.region,
    required this.schedule,
  });

  factory CronJobDetailsPost.fromJson(Map<String, Object?> json) => CronJobDetailsPost(
        env: ServiceEnv.fromWire(json['env']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        envSpecificDetails: json['envSpecificDetails'],
        plan: PaidPlan.fromWire(json['plan']),
        region: Region.fromWire(json['region']),
        schedule: json['schedule'] as String? ?? '',
      );

  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv? env;
  /// Runtime
  final ServiceRuntime runtime;
  final Object? envSpecificDetails;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  /// Defaults to "oregon"
  final Region? region;
  final String schedule;

  Map<String, Object?> toJson() => {
        if (env != null) 'env': env!.wireValue,
        'runtime': runtime.wireValue,
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (plan != null) 'plan': plan!.wireValue,
        if (region != null) 'region': region!.wireValue,
        'schedule': schedule,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum CronJobRunStatus {
  pending('pending'),
  successful('successful'),
  unsuccessful('unsuccessful'),
  canceled('canceled'),
  /// A value this package does not know about.
  unknown('');

  const CronJobRunStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static CronJobRunStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// A run of a cron job
class CronJobRun {
  const CronJobRun({
    required this.id,
    required this.status,
    this.startedAt,
    this.finishedAt,
    this.triggeredBy,
    this.canceledBy,
  });

  factory CronJobRun.fromJson(Map<String, Object?> json) => CronJobRun(
        id: json['id'] as String? ?? '',
        status: CronJobRunStatus.fromWire(json['status']),
        startedAt: parseDate(json['startedAt']),
        finishedAt: parseDate(json['finishedAt']),
        triggeredBy: json['triggeredBy'] as String?,
        canceledBy: json['canceledBy'] as String?,
      );

  /// The ID of the run
  final String id;
  final CronJobRunStatus status;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  /// user who triggered the cron job run
  final String? triggeredBy;
  /// user who cancelled the cron job run
  final String? canceledBy;

  Map<String, Object?> toJson() => {
        'id': id,
        'status': status.wireValue,
        if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
        if (finishedAt != null) 'finishedAt': finishedAt!.toIso8601String(),
        if (triggeredBy != null) 'triggeredBy': triggeredBy,
        if (canceledBy != null) 'canceledBy': canceledBy,
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum CustomDomainDomainType {
  apex('apex'),
  subdomain('subdomain'),
  /// A value this package does not know about.
  unknown('');

  const CustomDomainDomainType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static CustomDomainDomainType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum CustomDomainVerificationStatus {
  verified('verified'),
  unverified('unverified'),
  /// A value this package does not know about.
  unknown('');

  const CustomDomainVerificationStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static CustomDomainVerificationStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class CustomDomainServer {
  const CustomDomainServer({
    this.id,
    this.name,
  });

  factory CustomDomainServer.fromJson(Map<String, Object?> json) => CustomDomainServer(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );

  final String? id;
  final String? name;

  Map<String, Object?> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
      };
}

class CustomDomain {
  const CustomDomain({
    required this.id,
    required this.name,
    required this.domainType,
    required this.publicSuffix,
    required this.redirectForName,
    required this.verificationStatus,
    required this.createdAt,
    this.server,
  });

  factory CustomDomain.fromJson(Map<String, Object?> json) => CustomDomain(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        domainType: CustomDomainDomainType.fromWire(json['domainType']),
        publicSuffix: json['publicSuffix'] as String? ?? '',
        redirectForName: json['redirectForName'] as String? ?? '',
        verificationStatus: CustomDomainVerificationStatus.fromWire(json['verificationStatus']),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        server: json['server'] == null ? null : CustomDomainServer.fromJson(json['server']! as Map<String, Object?>),
      );

  final String id;
  final String name;
  final CustomDomainDomainType domainType;
  final String publicSuffix;
  final String redirectForName;
  final CustomDomainVerificationStatus verificationStatus;
  final DateTime createdAt;
  final CustomDomainServer? server;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'domainType': domainType.wireValue,
        'publicSuffix': publicSuffix,
        'redirectForName': redirectForName,
        'verificationStatus': verificationStatus.wireValue,
        'createdAt': createdAt.toIso8601String(),
        if (server != null) 'server': server!.toJson(),
      };
}


class CustomDomainWithCursor {
  const CustomDomainWithCursor({
    required this.customDomain,
    required this.cursor,
  });

  factory CustomDomainWithCursor.fromJson(Map<String, Object?> json) => CustomDomainWithCursor(
        customDomain: CustomDomain.fromJson((json['customDomain'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final CustomDomain customDomain;
  final String cursor;

  Map<String, Object?> toJson() => {
        'customDomain': customDomain.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DatabaseRole {
  primary('primary'),
  replica('replica'),
  /// A value this package does not know about.
  unknown('');

  const DatabaseRole(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DatabaseRole fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DatabaseStatus {
  creating('creating'),
  available('available'),
  unavailable('unavailable'),
  configRestart('config_restart'),
  suspended('suspended'),
  maintenanceScheduled('maintenance_scheduled'),
  maintenanceInProgress('maintenance_in_progress'),
  recoveryFailed('recovery_failed'),
  recoveryInProgress('recovery_in_progress'),
  unknown('unknown'),
  updatingInstance('updating_instance'),
  /// A value this package does not know about.
  unknown_('');

  const DatabaseStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DatabaseStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown_,
      );
}


/// Current status of a dedicated IP set.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DedicatedIpstatus {
  unknown('UNKNOWN'),
  creating('CREATING'),
  pending('PENDING'),
  running('RUNNING'),
  failed('FAILED'),
  deleting('DELETING'),
  deleted('DELETED'),
  /// A value this package does not know about.
  unknown_('');

  const DedicatedIpstatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DedicatedIpstatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown_,
      );
}

class DedicatedIp {
  const DedicatedIp({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.region,
    required this.environmentIds,
    required this.ips,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory DedicatedIp.fromJson(Map<String, Object?> json) => DedicatedIp(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        region: Region.fromWire(json['region']),
        environmentIds: ((json['environmentIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        ips: ((json['ips'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        status: DedicatedIpstatus.fromWire(json['status']),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']),
      );

  /// Unique identifier for this dedicated IP set.
  final String id;
  /// Descriptive name for this dedicated IP set.
  final String name;
  /// Free-form description for this dedicated IP set.
  final String description;
  /// The ID of the workspace that owns this dedicated IP set.
  final String ownerId;
  /// Defaults to "oregon"
  final Region region;
  /// Environments this dedicated IP set applies to. If empty, it applies to all services in the workspace within its region.
  final List<String> environmentIds;
  /// The IPv4 addresses assigned to this dedicated IP set.
  final List<String> ips;
  /// Current status of a dedicated IP set.
  final DedicatedIpstatus status;
  /// Time the dedicated IP set was created.
  final DateTime createdAt;
  /// Time the dedicated IP set was last updated.
  final DateTime? updatedAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'ownerId': ownerId,
        'region': region.wireValue,
        'environmentIds': environmentIds.map((e) => e).toList(),
        'ips': ips.map((e) => e).toList(),
        'status': status.wireValue,
        'createdAt': createdAt.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };
}


/// Input for updating a dedicated IP set. All fields are optional. Omitted fields are left unchanged. Provide `environmentIds: []` to switch from environment-scoped to workspace-scoped.
class DedicatedIppatch {
  const DedicatedIppatch({
    this.name,
    this.description,
    this.environmentIds,
  });

  factory DedicatedIppatch.fromJson(Map<String, Object?> json) => DedicatedIppatch(
        name: json['name'] as String?,
        description: json['description'] as String?,
        environmentIds: (json['environmentIds'] as List<Object?>?)?.map((e) => e as String? ?? '').toList(),
      );

  final String? name;
  final String? description;
  final List<String>? environmentIds;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (environmentIds != null) 'environmentIds': environmentIds!.map((e) => e).toList(),
      };
}


/// Input for creating a dedicated IP set.
class DedicatedIppost {
  const DedicatedIppost({
    required this.name,
    this.description,
    required this.ownerId,
    required this.region,
    this.environmentIds,
  });

  factory DedicatedIppost.fromJson(Map<String, Object?> json) => DedicatedIppost(
        name: json['name'] as String? ?? '',
        description: json['description'] as String?,
        ownerId: json['ownerId'] as String? ?? '',
        region: Region.fromWire(json['region']),
        environmentIds: (json['environmentIds'] as List<Object?>?)?.map((e) => e as String? ?? '').toList(),
      );

  /// Name for the dedicated IP set.
  final String name;
  /// Free-form description for the dedicated IP set.
  final String? description;
  /// The ID of the workspace that will own this dedicated IP set.
  final String ownerId;
  /// Defaults to "oregon"
  final Region region;
  /// Environments to scope the dedicated IP set to. If omitted or empty, it applies to all services in the workspace within its region.
  final List<String>? environmentIds;

  Map<String, Object?> toJson() => {
        'name': name,
        if (description != null) 'description': description,
        'ownerId': ownerId,
        'region': region.wireValue,
        if (environmentIds != null) 'environmentIds': environmentIds!.map((e) => e).toList(),
      };
}



class DeployCommit {
  const DeployCommit({
    this.id,
    this.message,
    this.createdAt,
  });

  factory DeployCommit.fromJson(Map<String, Object?> json) => DeployCommit(
        id: json['id'] as String?,
        message: json['message'] as String?,
        createdAt: parseDate(json['createdAt']),
      );

  final String? id;
  final String? message;
  final DateTime? createdAt;

  Map<String, Object?> toJson() => {
        if (id != null) 'id': id,
        if (message != null) 'message': message,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };
}

/// Image information used when creating the deploy. Not present for Git-backed deploys
class DeployImage {
  const DeployImage({
    this.ref,
    this.sha,
    this.registryCredential,
  });

  factory DeployImage.fromJson(Map<String, Object?> json) => DeployImage(
        ref: json['ref'] as String?,
        sha: json['sha'] as String?,
        registryCredential: json['registryCredential'] as String?,
      );

  /// Image reference used when creating the deploy
  final String? ref;
  /// SHA that the image reference was resolved to when creating the deploy
  final String? sha;
  /// Name of credential used to pull the image, if provided
  final String? registryCredential;

  Map<String, Object?> toJson() => {
        if (ref != null) 'ref': ref,
        if (sha != null) 'sha': sha,
        if (registryCredential != null) 'registryCredential': registryCredential,
      };
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DeployStatus {
  created('created'),
  queued('queued'),
  buildInProgress('build_in_progress'),
  updateInProgress('update_in_progress'),
  live('live'),
  deactivated('deactivated'),
  buildFailed('build_failed'),
  updateFailed('update_failed'),
  canceled('canceled'),
  preDeployInProgress('pre_deploy_in_progress'),
  preDeployFailed('pre_deploy_failed'),
  /// A value this package does not know about.
  unknown('');

  const DeployStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DeployStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum DeployTrigger {
  api('api'),
  blueprintSync('blueprint_sync'),
  deployHook('deploy_hook'),
  deployedByRender('deployed_by_render'),
  manual('manual'),
  other('other'),
  newCommit('new_commit'),
  rollback('rollback'),
  serviceResumed('service_resumed'),
  serviceUpdated('service_updated'),
  /// A value this package does not know about.
  unknown('');

  const DeployTrigger(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static DeployTrigger fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Deploy {
  const Deploy({
    required this.id,
    this.commit,
    this.image,
    this.status,
    this.trigger,
    this.startedAt,
    this.finishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Deploy.fromJson(Map<String, Object?> json) => Deploy(
        id: json['id'] as String? ?? '',
        commit: json['commit'] == null ? null : DeployCommit.fromJson(json['commit']! as Map<String, Object?>),
        image: json['image'] == null ? null : DeployImage.fromJson(json['image']! as Map<String, Object?>),
        status: DeployStatus.fromWire(json['status']),
        trigger: DeployTrigger.fromWire(json['trigger']),
        startedAt: parseDate(json['startedAt']),
        finishedAt: parseDate(json['finishedAt']),
        createdAt: parseDate(json['createdAt']),
        updatedAt: parseDate(json['updatedAt']),
      );

  final String id;
  final DeployCommit? commit;
  /// Image information used when creating the deploy. Not present for Git-backed deploys
  final DeployImage? image;
  final DeployStatus? status;
  final DeployTrigger? trigger;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, Object?> toJson() => {
        'id': id,
        if (commit != null) 'commit': commit!.toJson(),
        if (image != null) 'image': image!.toJson(),
        if (status != null) 'status': status!.wireValue,
        if (trigger != null) 'trigger': trigger!.wireValue,
        if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
        if (finishedAt != null) 'finishedAt': finishedAt!.toIso8601String(),
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };
}




class DeployWithCursor {
  const DeployWithCursor({
    this.deploy,
    this.cursor,
  });

  factory DeployWithCursor.fromJson(Map<String, Object?> json) => DeployWithCursor(
        deploy: json['deploy'] == null ? null : Deploy.fromJson(json['deploy']! as Map<String, Object?>),
        cursor: json['cursor'] as String?,
      );

  final Deploy? deploy;
  final String? cursor;

  Map<String, Object?> toJson() => {
        if (deploy != null) 'deploy': deploy!.toJson(),
        if (cursor != null) 'cursor': cursor,
      };
}


class DiskSnapshot {
  const DiskSnapshot({
    this.createdAt,
    this.snapshotKey,
    this.instanceId,
  });

  factory DiskSnapshot.fromJson(Map<String, Object?> json) => DiskSnapshot(
        createdAt: parseDate(json['createdAt']),
        snapshotKey: json['snapshotKey'] as String?,
        instanceId: json['instanceId'] as String?,
      );

  final DateTime? createdAt;
  final String? snapshotKey;
  /// When a service with a disk is scaled, the instanceId is used to identify the instance that the disk is attached to. Each instance's disks get their own snapshots, and can be restored separately.
  final String? instanceId;

  Map<String, Object?> toJson() => {
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (snapshotKey != null) 'snapshotKey': snapshotKey,
        if (instanceId != null) 'instanceId': instanceId,
      };
}


class DiskWithCursorDisk {
  const DiskWithCursorDisk({
    required this.id,
    required this.name,
    required this.sizeGb,
    required this.mountPath,
    this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiskWithCursorDisk.fromJson(Map<String, Object?> json) => DiskWithCursorDisk(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        sizeGb: (json['sizeGB'] as num?)?.toInt() ?? 0,
        mountPath: json['mountPath'] as String? ?? '',
        serviceId: json['serviceId'] as String?,
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      );

  final String id;
  final String name;
  final int sizeGb;
  final String mountPath;
  final String? serviceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'sizeGB': sizeGb,
        'mountPath': mountPath,
        if (serviceId != null) 'serviceId': serviceId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

class DiskWithCursor {
  const DiskWithCursor({
    required this.disk,
    required this.cursor,
  });

  factory DiskWithCursor.fromJson(Map<String, Object?> json) => DiskWithCursor(
        disk: DiskWithCursorDisk.fromJson((json['disk'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final DiskWithCursorDisk disk;
  final String cursor;

  Map<String, Object?> toJson() => {
        'disk': disk.toJson(),
        'cursor': cursor,
      };
}


/// The registry to use this credential with
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum RegistryCredentialRegistry {
  github('GITHUB'),
  gitlab('GITLAB'),
  docker('DOCKER'),
  googleArtifact('GOOGLE_ARTIFACT'),
  awsEcr('AWS_ECR'),
  /// A value this package does not know about.
  unknown('');

  const RegistryCredentialRegistry(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static RegistryCredentialRegistry fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class RegistryCredential {
  const RegistryCredential({
    required this.id,
    required this.name,
    required this.registry,
    required this.username,
    required this.updatedAt,
  });

  factory RegistryCredential.fromJson(Map<String, Object?> json) => RegistryCredential(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        registry: RegistryCredentialRegistry.fromWire(json['registry']),
        username: json['username'] as String? ?? '',
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      );

  /// Unique identifier for this credential
  final String id;
  /// Descriptive name for this credential
  final String name;
  /// The registry to use this credential with
  final RegistryCredentialRegistry registry;
  /// The username associated with the credential
  final String username;
  /// Last updated time for the credential
  final DateTime updatedAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'registry': registry.wireValue,
        'username': username,
        'updatedAt': updatedAt.toIso8601String(),
      };
}

class DockerDetails {
  const DockerDetails({
    required this.dockerCommand,
    required this.dockerContext,
    required this.dockerfilePath,
    this.preDeployCommand,
    this.registryCredential,
  });

  factory DockerDetails.fromJson(Map<String, Object?> json) => DockerDetails(
        dockerCommand: json['dockerCommand'] as String? ?? '',
        dockerContext: json['dockerContext'] as String? ?? '',
        dockerfilePath: json['dockerfilePath'] as String? ?? '',
        preDeployCommand: json['preDeployCommand'] as String?,
        registryCredential: json['registryCredential'] == null ? null : RegistryCredential.fromJson(json['registryCredential']! as Map<String, Object?>),
      );

  final String dockerCommand;
  final String dockerContext;
  final String dockerfilePath;
  final String? preDeployCommand;
  final RegistryCredential? registryCredential;

  Map<String, Object?> toJson() => {
        'dockerCommand': dockerCommand,
        'dockerContext': dockerContext,
        'dockerfilePath': dockerfilePath,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (registryCredential != null) 'registryCredential': registryCredential!.toJson(),
      };
}


class DockerDetailsPatch {
  const DockerDetailsPatch({
    this.dockerCommand,
    this.dockerContext,
    this.dockerfilePath,
    this.registryCredentialId,
  });

  factory DockerDetailsPatch.fromJson(Map<String, Object?> json) => DockerDetailsPatch(
        dockerCommand: json['dockerCommand'] as String?,
        dockerContext: json['dockerContext'] as String?,
        dockerfilePath: json['dockerfilePath'] as String?,
        registryCredentialId: json['registryCredentialId'] as String?,
      );

  final String? dockerCommand;
  final String? dockerContext;
  final String? dockerfilePath;
  final String? registryCredentialId;

  Map<String, Object?> toJson() => {
        if (dockerCommand != null) 'dockerCommand': dockerCommand,
        if (dockerContext != null) 'dockerContext': dockerContext,
        if (dockerfilePath != null) 'dockerfilePath': dockerfilePath,
        if (registryCredentialId != null) 'registryCredentialId': registryCredentialId,
      };
}


class DockerDetailsPost {
  const DockerDetailsPost({
    this.dockerCommand,
    this.dockerContext,
    this.dockerfilePath,
    this.registryCredentialId,
  });

  factory DockerDetailsPost.fromJson(Map<String, Object?> json) => DockerDetailsPost(
        dockerCommand: json['dockerCommand'] as String?,
        dockerContext: json['dockerContext'] as String?,
        dockerfilePath: json['dockerfilePath'] as String?,
        registryCredentialId: json['registryCredentialId'] as String?,
      );

  final String? dockerCommand;
  final String? dockerContext;
  /// Defaults to "./Dockerfile"
  final String? dockerfilePath;
  final String? registryCredentialId;

  Map<String, Object?> toJson() => {
        if (dockerCommand != null) 'dockerCommand': dockerCommand,
        if (dockerContext != null) 'dockerContext': dockerContext,
        if (dockerfilePath != null) 'dockerfilePath': dockerfilePath,
        if (registryCredentialId != null) 'registryCredentialId': registryCredentialId,
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceTypeShort {
  static_('static'),
  web('web'),
  pserv('pserv'),
  worker('worker'),
  cron('cron'),
  /// A value this package does not know about.
  unknown('');

  const ServiceTypeShort(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceTypeShort fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class EnvGroupLink {
  const EnvGroupLink({
    required this.id,
    required this.name,
    required this.type,
  });

  factory EnvGroupLink.fromJson(Map<String, Object?> json) => EnvGroupLink(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        type: ServiceTypeShort.fromWire(json['type']),
      );

  final String id;
  final String name;
  final ServiceTypeShort type;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'type': type.wireValue,
      };
}


class EnvGroupMeta {
  const EnvGroupMeta({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceLinks,
    this.environmentId,
  });

  factory EnvGroupMeta.fromJson(Map<String, Object?> json) => EnvGroupMeta(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        serviceLinks: ((json['serviceLinks'] as List<Object?>?) ?? const []).map((e) => EnvGroupLink.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
      );

  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  /// List of serviceIds linked to the envGroup
  final List<EnvGroupLink> serviceLinks;
  final String? environmentId;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'serviceLinks': serviceLinks.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
      };
}


class EnvGroupPatchinput {
  const EnvGroupPatchinput({
    required this.name,
  });

  factory EnvGroupPatchinput.fromJson(Map<String, Object?> json) => EnvGroupPatchinput(
        name: json['name'] as String? ?? '',
      );

  final String name;

  Map<String, Object?> toJson() => {
        'name': name,
      };
}


class EnvGroupPostinputSecretFilesItem {
  const EnvGroupPostinputSecretFilesItem({
    required this.name,
    required this.content,
  });

  factory EnvGroupPostinputSecretFilesItem.fromJson(Map<String, Object?> json) => EnvGroupPostinputSecretFilesItem(
        name: json['name'] as String? ?? '',
        content: json['content'] as String? ?? '',
      );

  final String name;
  final String content;

  Map<String, Object?> toJson() => {
        'name': name,
        'content': content,
      };
}

class EnvGroupPostinput {
  const EnvGroupPostinput({
    required this.name,
    required this.ownerId,
    required this.envVars,
    this.secretFiles,
    this.serviceIds,
    this.environmentId,
  });

  factory EnvGroupPostinput.fromJson(Map<String, Object?> json) => EnvGroupPostinput(
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        envVars: ((json['envVars'] as List<Object?>?) ?? const []).map((e) => (e as Map<String, Object?>?) ?? const {}).toList(),
        secretFiles: (json['secretFiles'] as List<Object?>?)?.map((e) => EnvGroupPostinputSecretFilesItem.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        serviceIds: (json['serviceIds'] as List<Object?>?)?.map((e) => e as String? ?? '').toList(),
        environmentId: json['environmentId'] as String?,
      );

  final String name;
  final String ownerId;
  final List<Map<String, Object?>> envVars;
  final List<EnvGroupPostinputSecretFilesItem>? secretFiles;
  final List<String>? serviceIds;
  final String? environmentId;

  Map<String, Object?> toJson() => {
        'name': name,
        'ownerId': ownerId,
        'envVars': envVars.map((e) => e).toList(),
        if (secretFiles != null) 'secretFiles': secretFiles!.map((e) => e.toJson()).toList(),
        if (serviceIds != null) 'serviceIds': serviceIds!.map((e) => e).toList(),
        if (environmentId != null) 'environmentId': environmentId,
      };
}





class EnvVar {
  const EnvVar({
    required this.key,
    required this.value,
  });

  factory EnvVar.fromJson(Map<String, Object?> json) => EnvVar(
        key: json['key'] as String? ?? '',
        value: json['value'] as String? ?? '',
      );

  final String key;
  final String value;

  Map<String, Object?> toJson() => {
        'key': key,
        'value': value,
      };
}


class EnvVarGenerateValue {
  const EnvVarGenerateValue({
    required this.generateValue,
  });

  factory EnvVarGenerateValue.fromJson(Map<String, Object?> json) => EnvVarGenerateValue(
        generateValue: json['generateValue'] as bool? ?? false,
      );

  final bool generateValue;

  Map<String, Object?> toJson() => {
        'generateValue': generateValue,
      };
}


class EnvVarValue {
  const EnvVarValue({
    required this.value,
  });

  factory EnvVarValue.fromJson(Map<String, Object?> json) => EnvVarValue(
        value: json['value'] as String? ?? '',
      );

  final String value;

  Map<String, Object?> toJson() => {
        'value': value,
      };
}


class EnvVarWithCursor {
  const EnvVarWithCursor({
    required this.envVar,
    required this.cursor,
  });

  factory EnvVarWithCursor.fromJson(Map<String, Object?> json) => EnvVarWithCursor(
        envVar: EnvVar.fromJson((json['envVar'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final EnvVar envVar;
  final String cursor;

  Map<String, Object?> toJson() => {
        'envVar': envVar.toJson(),
        'cursor': cursor,
      };
}


/// Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ProtectedStatus {
  unprotected('unprotected'),
  protected('protected'),
  /// A value this package does not know about.
  unknown('');

  const ProtectedStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ProtectedStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Environment {
  const Environment({
    required this.id,
    required this.name,
    required this.projectId,
    required this.databasesIds,
    this.ipAllowList,
    required this.redisIds,
    required this.serviceIds,
    required this.envGroupIds,
    required this.protectedStatus,
    required this.networkIsolationEnabled,
  });

  factory Environment.fromJson(Map<String, Object?> json) => Environment(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        projectId: json['projectId'] as String? ?? '',
        databasesIds: ((json['databasesIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        redisIds: ((json['redisIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        serviceIds: ((json['serviceIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        envGroupIds: ((json['envGroupIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
        protectedStatus: ProtectedStatus.fromWire(json['protectedStatus']),
        networkIsolationEnabled: json['networkIsolationEnabled'] as bool? ?? false,
      );

  final String id;
  final String name;
  final String projectId;
  final List<String> databasesIds;
  final List<CidrBlockAndDescription>? ipAllowList;
  final List<String> redisIds;
  final List<String> serviceIds;
  final List<String> envGroupIds;
  /// Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments.
  final ProtectedStatus protectedStatus;
  /// Indicates whether network connections across environments are allowed.
  final bool networkIsolationEnabled;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'projectId': projectId,
        'databasesIds': databasesIds.map((e) => e).toList(),
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        'redisIds': redisIds.map((e) => e).toList(),
        'serviceIds': serviceIds.map((e) => e).toList(),
        'envGroupIds': envGroupIds.map((e) => e).toList(),
        'protectedStatus': protectedStatus.wireValue,
        'networkIsolationEnabled': networkIsolationEnabled,
      };
}


class EnvironmentPatchinput {
  const EnvironmentPatchinput({
    this.name,
    this.networkIsolationEnabled,
    this.protectedStatus,
    this.ipAllowList,
  });

  factory EnvironmentPatchinput.fromJson(Map<String, Object?> json) => EnvironmentPatchinput(
        name: json['name'] as String?,
        networkIsolationEnabled: json['networkIsolationEnabled'] as bool?,
        protectedStatus: ProtectedStatus.fromWire(json['protectedStatus']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String? name;
  /// Indicates whether network connections across environments are allowed.
  final bool? networkIsolationEnabled;
  /// Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments.
  final ProtectedStatus? protectedStatus;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
        if (networkIsolationEnabled != null) 'networkIsolationEnabled': networkIsolationEnabled,
        if (protectedStatus != null) 'protectedStatus': protectedStatus!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


class EnvironmentPostinput {
  const EnvironmentPostinput({
    required this.name,
    required this.projectId,
    this.protectedStatus,
    this.networkIsolationEnabled,
    this.ipAllowList,
  });

  factory EnvironmentPostinput.fromJson(Map<String, Object?> json) => EnvironmentPostinput(
        name: json['name'] as String? ?? '',
        projectId: json['projectId'] as String? ?? '',
        protectedStatus: ProtectedStatus.fromWire(json['protectedStatus']),
        networkIsolationEnabled: json['networkIsolationEnabled'] as bool?,
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String name;
  final String projectId;
  /// Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments.
  final ProtectedStatus? protectedStatus;
  /// Indicates whether network connections across environments are allowed.
  final bool? networkIsolationEnabled;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        'name': name,
        'projectId': projectId,
        if (protectedStatus != null) 'protectedStatus': protectedStatus!.wireValue,
        if (networkIsolationEnabled != null) 'networkIsolationEnabled': networkIsolationEnabled,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


class EnvironmentResourcesPostinput {
  const EnvironmentResourcesPostinput({
    required this.resourceIds,
  });

  factory EnvironmentResourcesPostinput.fromJson(Map<String, Object?> json) => EnvironmentResourcesPostinput(
        resourceIds: ((json['resourceIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
      );

  final List<String> resourceIds;

  Map<String, Object?> toJson() => {
        'resourceIds': resourceIds.map((e) => e).toList(),
      };
}


/// An environment with a cursor
class EnvironmentWithCursor {
  const EnvironmentWithCursor({
    required this.environment,
    required this.cursor,
  });

  factory EnvironmentWithCursor.fromJson(Map<String, Object?> json) => EnvironmentWithCursor(
        environment: Environment.fromJson((json['environment'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final Environment environment;
  final String cursor;

  Map<String, Object?> toJson() => {
        'environment': environment.toJson(),
        'cursor': cursor,
      };
}


class Error {
  const Error({
    this.id,
    this.message,
    this.code,
  });

  factory Error.fromJson(Map<String, Object?> json) => Error(
        id: json['id'] as String?,
        message: json['message'] as String?,
        code: json['code'] as String?,
      );

  final String? id;
  final String? message;
  /// A stable, machine-readable identifier present on specific errors that clients can handle specially. Each endpoint documents the codes it can return. The errorCode schema lists the full vocabulary of codes.
  final String? code;

  Map<String, Object?> toJson() => {
        if (id != null) 'id': id,
        if (message != null) 'message': message,
        if (code != null) 'code': code,
      };
}


/// The machine-readable codes that can appear in the error object's "code" field. The field is a plain string so new codes are not breaking changes; this vocabulary exists so generated clients get typed constants. OpenAPI cannot deprecate individual enum values, so deprecation notes live in x-enum-descriptions.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ErrorCode {
  multipleRegions('multiple_regions'),
  duplicateSavedSearchName('duplicate_saved_search_name'),
  tooManyResources('too_many_resources'),
  /// A value this package does not know about.
  unknown('');

  const ErrorCode(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ErrorCode fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}


class Header {
  const Header({
    required this.id,
    required this.path,
    required this.name,
    required this.value,
  });

  factory Header.fromJson(Map<String, Object?> json) => Header(
        id: json['id'] as String? ?? '',
        path: json['path'] as String? ?? '',
        name: json['name'] as String? ?? '',
        value: json['value'] as String? ?? '',
      );

  final String id;
  final String path;
  final String name;
  final String value;

  Map<String, Object?> toJson() => {
        'id': id,
        'path': path,
        'name': name,
        'value': value,
      };
}


class HeaderInput {
  const HeaderInput({
    required this.path,
    required this.name,
    required this.value,
  });

  factory HeaderInput.fromJson(Map<String, Object?> json) => HeaderInput(
        path: json['path'] as String? ?? '',
        name: json['name'] as String? ?? '',
        value: json['value'] as String? ?? '',
      );

  /// The request path to add the header to. Wildcards will cause headers to be applied to all matching paths.
  final String path;
  /// Header name
  final String name;
  /// Header value
  final String value;

  Map<String, Object?> toJson() => {
        'path': path,
        'name': name,
        'value': value,
      };
}


class HeaderWithCursor {
  const HeaderWithCursor({
    required this.header,
    required this.cursor,
  });

  factory HeaderWithCursor.fromJson(Map<String, Object?> json) => HeaderWithCursor(
        header: Header.fromJson((json['header'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final Header header;
  final String cursor;

  Map<String, Object?> toJson() => {
        'header': header.toJson(),
        'cursor': cursor,
      };
}


class Image {
  const Image({
    required this.ownerId,
    this.registryCredentialId,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, Object?> json) => Image(
        ownerId: json['ownerId'] as String? ?? '',
        registryCredentialId: json['registryCredentialId'] as String?,
        imagePath: json['imagePath'] as String? ?? '',
      );

  /// The ID of the owner for this image. This should match the owner of the service as well as the owner of any specified registry credential.
  final String ownerId;
  /// Optional reference to the registry credential passed to the image repository to retrieve this image.
  final String? registryCredentialId;
  /// Path to the image used for this server (e.g docker.io/library/nginx:latest).
  final String imagePath;

  Map<String, Object?> toJson() => {
        'ownerId': ownerId,
        if (registryCredentialId != null) 'registryCredentialId': registryCredentialId,
        'imagePath': imagePath,
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum JobWithCursorJobStatus {
  pending('pending'),
  running('running'),
  succeeded('succeeded'),
  failed('failed'),
  canceled('canceled'),
  /// A value this package does not know about.
  unknown('');

  const JobWithCursorJobStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static JobWithCursorJobStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class JobWithCursorJob {
  const JobWithCursorJob({
    required this.id,
    required this.serviceId,
    required this.startCommand,
    required this.planId,
    this.status,
    required this.createdAt,
    this.startedAt,
    this.finishedAt,
  });

  factory JobWithCursorJob.fromJson(Map<String, Object?> json) => JobWithCursorJob(
        id: json['id'] as String? ?? '',
        serviceId: json['serviceId'] as String? ?? '',
        startCommand: json['startCommand'] as String? ?? '',
        planId: json['planId'] as String? ?? '',
        status: JobWithCursorJobStatus.fromWire(json['status']),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        startedAt: parseDate(json['startedAt']),
        finishedAt: parseDate(json['finishedAt']),
      );

  final String id;
  final String serviceId;
  final String startCommand;
  final String planId;
  final JobWithCursorJobStatus? status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'serviceId': serviceId,
        'startCommand': startCommand,
        'planId': planId,
        if (status != null) 'status': status!.wireValue,
        'createdAt': createdAt.toIso8601String(),
        if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
        if (finishedAt != null) 'finishedAt': finishedAt!.toIso8601String(),
      };
}

class JobWithCursor {
  const JobWithCursor({
    required this.job,
    required this.cursor,
  });

  factory JobWithCursor.fromJson(Map<String, Object?> json) => JobWithCursor(
        job: JobWithCursorJob.fromJson((json['job'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final JobWithCursorJob job;
  final String cursor;

  Map<String, Object?> toJson() => {
        'job': job.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum KeyValuePlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  /// A value this package does not know about.
  unknown('');

  const KeyValuePlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static KeyValuePlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum OwnerType {
  user('user'),
  team('team'),
  /// A value this package does not know about.
  unknown('');

  const OwnerType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static OwnerType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Owner {
  const Owner({
    required this.id,
    required this.name,
    required this.email,
    this.ipAllowList,
    this.twoFactorAuthEnabled,
    required this.type,
  });

  factory Owner.fromJson(Map<String, Object?> json) => Owner(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        twoFactorAuthEnabled: json['twoFactorAuthEnabled'] as bool?,
        type: OwnerType.fromWire(json['type']),
      );

  final String id;
  final String name;
  final String email;
  final List<CidrBlockAndDescription>? ipAllowList;
  /// Whether two-factor authentication is enabled for the owner. Only present if `type` is `user`.
  final bool? twoFactorAuthEnabled;
  final OwnerType type;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (twoFactorAuthEnabled != null) 'twoFactorAuthEnabled': twoFactorAuthEnabled,
        'type': type.wireValue,
      };
}

/// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PersistenceMode {
  journalSnapshot('journal_snapshot'),
  snapshot('snapshot'),
  off('off'),
  /// A value this package does not know about.
  unknown('');

  const PersistenceMode(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PersistenceMode fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Options for a Key Value instance
class KeyValueOptions {
  const KeyValueOptions({
    this.maxmemoryPolicy,
    this.persistenceMode,
  });

  factory KeyValueOptions.fromJson(Map<String, Object?> json) => KeyValueOptions(
        maxmemoryPolicy: json['maxmemoryPolicy'] as String?,
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
      );

  final String? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;

  Map<String, Object?> toJson() => {
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
      };
}

/// A Key Value instance
class KeyValue {
  const KeyValue({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.region,
    required this.plan,
    required this.name,
    required this.owner,
    required this.options,
    required this.ipAllowList,
    this.environmentId,
    required this.version,
    required this.dashboardUrl,
  });

  factory KeyValue.fromJson(Map<String, Object?> json) => KeyValue(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        status: DatabaseStatus.fromWire(json['status']),
        region: Region.fromWire(json['region']),
        plan: KeyValuePlan.fromWire(json['plan']),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        options: KeyValueOptions.fromJson((json['options'] as Map<String, Object?>?) ?? const {}),
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
        version: json['version'] as String? ?? '',
        dashboardUrl: json['dashboardUrl'] as String? ?? '',
      );

  /// The ID of the Key Value instance
  final String id;
  /// The creation time of the Key Value instance
  final DateTime createdAt;
  /// The last updated time of the Key Value instance
  final DateTime updatedAt;
  final DatabaseStatus status;
  /// Defaults to "oregon"
  final Region region;
  final KeyValuePlan plan;
  /// The name of the Key Value instance
  final String name;
  final Owner owner;
  /// Options for a Key Value instance
  final KeyValueOptions options;
  /// The IP allow list for the Key Value instance
  final List<CidrBlockAndDescription> ipAllowList;
  /// The ID of the environment the Key Value instance is associated with
  final String? environmentId;
  /// The version of Key Value
  final String version;
  /// The URL to view the Key Value instance in the Render Dashboard
  final String dashboardUrl;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'status': status.wireValue,
        'region': region.wireValue,
        'plan': plan.wireValue,
        'name': name,
        'owner': owner.toJson(),
        'options': options.toJson(),
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
        'version': version,
        'dashboardUrl': dashboardUrl,
      };
}


/// A Key Value instance
class KeyValueConnectionInfo {
  const KeyValueConnectionInfo({
    required this.internalConnectionString,
    required this.externalConnectionString,
    required this.cliCommand,
  });

  factory KeyValueConnectionInfo.fromJson(Map<String, Object?> json) => KeyValueConnectionInfo(
        internalConnectionString: json['internalConnectionString'] as String? ?? '',
        externalConnectionString: json['externalConnectionString'] as String? ?? '',
        cliCommand: json['cliCommand'] as String? ?? '',
      );

  /// The connection string to use from within Render
  final String internalConnectionString;
  /// The connection string to use from outside Render
  final String externalConnectionString;
  /// The CLI (redis-cli or valkey-cli) command to connect to the Key Value instance
  final String cliCommand;

  Map<String, Object?> toJson() => {
        'internalConnectionString': internalConnectionString,
        'externalConnectionString': externalConnectionString,
        'cliCommand': cliCommand,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum KeyValueDetailMaintenanceState {
  scheduled('scheduled'),
  inProgress('in_progress'),
  userFixRequired('user_fix_required'),
  cancelled('cancelled'),
  succeeded('succeeded'),
  failed('failed'),
  /// A value this package does not know about.
  unknown('');

  const KeyValueDetailMaintenanceState(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static KeyValueDetailMaintenanceState fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class KeyValueDetailMaintenance {
  const KeyValueDetailMaintenance({
    required this.id,
    required this.type,
    required this.scheduledAt,
    this.pendingMaintenanceBy,
    required this.state,
  });

  factory KeyValueDetailMaintenance.fromJson(Map<String, Object?> json) => KeyValueDetailMaintenance(
        id: json['id'] as String? ?? '',
        type: json['type'] as String? ?? '',
        scheduledAt: parseDate(json['scheduledAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        pendingMaintenanceBy: parseDate(json['pendingMaintenanceBy']),
        state: KeyValueDetailMaintenanceState.fromWire(json['state']),
      );

  final String id;
  final String type;
  final DateTime scheduledAt;
  /// If present, the maintenance run cannot be scheduled for later than this date-time.
  final DateTime? pendingMaintenanceBy;
  final KeyValueDetailMaintenanceState state;

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type,
        'scheduledAt': scheduledAt.toIso8601String(),
        if (pendingMaintenanceBy != null) 'pendingMaintenanceBy': pendingMaintenanceBy!.toIso8601String(),
        'state': state.wireValue,
      };
}

/// A Key Value instance
class KeyValueDetail {
  const KeyValueDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.region,
    required this.plan,
    required this.name,
    required this.owner,
    required this.options,
    required this.ipAllowList,
    this.environmentId,
    required this.version,
    this.maintenance,
  });

  factory KeyValueDetail.fromJson(Map<String, Object?> json) => KeyValueDetail(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        status: DatabaseStatus.fromWire(json['status']),
        region: Region.fromWire(json['region']),
        plan: KeyValuePlan.fromWire(json['plan']),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        options: KeyValueOptions.fromJson((json['options'] as Map<String, Object?>?) ?? const {}),
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
        version: json['version'] as String? ?? '',
        maintenance: json['maintenance'] == null ? null : KeyValueDetailMaintenance.fromJson(json['maintenance']! as Map<String, Object?>),
      );

  /// The ID of the Key Value instance
  final String id;
  /// The creation time of the Key Value instance
  final DateTime createdAt;
  /// The last updated time of the Key Value instance
  final DateTime updatedAt;
  final DatabaseStatus status;
  /// Defaults to "oregon"
  final Region region;
  final KeyValuePlan plan;
  /// The name of the Key Value instance
  final String name;
  final Owner owner;
  /// Options for a Key Value instance
  final KeyValueOptions options;
  /// The IP allow list for the Key Value instance
  final List<CidrBlockAndDescription> ipAllowList;
  /// The ID of the environment the Key Value instance is associated with
  final String? environmentId;
  /// The version of Key Value
  final String version;
  final KeyValueDetailMaintenance? maintenance;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'status': status.wireValue,
        'region': region.wireValue,
        'plan': plan.wireValue,
        'name': name,
        'owner': owner.toJson(),
        'options': options.toJson(),
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
        'version': version,
        if (maintenance != null) 'maintenance': maintenance!.toJson(),
      };
}



/// The eviction policy for the Key Value instance
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum MaxmemoryPolicy {
  noeviction('noeviction'),
  allkeysLfu('allkeys_lfu'),
  allkeysLru('allkeys_lru'),
  allkeysRandom('allkeys_random'),
  volatileLfu('volatile_lfu'),
  volatileLru('volatile_lru'),
  volatileRandom('volatile_random'),
  volatileTtl('volatile_ttl'),
  /// A value this package does not know about.
  unknown('');

  const MaxmemoryPolicy(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static MaxmemoryPolicy fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Input type for updating a Key Value instance
class KeyValuePatchinput {
  const KeyValuePatchinput({
    this.name,
    this.plan,
    this.maxmemoryPolicy,
    this.persistenceMode,
    this.ipAllowList,
  });

  factory KeyValuePatchinput.fromJson(Map<String, Object?> json) => KeyValuePatchinput(
        name: json['name'] as String?,
        plan: KeyValuePlan.fromWire(json['plan']),
        maxmemoryPolicy: MaxmemoryPolicy.fromWire(json['maxmemoryPolicy']),
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  /// The name of the Key Value instance
  final String? name;
  final KeyValuePlan? plan;
  /// The eviction policy for the Key Value instance
  final MaxmemoryPolicy? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
        if (plan != null) 'plan': plan!.wireValue,
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy!.wireValue,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


/// Input type for creating a Key Value instance
class KeyValuePostinput {
  const KeyValuePostinput({
    required this.name,
    required this.ownerId,
    required this.plan,
    this.region,
    this.environmentId,
    this.maxmemoryPolicy,
    this.persistenceMode,
    this.ipAllowList,
  });

  factory KeyValuePostinput.fromJson(Map<String, Object?> json) => KeyValuePostinput(
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        plan: KeyValuePlan.fromWire(json['plan']),
        region: Region.fromWire(json['region']),
        environmentId: json['environmentId'] as String?,
        maxmemoryPolicy: MaxmemoryPolicy.fromWire(json['maxmemoryPolicy']),
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  /// The name of the Key Value instance
  final String name;
  /// The ID of the owner of the Key Value instance
  final String ownerId;
  final KeyValuePlan plan;
  /// Defaults to "oregon"
  final Region? region;
  final String? environmentId;
  /// The eviction policy for the Key Value instance
  final MaxmemoryPolicy? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        'name': name,
        'ownerId': ownerId,
        'plan': plan.wireValue,
        if (region != null) 'region': region!.wireValue,
        if (environmentId != null) 'environmentId': environmentId,
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy!.wireValue,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}



class KeyValueWithCursor {
  const KeyValueWithCursor({
    required this.keyValue,
    required this.cursor,
  });

  factory KeyValueWithCursor.fromJson(Map<String, Object?> json) => KeyValueWithCursor(
        keyValue: KeyValue.fromJson((json['keyValue'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  /// A Key Value instance
  final KeyValue keyValue;
  final String cursor;

  Map<String, Object?> toJson() => {
        'keyValue': keyValue.toJson(),
        'cursor': cursor,
      };
}


class MaintenanceMode {
  const MaintenanceMode({
    required this.enabled,
    required this.uri,
  });

  factory MaintenanceMode.fromJson(Map<String, Object?> json) => MaintenanceMode(
        enabled: json['enabled'] as bool? ?? false,
        uri: json['uri'] as String? ?? '',
      );

  final bool enabled;
  /// The page to be served when [maintenance mode](https://render.com/docs/maintenance-mode) is enabled. When empty, the default maintenance mode page is served.
  final String uri;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'uri': uri,
      };
}




class NativeEnvironmentDetails {
  const NativeEnvironmentDetails({
    required this.buildCommand,
    required this.startCommand,
    this.preDeployCommand,
  });

  factory NativeEnvironmentDetails.fromJson(Map<String, Object?> json) => NativeEnvironmentDetails(
        buildCommand: json['buildCommand'] as String? ?? '',
        startCommand: json['startCommand'] as String? ?? '',
        preDeployCommand: json['preDeployCommand'] as String?,
      );

  final String buildCommand;
  final String startCommand;
  final String? preDeployCommand;

  Map<String, Object?> toJson() => {
        'buildCommand': buildCommand,
        'startCommand': startCommand,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
      };
}


class NativeEnvironmentDetailsPatch {
  const NativeEnvironmentDetailsPatch({
    this.buildCommand,
    this.startCommand,
  });

  factory NativeEnvironmentDetailsPatch.fromJson(Map<String, Object?> json) => NativeEnvironmentDetailsPatch(
        buildCommand: json['buildCommand'] as String?,
        startCommand: json['startCommand'] as String?,
      );

  final String? buildCommand;
  final String? startCommand;

  Map<String, Object?> toJson() => {
        if (buildCommand != null) 'buildCommand': buildCommand,
        if (startCommand != null) 'startCommand': startCommand,
      };
}


/// Fields for native environment (runtime) services
class NativeEnvironmentDetailsPost {
  const NativeEnvironmentDetailsPost({
    required this.buildCommand,
    required this.startCommand,
  });

  factory NativeEnvironmentDetailsPost.fromJson(Map<String, Object?> json) => NativeEnvironmentDetailsPost(
        buildCommand: json['buildCommand'] as String? ?? '',
        startCommand: json['startCommand'] as String? ?? '',
      );

  final String buildCommand;
  final String startCommand;

  Map<String, Object?> toJson() => {
        'buildCommand': buildCommand,
        'startCommand': startCommand,
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum NotificationOverrideWithCursorOverridePreviewNotificationsEnabled {
  default_('default'),
  false_('false'),
  true_('true'),
  /// A value this package does not know about.
  unknown('');

  const NotificationOverrideWithCursorOverridePreviewNotificationsEnabled(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static NotificationOverrideWithCursorOverridePreviewNotificationsEnabled fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum NotificationOverrideWithCursorOverrideNotificationsToSend {
  default_('default'),
  none('none'),
  failure('failure'),
  all('all'),
  /// A value this package does not know about.
  unknown('');

  const NotificationOverrideWithCursorOverrideNotificationsToSend(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static NotificationOverrideWithCursorOverrideNotificationsToSend fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class NotificationOverrideWithCursorOverride {
  const NotificationOverrideWithCursorOverride({
    required this.serviceId,
    required this.previewNotificationsEnabled,
    required this.notificationsToSend,
  });

  factory NotificationOverrideWithCursorOverride.fromJson(Map<String, Object?> json) => NotificationOverrideWithCursorOverride(
        serviceId: json['serviceId'] as String? ?? '',
        previewNotificationsEnabled: NotificationOverrideWithCursorOverridePreviewNotificationsEnabled.fromWire(json['previewNotificationsEnabled']),
        notificationsToSend: NotificationOverrideWithCursorOverrideNotificationsToSend.fromWire(json['notificationsToSend']),
      );

  final String serviceId;
  final NotificationOverrideWithCursorOverridePreviewNotificationsEnabled previewNotificationsEnabled;
  final NotificationOverrideWithCursorOverrideNotificationsToSend notificationsToSend;

  Map<String, Object?> toJson() => {
        'serviceId': serviceId,
        'previewNotificationsEnabled': previewNotificationsEnabled.wireValue,
        'notificationsToSend': notificationsToSend.wireValue,
      };
}

class NotificationOverrideWithCursor {
  const NotificationOverrideWithCursor({
    required this.override,
    required this.cursor,
  });

  factory NotificationOverrideWithCursor.fromJson(Map<String, Object?> json) => NotificationOverrideWithCursor(
        override: NotificationOverrideWithCursorOverride.fromJson((json['override'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final NotificationOverrideWithCursorOverride override;
  final String cursor;

  Map<String, Object?> toJson() => {
        'override': override.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum NotifySetting {
  default_('default'),
  notify('notify'),
  ignore('ignore'),
  /// A value this package does not know about.
  unknown('');

  const NotifySetting(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static NotifySetting fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}


/// `dedicated` if a dedicated IP set applies to the resource, `shared` if its traffic originates from the shared Render IPs for its region.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum OutboundIpsType {
  shared('shared'),
  dedicated('dedicated'),
  /// A value this package does not know about.
  unknown('');

  const OutboundIpsType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static OutboundIpsType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class OutboundIps {
  const OutboundIps({
    required this.type,
    this.dedicatedIpId,
    required this.ips,
  });

  factory OutboundIps.fromJson(Map<String, Object?> json) => OutboundIps(
        type: OutboundIpsType.fromWire(json['type']),
        dedicatedIpId: json['dedicatedIpId'] as String?,
        ips: ((json['ips'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
      );

  /// `dedicated` if a dedicated IP set applies to the resource, `shared` if its traffic originates from the shared Render IPs for its region.
  final OutboundIpsType type;
  /// The dedicated IP set the traffic originates from. Only present when `type` is `dedicated`.
  final String? dedicatedIpId;
  /// The IP addresses the resource's outbound traffic originates from.
  final List<String> ips;

  Map<String, Object?> toJson() => {
        'type': type.wireValue,
        if (dedicatedIpId != null) 'dedicatedIpId': dedicatedIpId,
        'ips': ips.map((e) => e).toList(),
      };
}



class OwnerWithCursor {
  const OwnerWithCursor({
    this.owner,
    this.cursor,
  });

  factory OwnerWithCursor.fromJson(Map<String, Object?> json) => OwnerWithCursor(
        owner: json['owner'] == null ? null : Owner.fromJson(json['owner']! as Map<String, Object?>),
        cursor: json['cursor'] as String?,
      );

  final Owner? owner;
  final String? cursor;

  Map<String, Object?> toJson() => {
        if (owner != null) 'owner': owner!.toJson(),
        if (cursor != null) 'cursor': cursor,
      };
}





/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresPlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  basic256mb('basic_256mb'),
  basic1gb('basic_1gb'),
  basic4gb('basic_4gb'),
  pro4gb('pro_4gb'),
  pro8gb('pro_8gb'),
  pro16gb('pro_16gb'),
  pro32gb('pro_32gb'),
  pro64gb('pro_64gb'),
  pro128gb('pro_128gb'),
  pro192gb('pro_192gb'),
  pro256gb('pro_256gb'),
  pro384gb('pro_384gb'),
  pro512gb('pro_512gb'),
  accelerated16gb('accelerated_16gb'),
  accelerated32gb('accelerated_32gb'),
  accelerated64gb('accelerated_64gb'),
  accelerated128gb('accelerated_128gb'),
  accelerated256gb('accelerated_256gb'),
  accelerated384gb('accelerated_384gb'),
  accelerated512gb('accelerated_512gb'),
  accelerated768gb('accelerated_768gb'),
  accelerated1024gb('accelerated_1024gb'),
  /// A value this package does not know about.
  unknown('');

  const PostgresPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class ReadReplica {
  const ReadReplica({
    required this.id,
    required this.name,
    this.parameterOverrides,
  });

  factory ReadReplica.fromJson(Map<String, Object?> json) => ReadReplica(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        parameterOverrides: json['parameterOverrides'] as Map<String, Object?>?,
      );

  /// The replica instance identifier.
  final String id;
  /// The display name of the replica instance.
  final String name;
  final Map<String, Object?>? parameterOverrides;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        if (parameterOverrides != null) 'parameterOverrides': parameterOverrides,
      };
}

/// The PostgreSQL version
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresVersion {
  v11('11'),
  v12('12'),
  v13('13'),
  v14('14'),
  v15('15'),
  v16('16'),
  v17('17'),
  v18('18'),
  /// A value this package does not know about.
  unknown('');

  const PostgresVersion(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresVersion fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresSuspended {
  suspended('suspended'),
  notSuspended('not_suspended'),
  /// A value this package does not know about.
  unknown('');

  const PostgresSuspended(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresSuspended fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum SuspenderType {
  admin('admin'),
  billing('billing'),
  user('user'),
  parentService('parent_service'),
  stuckCrashlooping('stuck_crashlooping'),
  hipaaEnablement('hipaa_enablement'),
  unknown('unknown'),
  /// A value this package does not know about.
  unknown_('');

  const SuspenderType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static SuspenderType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown_,
      );
}

class Postgres {
  const Postgres({
    required this.id,
    required this.ipAllowList,
    required this.createdAt,
    required this.updatedAt,
    this.expiresAt,
    required this.databaseName,
    required this.databaseUser,
    this.environmentId,
    required this.highAvailabilityEnabled,
    required this.name,
    required this.owner,
    required this.plan,
    this.diskSizeGb,
    this.primaryPostgresId,
    required this.region,
    required this.readReplicas,
    required this.role,
    required this.status,
    required this.version,
    required this.suspended,
    required this.suspenders,
    required this.dashboardUrl,
    required this.diskAutoscalingEnabled,
    required this.connectionPool,
  });

  factory Postgres.fromJson(Map<String, Object?> json) => Postgres(
        id: json['id'] as String? ?? '',
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        expiresAt: parseDate(json['expiresAt']),
        databaseName: json['databaseName'] as String? ?? '',
        databaseUser: json['databaseUser'] as String? ?? '',
        environmentId: json['environmentId'] as String?,
        highAvailabilityEnabled: json['highAvailabilityEnabled'] as bool? ?? false,
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        plan: PostgresPlan.fromWire(json['plan']),
        diskSizeGb: (json['diskSizeGB'] as num?)?.toInt(),
        primaryPostgresId: json['primaryPostgresID'] as String?,
        region: Region.fromWire(json['region']),
        readReplicas: ((json['readReplicas'] as List<Object?>?) ?? const []).map((e) => ReadReplica.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        role: DatabaseRole.fromWire(json['role']),
        status: DatabaseStatus.fromWire(json['status']),
        version: PostgresVersion.fromWire(json['version']),
        suspended: PostgresSuspended.fromWire(json['suspended']),
        suspenders: ((json['suspenders'] as List<Object?>?) ?? const []).map((e) => SuspenderType.fromWire(e)).toList(),
        dashboardUrl: json['dashboardUrl'] as String? ?? '',
        diskAutoscalingEnabled: json['diskAutoscalingEnabled'] as bool? ?? false,
        connectionPool: json['connectionPool'] as String? ?? '',
      );

  final String id;
  final List<CidrBlockAndDescription> ipAllowList;
  final DateTime createdAt;
  final DateTime updatedAt;
  /// The time at which the database will be expire. Applies to free tier databases only.
  final DateTime? expiresAt;
  final String databaseName;
  final String databaseUser;
  final String? environmentId;
  final bool highAvailabilityEnabled;
  final String name;
  final Owner owner;
  final PostgresPlan plan;
  final int? diskSizeGb;
  final String? primaryPostgresId;
  /// Defaults to "oregon"
  final Region region;
  final List<ReadReplica> readReplicas;
  final DatabaseRole role;
  final DatabaseStatus status;
  /// The PostgreSQL version
  final PostgresVersion version;
  final PostgresSuspended suspended;
  final List<SuspenderType> suspenders;
  /// The URL to view the Postgres instance in the Render Dashboard
  final String dashboardUrl;
  final bool diskAutoscalingEnabled;
  /// What connection pool to use (if any) out of 'pgbouncer' and 'none'
  final String connectionPool;

  Map<String, Object?> toJson() => {
        'id': id,
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
        'databaseName': databaseName,
        'databaseUser': databaseUser,
        if (environmentId != null) 'environmentId': environmentId,
        'highAvailabilityEnabled': highAvailabilityEnabled,
        'name': name,
        'owner': owner.toJson(),
        'plan': plan.wireValue,
        if (diskSizeGb != null) 'diskSizeGB': diskSizeGb,
        if (primaryPostgresId != null) 'primaryPostgresID': primaryPostgresId,
        'region': region.wireValue,
        'readReplicas': readReplicas.map((e) => e.toJson()).toList(),
        'role': role.wireValue,
        'status': status.wireValue,
        'version': version.wireValue,
        'suspended': suspended.wireValue,
        'suspenders': suspenders.map((e) => e.wireValue).toList(),
        'dashboardUrl': dashboardUrl,
        'diskAutoscalingEnabled': diskAutoscalingEnabled,
        'connectionPool': connectionPool,
      };
}


class PostgresConnectionInfo {
  const PostgresConnectionInfo({
    required this.password,
    required this.internalConnectionString,
    required this.externalConnectionString,
    this.internalConnectionPoolString,
    this.externalConnectionPoolString,
    required this.psqlCommand,
  });

  factory PostgresConnectionInfo.fromJson(Map<String, Object?> json) => PostgresConnectionInfo(
        password: json['password'] as String? ?? '',
        internalConnectionString: json['internalConnectionString'] as String? ?? '',
        externalConnectionString: json['externalConnectionString'] as String? ?? '',
        internalConnectionPoolString: json['internalConnectionPoolString'] as String?,
        externalConnectionPoolString: json['externalConnectionPoolString'] as String?,
        psqlCommand: json['psqlCommand'] as String? ?? '',
      );

  final String password;
  final String internalConnectionString;
  final String externalConnectionString;
  final String? internalConnectionPoolString;
  final String? externalConnectionPoolString;
  final String psqlCommand;

  Map<String, Object?> toJson() => {
        'password': password,
        'internalConnectionString': internalConnectionString,
        'externalConnectionString': externalConnectionString,
        if (internalConnectionPoolString != null) 'internalConnectionPoolString': internalConnectionPoolString,
        if (externalConnectionPoolString != null) 'externalConnectionPoolString': externalConnectionPoolString,
        'psqlCommand': psqlCommand,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresDetailMaintenanceState {
  scheduled('scheduled'),
  inProgress('in_progress'),
  userFixRequired('user_fix_required'),
  cancelled('cancelled'),
  succeeded('succeeded'),
  failed('failed'),
  /// A value this package does not know about.
  unknown('');

  const PostgresDetailMaintenanceState(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresDetailMaintenanceState fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class PostgresDetailMaintenance {
  const PostgresDetailMaintenance({
    required this.id,
    required this.type,
    required this.scheduledAt,
    this.pendingMaintenanceBy,
    required this.state,
  });

  factory PostgresDetailMaintenance.fromJson(Map<String, Object?> json) => PostgresDetailMaintenance(
        id: json['id'] as String? ?? '',
        type: json['type'] as String? ?? '',
        scheduledAt: parseDate(json['scheduledAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        pendingMaintenanceBy: parseDate(json['pendingMaintenanceBy']),
        state: PostgresDetailMaintenanceState.fromWire(json['state']),
      );

  final String id;
  final String type;
  final DateTime scheduledAt;
  /// If present, the maintenance run cannot be scheduled for later than this date-time.
  final DateTime? pendingMaintenanceBy;
  final PostgresDetailMaintenanceState state;

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type,
        'scheduledAt': scheduledAt.toIso8601String(),
        if (pendingMaintenanceBy != null) 'pendingMaintenanceBy': pendingMaintenanceBy!.toIso8601String(),
        'state': state.wireValue,
      };
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresDetailPlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  basic256mb('basic_256mb'),
  basic1gb('basic_1gb'),
  basic4gb('basic_4gb'),
  pro4gb('pro_4gb'),
  pro8gb('pro_8gb'),
  pro16gb('pro_16gb'),
  pro32gb('pro_32gb'),
  pro64gb('pro_64gb'),
  pro128gb('pro_128gb'),
  pro192gb('pro_192gb'),
  pro256gb('pro_256gb'),
  pro384gb('pro_384gb'),
  pro512gb('pro_512gb'),
  accelerated16gb('accelerated_16gb'),
  accelerated32gb('accelerated_32gb'),
  accelerated64gb('accelerated_64gb'),
  accelerated128gb('accelerated_128gb'),
  accelerated256gb('accelerated_256gb'),
  accelerated384gb('accelerated_384gb'),
  accelerated512gb('accelerated_512gb'),
  accelerated768gb('accelerated_768gb'),
  accelerated1024gb('accelerated_1024gb'),
  /// A value this package does not know about.
  unknown('');

  const PostgresDetailPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresDetailPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresDetailSuspended {
  suspended('suspended'),
  notSuspended('not_suspended'),
  /// A value this package does not know about.
  unknown('');

  const PostgresDetailSuspended(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresDetailSuspended fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class PostgresDetail {
  const PostgresDetail({
    required this.id,
    required this.ipAllowList,
    required this.createdAt,
    required this.updatedAt,
    this.expiresAt,
    required this.dashboardUrl,
    required this.databaseName,
    required this.databaseUser,
    this.environmentId,
    required this.highAvailabilityEnabled,
    this.maintenance,
    required this.name,
    required this.owner,
    required this.plan,
    this.diskSizeGb,
    this.parameterOverrides,
    this.primaryPostgresId,
    required this.region,
    required this.readReplicas,
    required this.role,
    required this.status,
    required this.version,
    required this.suspended,
    required this.suspenders,
    required this.diskAutoscalingEnabled,
    required this.connectionPool,
  });

  factory PostgresDetail.fromJson(Map<String, Object?> json) => PostgresDetail(
        id: json['id'] as String? ?? '',
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        expiresAt: parseDate(json['expiresAt']),
        dashboardUrl: json['dashboardUrl'] as String? ?? '',
        databaseName: json['databaseName'] as String? ?? '',
        databaseUser: json['databaseUser'] as String? ?? '',
        environmentId: json['environmentId'] as String?,
        highAvailabilityEnabled: json['highAvailabilityEnabled'] as bool? ?? false,
        maintenance: json['maintenance'] == null ? null : PostgresDetailMaintenance.fromJson(json['maintenance']! as Map<String, Object?>),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        plan: PostgresDetailPlan.fromWire(json['plan']),
        diskSizeGb: (json['diskSizeGB'] as num?)?.toInt(),
        parameterOverrides: json['parameterOverrides'] as Map<String, Object?>?,
        primaryPostgresId: json['primaryPostgresID'] as String?,
        region: Region.fromWire(json['region']),
        readReplicas: ((json['readReplicas'] as List<Object?>?) ?? const []).map((e) => ReadReplica.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        role: DatabaseRole.fromWire(json['role']),
        status: DatabaseStatus.fromWire(json['status']),
        version: PostgresVersion.fromWire(json['version']),
        suspended: PostgresDetailSuspended.fromWire(json['suspended']),
        suspenders: ((json['suspenders'] as List<Object?>?) ?? const []).map((e) => SuspenderType.fromWire(e)).toList(),
        diskAutoscalingEnabled: json['diskAutoscalingEnabled'] as bool? ?? false,
        connectionPool: json['connectionPool'] as String? ?? '',
      );

  final String id;
  final List<CidrBlockAndDescription> ipAllowList;
  final DateTime createdAt;
  final DateTime updatedAt;
  /// The time at which the database will be expire. Applies to free tier databases only.
  final DateTime? expiresAt;
  /// The URL to view the Postgres instance in the Render Dashboard
  final String dashboardUrl;
  final String databaseName;
  final String databaseUser;
  final String? environmentId;
  final bool highAvailabilityEnabled;
  final PostgresDetailMaintenance? maintenance;
  final String name;
  final Owner owner;
  final PostgresDetailPlan plan;
  final int? diskSizeGb;
  final Map<String, Object?>? parameterOverrides;
  final String? primaryPostgresId;
  /// Defaults to "oregon"
  final Region region;
  final List<ReadReplica> readReplicas;
  final DatabaseRole role;
  final DatabaseStatus status;
  /// The PostgreSQL version
  final PostgresVersion version;
  final PostgresDetailSuspended suspended;
  final List<SuspenderType> suspenders;
  final bool diskAutoscalingEnabled;
  /// What connection pool to use (if any) out of 'pgbouncer' and 'none'
  final String connectionPool;

  Map<String, Object?> toJson() => {
        'id': id,
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
        'dashboardUrl': dashboardUrl,
        'databaseName': databaseName,
        'databaseUser': databaseUser,
        if (environmentId != null) 'environmentId': environmentId,
        'highAvailabilityEnabled': highAvailabilityEnabled,
        if (maintenance != null) 'maintenance': maintenance!.toJson(),
        'name': name,
        'owner': owner.toJson(),
        'plan': plan.wireValue,
        if (diskSizeGb != null) 'diskSizeGB': diskSizeGb,
        if (parameterOverrides != null) 'parameterOverrides': parameterOverrides,
        if (primaryPostgresId != null) 'primaryPostgresID': primaryPostgresId,
        'region': region.wireValue,
        'readReplicas': readReplicas.map((e) => e.toJson()).toList(),
        'role': role.wireValue,
        'status': status.wireValue,
        'version': version.wireValue,
        'suspended': suspended.wireValue,
        'suspenders': suspenders.map((e) => e.wireValue).toList(),
        'diskAutoscalingEnabled': diskAutoscalingEnabled,
        'connectionPool': connectionPool,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresPatchinputPlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  basic256mb('basic_256mb'),
  basic1gb('basic_1gb'),
  basic4gb('basic_4gb'),
  pro4gb('pro_4gb'),
  pro8gb('pro_8gb'),
  pro16gb('pro_16gb'),
  pro32gb('pro_32gb'),
  pro64gb('pro_64gb'),
  pro128gb('pro_128gb'),
  pro192gb('pro_192gb'),
  pro256gb('pro_256gb'),
  pro384gb('pro_384gb'),
  pro512gb('pro_512gb'),
  accelerated16gb('accelerated_16gb'),
  accelerated32gb('accelerated_32gb'),
  accelerated64gb('accelerated_64gb'),
  accelerated128gb('accelerated_128gb'),
  accelerated256gb('accelerated_256gb'),
  accelerated384gb('accelerated_384gb'),
  accelerated512gb('accelerated_512gb'),
  accelerated768gb('accelerated_768gb'),
  accelerated1024gb('accelerated_1024gb'),
  /// A value this package does not know about.
  unknown('');

  const PostgresPatchinputPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresPatchinputPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class ReadReplicaInput {
  const ReadReplicaInput({
    required this.name,
    this.parameterOverrides,
  });

  factory ReadReplicaInput.fromJson(Map<String, Object?> json) => ReadReplicaInput(
        name: json['name'] as String? ?? '',
        parameterOverrides: json['parameterOverrides'] as Map<String, Object?>?,
      );

  /// The display name of the replica instance.
  final String name;
  final Map<String, Object?>? parameterOverrides;

  Map<String, Object?> toJson() => {
        'name': name,
        if (parameterOverrides != null) 'parameterOverrides': parameterOverrides,
      };
}

class PostgresPatchinput {
  const PostgresPatchinput({
    this.name,
    this.plan,
    this.diskSizeGb,
    this.enableDiskAutoscaling,
    this.connectionPool,
    this.enableHighAvailability,
    this.datadogApikey,
    this.datadogSite,
    this.ipAllowList,
    this.parameterOverrides,
    this.readReplicas,
  });

  factory PostgresPatchinput.fromJson(Map<String, Object?> json) => PostgresPatchinput(
        name: json['name'] as String?,
        plan: PostgresPatchinputPlan.fromWire(json['plan']),
        diskSizeGb: (json['diskSizeGB'] as num?)?.toInt(),
        enableDiskAutoscaling: json['enableDiskAutoscaling'] as bool?,
        connectionPool: json['connectionPool'] as String?,
        enableHighAvailability: json['enableHighAvailability'] as bool?,
        datadogApikey: json['datadogAPIKey'] as String?,
        datadogSite: json['datadogSite'] as String?,
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        parameterOverrides: json['parameterOverrides'] as Map<String, Object?>?,
        readReplicas: (json['readReplicas'] as List<Object?>?)?.map((e) => ReadReplicaInput.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String? name;
  final PostgresPatchinputPlan? plan;
  /// The number of gigabytes of disk space to allocate for the database
  final int? diskSizeGb;
  final bool? enableDiskAutoscaling;
  /// What connection pool to use (if any) out of 'pgbouncer' and 'none'
  final String? connectionPool;
  final bool? enableHighAvailability;
  /// The Datadog API key for the Datadog agent to monitor the database. Pass empty string to remove. Restarts Postgres on change.
  final String? datadogApikey;
  /// Datadog region to use for monitoring the new database. Defaults to 'US1'.
  final String? datadogSite;
  final List<CidrBlockAndDescription>? ipAllowList;
  final Map<String, Object?>? parameterOverrides;
  final List<ReadReplicaInput>? readReplicas;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
        if (plan != null) 'plan': plan!.wireValue,
        if (diskSizeGb != null) 'diskSizeGB': diskSizeGb,
        if (enableDiskAutoscaling != null) 'enableDiskAutoscaling': enableDiskAutoscaling,
        if (connectionPool != null) 'connectionPool': connectionPool,
        if (enableHighAvailability != null) 'enableHighAvailability': enableHighAvailability,
        if (datadogApikey != null) 'datadogAPIKey': datadogApikey,
        if (datadogSite != null) 'datadogSite': datadogSite,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (parameterOverrides != null) 'parameterOverrides': parameterOverrides,
        if (readReplicas != null) 'readReplicas': readReplicas!.map((e) => e.toJson()).toList(),
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum PostgresPostinputPlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  basic256mb('basic_256mb'),
  basic1gb('basic_1gb'),
  basic4gb('basic_4gb'),
  pro4gb('pro_4gb'),
  pro8gb('pro_8gb'),
  pro16gb('pro_16gb'),
  pro32gb('pro_32gb'),
  pro64gb('pro_64gb'),
  pro128gb('pro_128gb'),
  pro192gb('pro_192gb'),
  pro256gb('pro_256gb'),
  pro384gb('pro_384gb'),
  pro512gb('pro_512gb'),
  accelerated16gb('accelerated_16gb'),
  accelerated32gb('accelerated_32gb'),
  accelerated64gb('accelerated_64gb'),
  accelerated128gb('accelerated_128gb'),
  accelerated256gb('accelerated_256gb'),
  accelerated384gb('accelerated_384gb'),
  accelerated512gb('accelerated_512gb'),
  accelerated768gb('accelerated_768gb'),
  accelerated1024gb('accelerated_1024gb'),
  /// A value this package does not know about.
  unknown('');

  const PostgresPostinputPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static PostgresPostinputPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Input for creating a database
class PostgresPostinput {
  const PostgresPostinput({
    this.databaseName,
    this.databaseUser,
    this.datadogApikey,
    this.datadogSite,
    required this.name,
    this.enableHighAvailability,
    this.environmentId,
    required this.ownerId,
    required this.plan,
    this.diskSizeGb,
    this.enableDiskAutoscaling,
    this.connectionPool,
    this.region,
    this.ipAllowList,
    this.parameterOverrides,
    this.readReplicas,
    required this.version,
  });

  factory PostgresPostinput.fromJson(Map<String, Object?> json) => PostgresPostinput(
        databaseName: json['databaseName'] as String?,
        databaseUser: json['databaseUser'] as String?,
        datadogApikey: json['datadogAPIKey'] as String?,
        datadogSite: json['datadogSite'] as String?,
        name: json['name'] as String? ?? '',
        enableHighAvailability: json['enableHighAvailability'] as bool?,
        environmentId: json['environmentId'] as String?,
        ownerId: json['ownerId'] as String? ?? '',
        plan: PostgresPostinputPlan.fromWire(json['plan']),
        diskSizeGb: (json['diskSizeGB'] as num?)?.toInt(),
        enableDiskAutoscaling: json['enableDiskAutoscaling'] as bool?,
        connectionPool: json['connectionPool'] as String?,
        region: Region.fromWire(json['region']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        parameterOverrides: json['parameterOverrides'] as Map<String, Object?>?,
        readReplicas: (json['readReplicas'] as List<Object?>?)?.map((e) => ReadReplicaInput.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        version: PostgresVersion.fromWire(json['version']),
      );

  final String? databaseName;
  final String? databaseUser;
  /// The Datadog API key for the Datadog agent to monitor the new database.
  final String? datadogApikey;
  /// Datadog region to use for monitoring the new database. Defaults to 'US1'.
  final String? datadogSite;
  /// The name of the database as it will appear in the Render Dashboard
  final String name;
  final bool? enableHighAvailability;
  final String? environmentId;
  /// The ID of the workspace to create the database for
  final String ownerId;
  final PostgresPostinputPlan plan;
  /// The number of gigabytes of disk space to allocate for the database
  final int? diskSizeGb;
  final bool? enableDiskAutoscaling;
  /// What connection pool to use (if any) out of 'pgbouncer' and 'none'
  final String? connectionPool;
  /// Defaults to "oregon"
  final Region? region;
  final List<CidrBlockAndDescription>? ipAllowList;
  final Map<String, Object?>? parameterOverrides;
  final List<ReadReplicaInput>? readReplicas;
  /// The PostgreSQL version
  final PostgresVersion version;

  Map<String, Object?> toJson() => {
        if (databaseName != null) 'databaseName': databaseName,
        if (databaseUser != null) 'databaseUser': databaseUser,
        if (datadogApikey != null) 'datadogAPIKey': datadogApikey,
        if (datadogSite != null) 'datadogSite': datadogSite,
        'name': name,
        if (enableHighAvailability != null) 'enableHighAvailability': enableHighAvailability,
        if (environmentId != null) 'environmentId': environmentId,
        'ownerId': ownerId,
        'plan': plan.wireValue,
        if (diskSizeGb != null) 'diskSizeGB': diskSizeGb,
        if (enableDiskAutoscaling != null) 'enableDiskAutoscaling': enableDiskAutoscaling,
        if (connectionPool != null) 'connectionPool': connectionPool,
        if (region != null) 'region': region!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (parameterOverrides != null) 'parameterOverrides': parameterOverrides,
        if (readReplicas != null) 'readReplicas': readReplicas!.map((e) => e.toJson()).toList(),
        'version': version.wireValue,
      };
}


class PostgresParameterOverrides {
  const PostgresParameterOverrides(this.json);

  factory PostgresParameterOverrides.fromJson(Map<String, Object?> json) =>
      PostgresParameterOverrides(json);

  /// The spec declares no fixed properties for this type, so
  /// the payload is preserved verbatim.
  final Map<String, Object?> json;

  Map<String, Object?> toJson() => json;
}



class PostgresWithCursor {
  const PostgresWithCursor({
    required this.postgres,
    required this.cursor,
  });

  factory PostgresWithCursor.fromJson(Map<String, Object?> json) => PostgresWithCursor(
        postgres: Postgres.fromJson((json['postgres'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final Postgres postgres;
  final String cursor;

  Map<String, Object?> toJson() => {
        'postgres': postgres.toJson(),
        'cursor': cursor,
      };
}


class PreviewInput {
  const PreviewInput({
    required this.imagePath,
    this.name,
    this.plan,
  });

  factory PreviewInput.fromJson(Map<String, Object?> json) => PreviewInput(
        imagePath: json['imagePath'] as String? ?? '',
        name: json['name'] as String?,
        plan: Plan.fromWire(json['plan']),
      );

  /// Must be either a full URL or the relative path to an image. If a relative path, Render uses the base service's image URL as its root. For example, if the base service's image URL is `docker.io/library/nginx:latest`, then valid values are: `docker.io/library/nginx:<any tag or SHA>`, `library/nginx:<any tag or SHA>`, or `nginx:<any tag or SHA>`. Note that the path must match (only the tag or SHA can vary).
  final String imagePath;
  /// A name for the service preview instance. If not specified, Render generates the name using the base service's name and the specified tag or SHA.
  final String? name;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan? plan;

  Map<String, Object?> toJson() => {
        'imagePath': imagePath,
        if (name != null) 'name': name,
        if (plan != null) 'plan': plan!.wireValue,
      };
}



class PrivateServiceDetailsAutoscalingCriteriaCpu {
  const PrivateServiceDetailsAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory PrivateServiceDetailsAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => PrivateServiceDetailsAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class PrivateServiceDetailsAutoscalingCriteriaMemory {
  const PrivateServiceDetailsAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory PrivateServiceDetailsAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => PrivateServiceDetailsAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class PrivateServiceDetailsAutoscalingCriteria {
  const PrivateServiceDetailsAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory PrivateServiceDetailsAutoscalingCriteria.fromJson(Map<String, Object?> json) => PrivateServiceDetailsAutoscalingCriteria(
        cpu: PrivateServiceDetailsAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: PrivateServiceDetailsAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final PrivateServiceDetailsAutoscalingCriteriaCpu cpu;
  final PrivateServiceDetailsAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class PrivateServiceDetailsAutoscaling {
  const PrivateServiceDetailsAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory PrivateServiceDetailsAutoscaling.fromJson(Map<String, Object?> json) => PrivateServiceDetailsAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: PrivateServiceDetailsAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final PrivateServiceDetailsAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class PrivateServiceDetailsDisk {
  const PrivateServiceDetailsDisk({
    required this.id,
    required this.name,
    required this.sizeGb,
    required this.mountPath,
  });

  factory PrivateServiceDetailsDisk.fromJson(Map<String, Object?> json) => PrivateServiceDetailsDisk(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        sizeGb: (json['sizeGB'] as num?)?.toInt() ?? 0,
        mountPath: json['mountPath'] as String? ?? '',
      );

  final String id;
  final String name;
  final int sizeGb;
  final String mountPath;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'sizeGB': sizeGb,
        'mountPath': mountPath,
      };
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServerPortProtocol {
  tcp('TCP'),
  udp('UDP'),
  /// A value this package does not know about.
  unknown('');

  const ServerPortProtocol(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServerPortProtocol fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class ServerPort {
  const ServerPort({
    required this.port,
    required this.protocol,
  });

  factory ServerPort.fromJson(Map<String, Object?> json) => ServerPort(
        port: (json['port'] as num?)?.toInt() ?? 0,
        protocol: ServerPortProtocol.fromWire(json['protocol']),
      );

  final int port;
  final ServerPortProtocol protocol;

  Map<String, Object?> toJson() => {
        'port': port,
        'protocol': protocol.wireValue,
      };
}

class PrivateServiceDetails {
  const PrivateServiceDetails({
    this.autoscaling,
    this.disk,
    required this.env,
    required this.envSpecificDetails,
    required this.numInstances,
    required this.openPorts,
    this.parentServer,
    required this.plan,
    this.pullRequestPreviewsEnabled,
    this.previews,
    required this.region,
    required this.runtime,
    this.sshAddress,
    required this.url,
    required this.buildPlan,
    this.maxShutdownDelaySeconds,
  });

  factory PrivateServiceDetails.fromJson(Map<String, Object?> json) => PrivateServiceDetails(
        autoscaling: json['autoscaling'] == null ? null : PrivateServiceDetailsAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : PrivateServiceDetailsDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        envSpecificDetails: json['envSpecificDetails'],
        numInstances: (json['numInstances'] as num?)?.toInt() ?? 0,
        openPorts: ((json['openPorts'] as List<Object?>?) ?? const []).map((e) => ServerPort.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        parentServer: json['parentServer'] == null ? null : Resource.fromJson(json['parentServer']! as Map<String, Object?>),
        plan: Plan.fromWire(json['plan']),
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        sshAddress: json['sshAddress'] as String?,
        url: json['url'] as String? ?? '',
        buildPlan: BuildPlan.fromWire(json['buildPlan']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final PrivateServiceDetailsAutoscaling? autoscaling;
  final PrivateServiceDetailsDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv env;
  final Object? envSpecificDetails;
  /// For a *manually* scaled service, this is the number of instances the service is scaled to. DOES NOT indicate the number of running instances for an *autoscaled* service.
  final int numInstances;
  final List<ServerPort> openPorts;
  final Resource? parentServer;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan plan;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region region;
  /// Runtime
  final ServiceRuntime runtime;
  /// The SSH address for the service. Only present for services that have SSH enabled.
  final String? sshAddress;
  final String url;
  final BuildPlan buildPlan;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        'env': env.wireValue,
        'envSpecificDetails': envSpecificDetails,
        'numInstances': numInstances,
        'openPorts': openPorts.map((e) => e.toJson()).toList(),
        if (parentServer != null) 'parentServer': parentServer!.toJson(),
        'plan': plan.wireValue,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        'region': region.wireValue,
        'runtime': runtime.wireValue,
        if (sshAddress != null) 'sshAddress': sshAddress,
        'url': url,
        'buildPlan': buildPlan.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


class PrivateServiceDetailsPatch {
  const PrivateServiceDetailsPatch({
    this.envSpecificDetails,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.runtime,
    this.maxShutdownDelaySeconds,
  });

  factory PrivateServiceDetailsPatch.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPatch(
        envSpecificDetails: json['envSpecificDetails'],
        plan: PaidPlan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final Object? envSpecificDetails;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Runtime
  final ServiceRuntime? runtime;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (runtime != null) 'runtime': runtime!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


class PrivateServiceDetailsPostAutoscalingCriteriaCpu {
  const PrivateServiceDetailsPostAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory PrivateServiceDetailsPostAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPostAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class PrivateServiceDetailsPostAutoscalingCriteriaMemory {
  const PrivateServiceDetailsPostAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory PrivateServiceDetailsPostAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPostAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class PrivateServiceDetailsPostAutoscalingCriteria {
  const PrivateServiceDetailsPostAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory PrivateServiceDetailsPostAutoscalingCriteria.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPostAutoscalingCriteria(
        cpu: PrivateServiceDetailsPostAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: PrivateServiceDetailsPostAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final PrivateServiceDetailsPostAutoscalingCriteriaCpu cpu;
  final PrivateServiceDetailsPostAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class PrivateServiceDetailsPostAutoscaling {
  const PrivateServiceDetailsPostAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory PrivateServiceDetailsPostAutoscaling.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPostAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: PrivateServiceDetailsPostAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final PrivateServiceDetailsPostAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class PrivateServiceDetailsPost {
  const PrivateServiceDetailsPost({
    this.autoscaling,
    this.disk,
    this.env,
    required this.runtime,
    this.envSpecificDetails,
    this.numInstances,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.region,
    this.maxShutdownDelaySeconds,
  });

  factory PrivateServiceDetailsPost.fromJson(Map<String, Object?> json) => PrivateServiceDetailsPost(
        autoscaling: json['autoscaling'] == null ? null : PrivateServiceDetailsPostAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : ServiceDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        envSpecificDetails: json['envSpecificDetails'],
        numInstances: (json['numInstances'] as num?)?.toInt(),
        plan: PaidPlan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
      );

  final PrivateServiceDetailsPostAutoscaling? autoscaling;
  final ServiceDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv? env;
  /// Runtime
  final ServiceRuntime runtime;
  final Object? envSpecificDetails;
  /// Defaults to 1
  final int? numInstances;
  /// Defaults to `starter` when creating a new database.
  final PaidPlan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region? region;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        if (env != null) 'env': env!.wireValue,
        'runtime': runtime.wireValue,
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (numInstances != null) 'numInstances': numInstances,
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (region != null) 'region': region!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
      };
}


/// A project is a collection of environments
class Project {
  const Project({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.owner,
    required this.environmentIds,
  });

  factory Project.fromJson(Map<String, Object?> json) => Project(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        environmentIds: ((json['environmentIds'] as List<Object?>?) ?? const []).map((e) => e as String? ?? '').toList(),
      );

  /// The ID of the project
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  /// The name of the project
  final String name;
  final Owner owner;
  /// The environments associated with the project
  final List<String> environmentIds;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'name': name,
        'owner': owner.toJson(),
        'environmentIds': environmentIds.map((e) => e).toList(),
      };
}


/// Input type for updating a project
class ProjectPatchinput {
  const ProjectPatchinput({
    this.name,
  });

  factory ProjectPatchinput.fromJson(Map<String, Object?> json) => ProjectPatchinput(
        name: json['name'] as String?,
      );

  final String? name;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
      };
}


class ProjectPostenvironmentInput {
  const ProjectPostenvironmentInput({
    required this.name,
    this.protectedStatus,
    this.networkIsolationEnabled,
    this.ipAllowList,
  });

  factory ProjectPostenvironmentInput.fromJson(Map<String, Object?> json) => ProjectPostenvironmentInput(
        name: json['name'] as String? ?? '',
        protectedStatus: ProtectedStatus.fromWire(json['protectedStatus']),
        networkIsolationEnabled: json['networkIsolationEnabled'] as bool?,
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String name;
  /// Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments.
  final ProtectedStatus? protectedStatus;
  /// Indicates whether network connections across environments are allowed.
  final bool? networkIsolationEnabled;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        'name': name,
        if (protectedStatus != null) 'protectedStatus': protectedStatus!.wireValue,
        if (networkIsolationEnabled != null) 'networkIsolationEnabled': networkIsolationEnabled,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


class ProjectPostinput {
  const ProjectPostinput({
    required this.name,
    required this.ownerId,
    required this.environments,
  });

  factory ProjectPostinput.fromJson(Map<String, Object?> json) => ProjectPostinput(
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        environments: ((json['environments'] as List<Object?>?) ?? const []).map((e) => ProjectPostenvironmentInput.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  /// The name of the project
  final String name;
  /// The ID of the owner that the project belongs to
  final String ownerId;
  /// The environments to create when creating the project
  final List<ProjectPostenvironmentInput> environments;

  Map<String, Object?> toJson() => {
        'name': name,
        'ownerId': ownerId,
        'environments': environments.map((e) => e.toJson()).toList(),
      };
}


class ProjectWithCursor {
  const ProjectWithCursor({
    required this.project,
    required this.cursor,
  });

  factory ProjectWithCursor.fromJson(Map<String, Object?> json) => ProjectWithCursor(
        project: Project.fromJson((json['project'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  /// A project is a collection of environments
  final Project project;
  final String cursor;

  Map<String, Object?> toJson() => {
        'project': project.toJson(),
        'cursor': cursor,
      };
}








/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum RedisPlan {
  free('free'),
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  custom('custom'),
  /// A value this package does not know about.
  unknown('');

  const RedisPlan(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static RedisPlan fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Options for a Redis instance
class RedisOptions {
  const RedisOptions({
    this.maxmemoryPolicy,
    this.persistenceMode,
  });

  factory RedisOptions.fromJson(Map<String, Object?> json) => RedisOptions(
        maxmemoryPolicy: json['maxmemoryPolicy'] as String?,
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
      );

  final String? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;

  Map<String, Object?> toJson() => {
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
      };
}

/// A Redis instance
class Redis {
  const Redis({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.region,
    required this.plan,
    required this.name,
    required this.owner,
    required this.options,
    required this.ipAllowList,
    this.environmentId,
    required this.version,
    required this.dashboardUrl,
  });

  factory Redis.fromJson(Map<String, Object?> json) => Redis(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        status: DatabaseStatus.fromWire(json['status']),
        region: Region.fromWire(json['region']),
        plan: RedisPlan.fromWire(json['plan']),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        options: RedisOptions.fromJson((json['options'] as Map<String, Object?>?) ?? const {}),
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
        version: json['version'] as String? ?? '',
        dashboardUrl: json['dashboardUrl'] as String? ?? '',
      );

  /// The ID of the Redis instance
  final String id;
  /// The creation time of the Redis instance
  final DateTime createdAt;
  /// The last updated time of the Redis instance
  final DateTime updatedAt;
  final DatabaseStatus status;
  /// Defaults to "oregon"
  final Region region;
  final RedisPlan plan;
  /// The name of the Redis instance
  final String name;
  final Owner owner;
  /// Options for a Redis instance
  final RedisOptions options;
  /// The IP allow list for the Redis instance
  final List<CidrBlockAndDescription> ipAllowList;
  /// The ID of the environment the Redis instance is associated with
  final String? environmentId;
  /// The version of Redis
  final String version;
  /// The URL to view the Redis instance in the Render Dashboard
  final String dashboardUrl;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'status': status.wireValue,
        'region': region.wireValue,
        'plan': plan.wireValue,
        'name': name,
        'owner': owner.toJson(),
        'options': options.toJson(),
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
        'version': version,
        'dashboardUrl': dashboardUrl,
      };
}


/// A Redis instance
class RedisConnectionInfo {
  const RedisConnectionInfo({
    required this.internalConnectionString,
    required this.externalConnectionString,
    required this.redisClicommand,
  });

  factory RedisConnectionInfo.fromJson(Map<String, Object?> json) => RedisConnectionInfo(
        internalConnectionString: json['internalConnectionString'] as String? ?? '',
        externalConnectionString: json['externalConnectionString'] as String? ?? '',
        redisClicommand: json['redisCLICommand'] as String? ?? '',
      );

  /// The connection string to use from within Render
  final String internalConnectionString;
  /// The connection string to use from outside Render
  final String externalConnectionString;
  /// The Redis CLI command to connect to the Redis instance
  final String redisClicommand;

  Map<String, Object?> toJson() => {
        'internalConnectionString': internalConnectionString,
        'externalConnectionString': externalConnectionString,
        'redisCLICommand': redisClicommand,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum RedisDetailMaintenanceState {
  scheduled('scheduled'),
  inProgress('in_progress'),
  userFixRequired('user_fix_required'),
  cancelled('cancelled'),
  succeeded('succeeded'),
  failed('failed'),
  /// A value this package does not know about.
  unknown('');

  const RedisDetailMaintenanceState(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static RedisDetailMaintenanceState fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class RedisDetailMaintenance {
  const RedisDetailMaintenance({
    required this.id,
    required this.type,
    required this.scheduledAt,
    this.pendingMaintenanceBy,
    required this.state,
  });

  factory RedisDetailMaintenance.fromJson(Map<String, Object?> json) => RedisDetailMaintenance(
        id: json['id'] as String? ?? '',
        type: json['type'] as String? ?? '',
        scheduledAt: parseDate(json['scheduledAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        pendingMaintenanceBy: parseDate(json['pendingMaintenanceBy']),
        state: RedisDetailMaintenanceState.fromWire(json['state']),
      );

  final String id;
  final String type;
  final DateTime scheduledAt;
  /// If present, the maintenance run cannot be scheduled for later than this date-time.
  final DateTime? pendingMaintenanceBy;
  final RedisDetailMaintenanceState state;

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type,
        'scheduledAt': scheduledAt.toIso8601String(),
        if (pendingMaintenanceBy != null) 'pendingMaintenanceBy': pendingMaintenanceBy!.toIso8601String(),
        'state': state.wireValue,
      };
}

/// A Redis instance
class RedisDetail {
  const RedisDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.region,
    required this.plan,
    required this.name,
    required this.owner,
    required this.options,
    required this.ipAllowList,
    this.environmentId,
    required this.version,
    this.maintenance,
  });

  factory RedisDetail.fromJson(Map<String, Object?> json) => RedisDetail(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        status: DatabaseStatus.fromWire(json['status']),
        region: Region.fromWire(json['region']),
        plan: RedisPlan.fromWire(json['plan']),
        name: json['name'] as String? ?? '',
        owner: Owner.fromJson((json['owner'] as Map<String, Object?>?) ?? const {}),
        options: RedisOptions.fromJson((json['options'] as Map<String, Object?>?) ?? const {}),
        ipAllowList: ((json['ipAllowList'] as List<Object?>?) ?? const []).map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
        version: json['version'] as String? ?? '',
        maintenance: json['maintenance'] == null ? null : RedisDetailMaintenance.fromJson(json['maintenance']! as Map<String, Object?>),
      );

  /// The ID of the Redis instance
  final String id;
  /// The creation time of the Redis instance
  final DateTime createdAt;
  /// The last updated time of the Redis instance
  final DateTime updatedAt;
  final DatabaseStatus status;
  /// Defaults to "oregon"
  final Region region;
  final RedisPlan plan;
  /// The name of the Redis instance
  final String name;
  final Owner owner;
  /// Options for a Redis instance
  final RedisOptions options;
  /// The IP allow list for the Redis instance
  final List<CidrBlockAndDescription> ipAllowList;
  /// The ID of the environment the Redis instance is associated with
  final String? environmentId;
  /// The version of Redis
  final String version;
  final RedisDetailMaintenance? maintenance;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'status': status.wireValue,
        'region': region.wireValue,
        'plan': plan.wireValue,
        'name': name,
        'owner': owner.toJson(),
        'options': options.toJson(),
        'ipAllowList': ipAllowList.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
        'version': version,
        if (maintenance != null) 'maintenance': maintenance!.toJson(),
      };
}



/// Input type for updating a Redis instance
class RedisPatchinput {
  const RedisPatchinput({
    this.name,
    this.plan,
    this.maxmemoryPolicy,
    this.persistenceMode,
    this.ipAllowList,
  });

  factory RedisPatchinput.fromJson(Map<String, Object?> json) => RedisPatchinput(
        name: json['name'] as String?,
        plan: RedisPlan.fromWire(json['plan']),
        maxmemoryPolicy: MaxmemoryPolicy.fromWire(json['maxmemoryPolicy']),
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  /// The name of the Redis instance
  final String? name;
  final RedisPlan? plan;
  /// The eviction policy for the Key Value instance
  final MaxmemoryPolicy? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (name != null) 'name': name,
        if (plan != null) 'plan': plan!.wireValue,
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy!.wireValue,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


/// Input type for creating a Redis instance
class RedisPostinput {
  const RedisPostinput({
    required this.name,
    required this.ownerId,
    required this.plan,
    this.region,
    this.environmentId,
    this.maxmemoryPolicy,
    this.persistenceMode,
    this.ipAllowList,
  });

  factory RedisPostinput.fromJson(Map<String, Object?> json) => RedisPostinput(
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        plan: RedisPlan.fromWire(json['plan']),
        region: Region.fromWire(json['region']),
        environmentId: json['environmentId'] as String?,
        maxmemoryPolicy: MaxmemoryPolicy.fromWire(json['maxmemoryPolicy']),
        persistenceMode: PersistenceMode.fromWire(json['persistenceMode']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  /// The name of the Redis instance
  final String name;
  /// The ID of the owner of the Redis instance
  final String ownerId;
  final RedisPlan plan;
  /// Defaults to "oregon"
  final Region? region;
  final String? environmentId;
  /// The eviction policy for the Key Value instance
  final MaxmemoryPolicy? maxmemoryPolicy;
  /// The persistence mode for the Key Value instance. The default for paid instances is journal_snapshot (both journaling and snapshots). Only turn off persistence if you're using this Key Value instance as a cache and are okay with losing data. Free instances do not have persistence.
  final PersistenceMode? persistenceMode;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        'name': name,
        'ownerId': ownerId,
        'plan': plan.wireValue,
        if (region != null) 'region': region!.wireValue,
        if (environmentId != null) 'environmentId': environmentId,
        if (maxmemoryPolicy != null) 'maxmemoryPolicy': maxmemoryPolicy!.wireValue,
        if (persistenceMode != null) 'persistenceMode': persistenceMode!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}



class RedisWithCursor {
  const RedisWithCursor({
    required this.redis,
    required this.cursor,
  });

  factory RedisWithCursor.fromJson(Map<String, Object?> json) => RedisWithCursor(
        redis: Redis.fromJson((json['redis'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  /// A Redis instance
  final Redis redis;
  final String cursor;

  Map<String, Object?> toJson() => {
        'redis': redis.toJson(),
        'cursor': cursor,
      };
}





class RegistryCredentialSummary {
  const RegistryCredentialSummary({
    required this.id,
    required this.name,
  });

  factory RegistryCredentialSummary.fromJson(Map<String, Object?> json) => RegistryCredentialSummary(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );

  final String id;
  final String name;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}


/// Controls whether render.com subdomains are available for the service
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum RenderSubdomainPolicy {
  enabled('enabled'),
  disabled('disabled'),
  /// A value this package does not know about.
  unknown('');

  const RenderSubdomainPolicy(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static RenderSubdomainPolicy fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum RouteType {
  redirect('redirect'),
  rewrite('rewrite'),
  /// A value this package does not know about.
  unknown('');

  const RouteType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static RouteType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Route {
  const Route({
    required this.id,
    required this.type,
    required this.source,
    required this.destination,
    required this.priority,
  });

  factory Route.fromJson(Map<String, Object?> json) => Route(
        id: json['id'] as String? ?? '',
        type: RouteType.fromWire(json['type']),
        source: json['source'] as String? ?? '',
        destination: json['destination'] as String? ?? '',
        priority: (json['priority'] as num?)?.toInt() ?? 0,
      );

  final String id;
  final RouteType type;
  final String source;
  final String destination;
  /// Redirect and Rewrite Rules are applied in priority order starting at 0
  final int priority;

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type.wireValue,
        'source': source,
        'destination': destination,
        'priority': priority,
      };
}


class RoutePatch {
  const RoutePatch({
    required this.priority,
  });

  factory RoutePatch.fromJson(Map<String, Object?> json) => RoutePatch(
        priority: (json['priority'] as num?)?.toInt() ?? 0,
      );

  /// Redirect and Rewrite Rules are applied in priority order starting at 0. Moves this route to the specified priority and adjusts other route priorities accordingly.
  final int priority;

  Map<String, Object?> toJson() => {
        'priority': priority,
      };
}


class RoutePost {
  const RoutePost({
    required this.type,
    required this.source,
    required this.destination,
    this.priority,
  });

  factory RoutePost.fromJson(Map<String, Object?> json) => RoutePost(
        type: RouteType.fromWire(json['type']),
        source: json['source'] as String? ?? '',
        destination: json['destination'] as String? ?? '',
        priority: (json['priority'] as num?)?.toInt(),
      );

  final RouteType type;
  final String source;
  final String destination;
  /// Redirect and Rewrite Rules are applied in priority order starting at 0. Defaults to last in the priority list.
  final int? priority;

  Map<String, Object?> toJson() => {
        'type': type.wireValue,
        'source': source,
        'destination': destination,
        if (priority != null) 'priority': priority,
      };
}


class RoutePut {
  const RoutePut({
    required this.type,
    required this.source,
    required this.destination,
  });

  factory RoutePut.fromJson(Map<String, Object?> json) => RoutePut(
        type: RouteType.fromWire(json['type']),
        source: json['source'] as String? ?? '',
        destination: json['destination'] as String? ?? '',
      );

  final RouteType type;
  final String source;
  final String destination;

  Map<String, Object?> toJson() => {
        'type': type.wireValue,
        'source': source,
        'destination': destination,
      };
}



class RouteWithCursor {
  const RouteWithCursor({
    required this.route,
    required this.cursor,
  });

  factory RouteWithCursor.fromJson(Map<String, Object?> json) => RouteWithCursor(
        route: Route.fromJson((json['route'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final Route route;
  final String cursor;

  Map<String, Object?> toJson() => {
        'route': route.toJson(),
        'cursor': cursor,
      };
}


class SecretFile {
  const SecretFile({
    required this.name,
    required this.content,
  });

  factory SecretFile.fromJson(Map<String, Object?> json) => SecretFile(
        name: json['name'] as String? ?? '',
        content: json['content'] as String? ?? '',
      );

  final String name;
  final String content;

  Map<String, Object?> toJson() => {
        'name': name,
        'content': content,
      };
}


class SecretFileWithCursor {
  const SecretFileWithCursor({
    required this.secretFile,
    required this.cursor,
  });

  factory SecretFileWithCursor.fromJson(Map<String, Object?> json) => SecretFileWithCursor(
        secretFile: SecretFile.fromJson((json['secretFile'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final SecretFile secretFile;
  final String cursor;

  Map<String, Object?> toJson() => {
        'secretFile': secretFile.toJson(),
        'cursor': cursor,
      };
}



/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceSuspended {
  suspended('suspended'),
  notSuspended('not_suspended'),
  /// A value this package does not know about.
  unknown('');

  const ServiceSuspended(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceSuspended fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceType {
  staticSite('static_site'),
  webService('web_service'),
  privateService('private_service'),
  backgroundWorker('background_worker'),
  cronJob('cron_job'),
  /// A value this package does not know about.
  unknown('');

  const ServiceType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class Service {
  const Service({
    required this.id,
    required this.autoDeploy,
    this.branch,
    this.buildFilter,
    required this.createdAt,
    required this.dashboardUrl,
    this.environmentId,
    this.imagePath,
    required this.name,
    required this.notifyOnFail,
    required this.ownerId,
    this.registryCredential,
    this.repo,
    required this.rootDir,
    required this.slug,
    required this.suspended,
    required this.suspenders,
    required this.type,
    required this.updatedAt,
    required this.serviceDetails,
  });

  factory Service.fromJson(Map<String, Object?> json) => Service(
        id: json['id'] as String? ?? '',
        autoDeploy: AutoDeploy.fromWire(json['autoDeploy']),
        branch: json['branch'] as String?,
        buildFilter: json['buildFilter'] == null ? null : BuildFilter.fromJson(json['buildFilter']! as Map<String, Object?>),
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        dashboardUrl: json['dashboardUrl'] as String? ?? '',
        environmentId: json['environmentId'] as String?,
        imagePath: json['imagePath'] as String?,
        name: json['name'] as String? ?? '',
        notifyOnFail: NotifySetting.fromWire(json['notifyOnFail']),
        ownerId: json['ownerId'] as String? ?? '',
        registryCredential: json['registryCredential'] == null ? null : RegistryCredentialSummary.fromJson(json['registryCredential']! as Map<String, Object?>),
        repo: json['repo'] as String?,
        rootDir: json['rootDir'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        suspended: ServiceSuspended.fromWire(json['suspended']),
        suspenders: ((json['suspenders'] as List<Object?>?) ?? const []).map((e) => SuspenderType.fromWire(e)).toList(),
        type: ServiceType.fromWire(json['type']),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        serviceDetails: json['serviceDetails'],
      );

  final String id;
  final AutoDeploy autoDeploy;
  final String? branch;
  final BuildFilter? buildFilter;
  final DateTime createdAt;
  /// The URL to view the service in the Render Dashboard
  final String dashboardUrl;
  final String? environmentId;
  final String? imagePath;
  final String name;
  final NotifySetting notifyOnFail;
  final String ownerId;
  final RegistryCredentialSummary? registryCredential;
  final String? repo;
  final String rootDir;
  final String slug;
  final ServiceSuspended suspended;
  final List<SuspenderType> suspenders;
  final ServiceType type;
  final DateTime updatedAt;
  final Object? serviceDetails;

  Map<String, Object?> toJson() => {
        'id': id,
        'autoDeploy': autoDeploy.wireValue,
        if (branch != null) 'branch': branch,
        if (buildFilter != null) 'buildFilter': buildFilter!.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'dashboardUrl': dashboardUrl,
        if (environmentId != null) 'environmentId': environmentId,
        if (imagePath != null) 'imagePath': imagePath,
        'name': name,
        'notifyOnFail': notifyOnFail.wireValue,
        'ownerId': ownerId,
        if (registryCredential != null) 'registryCredential': registryCredential!.toJson(),
        if (repo != null) 'repo': repo,
        'rootDir': rootDir,
        'slug': slug,
        'suspended': suspended.wireValue,
        'suspenders': suspenders.map((e) => e.wireValue).toList(),
        'type': type.wireValue,
        'updatedAt': updatedAt.toIso8601String(),
        'serviceDetails': serviceDetails,
      };
}


class ServiceAndDeploy {
  const ServiceAndDeploy({
    this.service,
    this.deployId,
  });

  factory ServiceAndDeploy.fromJson(Map<String, Object?> json) => ServiceAndDeploy(
        service: json['service'] == null ? null : Service.fromJson(json['service']! as Map<String, Object?>),
        deployId: json['deployId'] as String?,
      );

  final Service? service;
  final String? deployId;

  Map<String, Object?> toJson() => {
        if (service != null) 'service': service!.toJson(),
        if (deployId != null) 'deployId': deployId,
      };
}




/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum ServiceEventWithCursorEventType {
  artifactFetchFailed('artifact_fetch_failed'),
  artifactSourceChanged('artifact_source_changed'),
  autoscalingConfigChanged('autoscaling_config_changed'),
  autoscalingEnded('autoscaling_ended'),
  autoscalingStarted('autoscaling_started'),
  branchDeleted('branch_deleted'),
  buildEnded('build_ended'),
  buildStarted('build_started'),
  commitIgnored('commit_ignored'),
  cronJobRunEnded('cron_job_run_ended'),
  cronJobRunStarted('cron_job_run_started'),
  deployEnded('deploy_ended'),
  deployStarted('deploy_started'),
  diskCreated('disk_created'),
  diskUpdated('disk_updated'),
  diskDeleted('disk_deleted'),
  imagePullFailed('image_pull_failed'),
  initialDeployHookEnded('initial_deploy_hook_ended'),
  initialDeployHookStarted('initial_deploy_hook_started'),
  instanceCountChanged('instance_count_changed'),
  jobRunEnded('job_run_ended'),
  maintenanceModeEnabled('maintenance_mode_enabled'),
  maintenanceModeUriUpdated('maintenance_mode_uri_updated'),
  maintenanceEnded('maintenance_ended'),
  maintenanceStarted('maintenance_started'),
  pipelineMinutesExhausted('pipeline_minutes_exhausted'),
  planChanged('plan_changed'),
  preDeployEnded('pre_deploy_ended'),
  preDeployStarted('pre_deploy_started'),
  serverAvailable('server_available'),
  serverFailed('server_failed'),
  serverHardwareFailure('server_hardware_failure'),
  serverRestarted('server_restarted'),
  serviceResumed('service_resumed'),
  serviceSuspended('service_suspended'),
  suspenderAdded('suspender_added'),
  suspenderRemoved('suspender_removed'),
  zeroDowntimeRedeployEnded('zero_downtime_redeploy_ended'),
  zeroDowntimeRedeployStarted('zero_downtime_redeploy_started'),
  autoDeployDisabled('auto_deploy_disabled'),
  autoDeployEnabled('auto_deploy_enabled'),
  /// A value this package does not know about.
  unknown('');

  const ServiceEventWithCursorEventType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static ServiceEventWithCursorEventType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class ServiceEventWithCursorEvent {
  const ServiceEventWithCursorEvent({
    required this.id,
    required this.timestamp,
    required this.serviceId,
    required this.type,
    required this.details,
  });

  factory ServiceEventWithCursorEvent.fromJson(Map<String, Object?> json) => ServiceEventWithCursorEvent(
        id: json['id'] as String? ?? '',
        timestamp: parseDate(json['timestamp']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        serviceId: json['serviceId'] as String? ?? '',
        type: ServiceEventWithCursorEventType.fromWire(json['type']),
        details: json['details'],
      );

  final String id;
  final DateTime timestamp;
  final String serviceId;
  final ServiceEventWithCursorEventType type;
  final Object? details;

  Map<String, Object?> toJson() => {
        'id': id,
        'timestamp': timestamp.toIso8601String(),
        'serviceId': serviceId,
        'type': type.wireValue,
        'details': details,
      };
}

/// A service event with a cursor
class ServiceEventWithCursor {
  const ServiceEventWithCursor({
    required this.event,
  });

  factory ServiceEventWithCursor.fromJson(Map<String, Object?> json) => ServiceEventWithCursor(
        event: ServiceEventWithCursorEvent.fromJson((json['event'] as Map<String, Object?>?) ?? const {}),
      );

  final ServiceEventWithCursorEvent event;

  Map<String, Object?> toJson() => {
        'event': event.toJson(),
      };
}


class ServiceInstance {
  const ServiceInstance({
    required this.id,
    required this.createdAt,
  });

  factory ServiceInstance.fromJson(Map<String, Object?> json) => ServiceInstance(
        id: json['id'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      );

  final String id;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
      };
}



class ServicePatch {
  const ServicePatch({
    this.autoDeploy,
    this.repo,
    this.branch,
    this.image,
    this.name,
    this.buildFilter,
    this.rootDir,
    this.serviceDetails,
  });

  factory ServicePatch.fromJson(Map<String, Object?> json) => ServicePatch(
        autoDeploy: AutoDeploy.fromWire(json['autoDeploy']),
        repo: json['repo'] as String?,
        branch: json['branch'] as String?,
        image: json['image'] == null ? null : Image.fromJson(json['image']! as Map<String, Object?>),
        name: json['name'] as String?,
        buildFilter: json['buildFilter'] == null ? null : BuildFilter.fromJson(json['buildFilter']! as Map<String, Object?>),
        rootDir: json['rootDir'] as String?,
        serviceDetails: json['serviceDetails'],
      );

  final AutoDeploy? autoDeploy;
  final String? repo;
  final String? branch;
  final Image? image;
  final String? name;
  final BuildFilter? buildFilter;
  final String? rootDir;
  final Object? serviceDetails;

  Map<String, Object?> toJson() => {
        if (autoDeploy != null) 'autoDeploy': autoDeploy!.wireValue,
        if (repo != null) 'repo': repo,
        if (branch != null) 'branch': branch,
        if (image != null) 'image': image!.toJson(),
        if (name != null) 'name': name,
        if (buildFilter != null) 'buildFilter': buildFilter!.toJson(),
        if (rootDir != null) 'rootDir': rootDir,
        if (serviceDetails != null) 'serviceDetails': serviceDetails,
      };
}


class ServicePostSecretFilesItem {
  const ServicePostSecretFilesItem({
    required this.name,
    required this.content,
  });

  factory ServicePostSecretFilesItem.fromJson(Map<String, Object?> json) => ServicePostSecretFilesItem(
        name: json['name'] as String? ?? '',
        content: json['content'] as String? ?? '',
      );

  final String name;
  final String content;

  Map<String, Object?> toJson() => {
        'name': name,
        'content': content,
      };
}

class ServicePost {
  const ServicePost({
    required this.type,
    required this.name,
    required this.ownerId,
    this.repo,
    this.autoDeploy,
    this.branch,
    this.image,
    this.buildFilter,
    this.rootDir,
    this.envVars,
    this.secretFiles,
    this.environmentId,
    this.serviceDetails,
  });

  factory ServicePost.fromJson(Map<String, Object?> json) => ServicePost(
        type: ServiceType.fromWire(json['type']),
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        repo: json['repo'] as String?,
        autoDeploy: AutoDeploy.fromWire(json['autoDeploy']),
        branch: json['branch'] as String?,
        image: json['image'] == null ? null : Image.fromJson(json['image']! as Map<String, Object?>),
        buildFilter: json['buildFilter'] == null ? null : BuildFilter.fromJson(json['buildFilter']! as Map<String, Object?>),
        rootDir: json['rootDir'] as String?,
        envVars: (json['envVars'] as List<Object?>?)?.map((e) => (e as Map<String, Object?>?) ?? const {}).toList(),
        secretFiles: (json['secretFiles'] as List<Object?>?)?.map((e) => ServicePostSecretFilesItem.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        environmentId: json['environmentId'] as String?,
        serviceDetails: json['serviceDetails'],
      );

  final ServiceType type;
  /// The service's name. Must be unique within the workspace.
  final String name;
  /// The ID of the workspace the service belongs to. Obtain your workspace's ID from its Settings page in the Render Dashboard.
  final String ownerId;
  /// The service's repository URL. Do not specify a branch in this string (use the `branch` parameter instead).
  final String? repo;
  final AutoDeploy? autoDeploy;
  /// The repo branch to pull, build, and deploy. If omitted, uses the repository's default branch.
  final String? branch;
  final Image? image;
  final BuildFilter? buildFilter;
  final String? rootDir;
  final List<Map<String, Object?>>? envVars;
  final List<ServicePostSecretFilesItem>? secretFiles;
  /// The ID of the environment the service belongs to, if any. Obtain an environment's ID from its Settings page in the Render Dashboard.
  final String? environmentId;
  final Object? serviceDetails;

  Map<String, Object?> toJson() => {
        'type': type.wireValue,
        'name': name,
        'ownerId': ownerId,
        if (repo != null) 'repo': repo,
        if (autoDeploy != null) 'autoDeploy': autoDeploy!.wireValue,
        if (branch != null) 'branch': branch,
        if (image != null) 'image': image!.toJson(),
        if (buildFilter != null) 'buildFilter': buildFilter!.toJson(),
        if (rootDir != null) 'rootDir': rootDir,
        if (envVars != null) 'envVars': envVars!.map((e) => e).toList(),
        if (secretFiles != null) 'secretFiles': secretFiles!.map((e) => e.toJson()).toList(),
        if (environmentId != null) 'environmentId': environmentId,
        if (serviceDetails != null) 'serviceDetails': serviceDetails,
      };
}





class ServiceWithCursor {
  const ServiceWithCursor({
    required this.service,
    required this.cursor,
  });

  factory ServiceWithCursor.fromJson(Map<String, Object?> json) => ServiceWithCursor(
        service: Service.fromJson((json['service'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final Service service;
  final String cursor;

  Map<String, Object?> toJson() => {
        'service': service.toJson(),
        'cursor': cursor,
      };
}


class SnapshotRestorePost {
  const SnapshotRestorePost({
    required this.snapshotKey,
    this.instanceId,
  });

  factory SnapshotRestorePost.fromJson(Map<String, Object?> json) => SnapshotRestorePost(
        snapshotKey: json['snapshotKey'] as String? ?? '',
        instanceId: json['instanceId'] as String?,
      );

  final String snapshotKey;
  /// When a service with a disk is scaled, the instanceId is used to identify the instance that the disk is attached to. Each instance's disks get their own snapshots, and can be restored separately.
  final String? instanceId;

  Map<String, Object?> toJson() => {
        'snapshotKey': snapshotKey,
        if (instanceId != null) 'instanceId': instanceId,
      };
}



class StaticSiteDetails {
  const StaticSiteDetails({
    required this.buildCommand,
    this.ipAllowList,
    this.parentServer,
    required this.publishPath,
    this.pullRequestPreviewsEnabled,
    this.previews,
    required this.url,
    required this.buildPlan,
    this.renderSubdomainPolicy,
  });

  factory StaticSiteDetails.fromJson(Map<String, Object?> json) => StaticSiteDetails(
        buildCommand: json['buildCommand'] as String? ?? '',
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        parentServer: json['parentServer'] == null ? null : Resource.fromJson(json['parentServer']! as Map<String, Object?>),
        publishPath: json['publishPath'] as String? ?? '',
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        url: json['url'] as String? ?? '',
        buildPlan: BuildPlan.fromWire(json['buildPlan']),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
      );

  final String buildCommand;
  final List<CidrBlockAndDescription>? ipAllowList;
  final Resource? parentServer;
  final String publishPath;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  final String url;
  final BuildPlan buildPlan;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;

  Map<String, Object?> toJson() => {
        'buildCommand': buildCommand,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (parentServer != null) 'parentServer': parentServer!.toJson(),
        'publishPath': publishPath,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        'url': url,
        'buildPlan': buildPlan.wireValue,
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
      };
}


class StaticSiteDetailsPatch {
  const StaticSiteDetailsPatch({
    this.buildCommand,
    this.publishPath,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.renderSubdomainPolicy,
    this.ipAllowList,
  });

  factory StaticSiteDetailsPatch.fromJson(Map<String, Object?> json) => StaticSiteDetailsPatch(
        buildCommand: json['buildCommand'] as String?,
        publishPath: json['publishPath'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String? buildCommand;
  final String? publishPath;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (buildCommand != null) 'buildCommand': buildCommand,
        if (publishPath != null) 'publishPath': publishPath,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


class StaticSiteDetailsPost {
  const StaticSiteDetailsPost({
    this.buildCommand,
    this.headers,
    this.publishPath,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.routes,
    this.renderSubdomainPolicy,
    this.ipAllowList,
  });

  factory StaticSiteDetailsPost.fromJson(Map<String, Object?> json) => StaticSiteDetailsPost(
        buildCommand: json['buildCommand'] as String?,
        headers: (json['headers'] as List<Object?>?)?.map((e) => HeaderInput.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        publishPath: json['publishPath'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        routes: (json['routes'] as List<Object?>?)?.map((e) => RoutePost.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String? buildCommand;
  final List<HeaderInput>? headers;
  /// Defaults to "public"
  final String? publishPath;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  final List<RoutePost>? routes;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (buildCommand != null) 'buildCommand': buildCommand,
        if (headers != null) 'headers': headers!.map((e) => e.toJson()).toList(),
        if (publishPath != null) 'publishPath': publishPath,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (routes != null) 'routes': routes!.map((e) => e.toJson()).toList(),
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}



class SyncWithCursorSyncCommit {
  const SyncWithCursorSyncCommit({
    required this.id,
  });

  factory SyncWithCursorSyncCommit.fromJson(Map<String, Object?> json) => SyncWithCursorSyncCommit(
        id: json['id'] as String? ?? '',
      );

  final String id;

  Map<String, Object?> toJson() => {
        'id': id,
      };
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum SyncWithCursorSyncState {
  created('created'),
  pending('pending'),
  running('running'),
  error('error'),
  success('success'),
  /// A value this package does not know about.
  unknown('');

  const SyncWithCursorSyncState(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static SyncWithCursorSyncState fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class SyncWithCursorSync {
  const SyncWithCursorSync({
    required this.id,
    required this.commit,
    this.startedAt,
    this.completedAt,
    required this.state,
  });

  factory SyncWithCursorSync.fromJson(Map<String, Object?> json) => SyncWithCursorSync(
        id: json['id'] as String? ?? '',
        commit: SyncWithCursorSyncCommit.fromJson((json['commit'] as Map<String, Object?>?) ?? const {}),
        startedAt: parseDate(json['startedAt']),
        completedAt: parseDate(json['completedAt']),
        state: SyncWithCursorSyncState.fromWire(json['state']),
      );

  final String id;
  final SyncWithCursorSyncCommit commit;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final SyncWithCursorSyncState state;

  Map<String, Object?> toJson() => {
        'id': id,
        'commit': commit.toJson(),
        if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
        if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
        'state': state.wireValue,
      };
}

/// A Blueprint sync with a cursor
class SyncWithCursor {
  const SyncWithCursor({
    required this.sync_,
    required this.cursor,
  });

  factory SyncWithCursor.fromJson(Map<String, Object?> json) => SyncWithCursor(
        sync_: SyncWithCursorSync.fromJson((json['sync'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final SyncWithCursorSync sync_;
  final String cursor;

  Map<String, Object?> toJson() => {
        'sync': sync_.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum TaskRunWithCursorTaskRunStatus {
  pending('pending'),
  running('running'),
  completed('completed'),
  succeeded('succeeded'),
  failed('failed'),
  canceled('canceled'),
  paused('paused'),
  /// A value this package does not know about.
  unknown('');

  const TaskRunWithCursorTaskRunStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static TaskRunWithCursorTaskRunStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum TaskRunWithCursorTaskRunAttemptsItemStatus {
  pending('pending'),
  running('running'),
  completed('completed'),
  succeeded('succeeded'),
  failed('failed'),
  canceled('canceled'),
  paused('paused'),
  /// A value this package does not know about.
  unknown('');

  const TaskRunWithCursorTaskRunAttemptsItemStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static TaskRunWithCursorTaskRunAttemptsItemStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class TaskRunWithCursorTaskRunAttemptsItem {
  const TaskRunWithCursorTaskRunAttemptsItem({
    this.taskRunId,
    required this.attempt,
    required this.status,
    this.enqueuedAt,
    required this.startedAt,
    this.completedAt,
  });

  factory TaskRunWithCursorTaskRunAttemptsItem.fromJson(Map<String, Object?> json) => TaskRunWithCursorTaskRunAttemptsItem(
        taskRunId: json['taskRunId'] as String?,
        attempt: (json['attempt'] as num?)?.toInt() ?? 0,
        status: TaskRunWithCursorTaskRunAttemptsItemStatus.fromWire(json['status']),
        enqueuedAt: parseDate(json['enqueuedAt']),
        startedAt: parseDate(json['startedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        completedAt: parseDate(json['completedAt']),
      );

  /// The ID of the task run this attempt belongs to.
  final String? taskRunId;
  /// The 0-indexed attempt number.
  final int attempt;
  final TaskRunWithCursorTaskRunAttemptsItemStatus status;
  final DateTime? enqueuedAt;
  final DateTime startedAt;
  final DateTime? completedAt;

  Map<String, Object?> toJson() => {
        if (taskRunId != null) 'taskRunId': taskRunId,
        'attempt': attempt,
        'status': status.wireValue,
        if (enqueuedAt != null) 'enqueuedAt': enqueuedAt!.toIso8601String(),
        'startedAt': startedAt.toIso8601String(),
        if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
      };
}

class TaskRunWithCursorTaskRun {
  const TaskRunWithCursorTaskRun({
    required this.id,
    required this.taskId,
    required this.status,
    this.startedAt,
    this.completedAt,
    required this.parentTaskRunId,
    this.parentTaskAttempt,
    required this.rootTaskRunId,
    required this.retries,
    required this.attempts,
  });

  factory TaskRunWithCursorTaskRun.fromJson(Map<String, Object?> json) => TaskRunWithCursorTaskRun(
        id: json['id'] as String? ?? '',
        taskId: json['taskId'] as String? ?? '',
        status: TaskRunWithCursorTaskRunStatus.fromWire(json['status']),
        startedAt: parseDate(json['startedAt']),
        completedAt: parseDate(json['completedAt']),
        parentTaskRunId: json['parentTaskRunId'] as String? ?? '',
        parentTaskAttempt: (json['parentTaskAttempt'] as num?)?.toInt(),
        rootTaskRunId: json['rootTaskRunId'] as String? ?? '',
        retries: (json['retries'] as num?)?.toInt() ?? 0,
        attempts: ((json['attempts'] as List<Object?>?) ?? const []).map((e) => TaskRunWithCursorTaskRunAttemptsItem.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final String id;
  final String taskId;
  final TaskRunWithCursorTaskRunStatus status;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String parentTaskRunId;
  /// The 0-indexed attempt of the parent task run that spawned this task run. Omitted for root task runs and for task runs created before this field was introduced.
  final int? parentTaskAttempt;
  final String rootTaskRunId;
  final int retries;
  final List<TaskRunWithCursorTaskRunAttemptsItem> attempts;

  Map<String, Object?> toJson() => {
        'id': id,
        'taskId': taskId,
        'status': status.wireValue,
        if (startedAt != null) 'startedAt': startedAt!.toIso8601String(),
        if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
        'parentTaskRunId': parentTaskRunId,
        if (parentTaskAttempt != null) 'parentTaskAttempt': parentTaskAttempt,
        'rootTaskRunId': rootTaskRunId,
        'retries': retries,
        'attempts': attempts.map((e) => e.toJson()).toList(),
      };
}

class TaskRunWithCursor {
  const TaskRunWithCursor({
    required this.taskRun,
    required this.cursor,
  });

  factory TaskRunWithCursor.fromJson(Map<String, Object?> json) => TaskRunWithCursor(
        taskRun: TaskRunWithCursorTaskRun.fromJson((json['taskRun'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final TaskRunWithCursorTaskRun taskRun;
  final String cursor;

  Map<String, Object?> toJson() => {
        'taskRun': taskRun.toJson(),
        'cursor': cursor,
      };
}


class TaskWithCursorTask {
  const TaskWithCursorTask({
    required this.id,
    required this.name,
    required this.createdAt,
    this.workflowId,
    this.workflowVersionId,
  });

  factory TaskWithCursorTask.fromJson(Map<String, Object?> json) => TaskWithCursorTask(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        workflowId: json['workflowId'] as String?,
        workflowVersionId: json['workflowVersionId'] as String?,
      );

  final String id;
  final String name;
  final DateTime createdAt;
  final String? workflowId;
  final String? workflowVersionId;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        if (workflowId != null) 'workflowId': workflowId,
        if (workflowVersionId != null) 'workflowVersionId': workflowVersionId,
      };
}

class TaskWithCursor {
  const TaskWithCursor({
    required this.task,
    required this.cursor,
  });

  factory TaskWithCursor.fromJson(Map<String, Object?> json) => TaskWithCursor(
        task: TaskWithCursorTask.fromJson((json['task'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final TaskWithCursorTask task;
  final String cursor;

  Map<String, Object?> toJson() => {
        'task': task.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum TeamMemberStatus {
  active('active'),
  inactive('inactive'),
  /// A value this package does not know about.
  unknown('');

  const TeamMemberStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static TeamMemberStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// The member's workspace role. Values are always returned in uppercase.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum TeamMemberRole {
  admin('ADMIN'),
  developer('DEVELOPER'),
  workspaceContributor('WORKSPACE_CONTRIBUTOR'),
  workspaceBilling('WORKSPACE_BILLING'),
  workspaceViewer('WORKSPACE_VIEWER'),
  /// A value this package does not know about.
  unknown('');

  const TeamMemberRole(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static TeamMemberRole fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class TeamMember {
  const TeamMember({
    required this.userId,
    required this.name,
    required this.email,
    required this.status,
    required this.role,
    required this.mfaEnabled,
  });

  factory TeamMember.fromJson(Map<String, Object?> json) => TeamMember(
        userId: json['userId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        status: TeamMemberStatus.fromWire(json['status']),
        role: TeamMemberRole.fromWire(json['role']),
        mfaEnabled: json['mfaEnabled'] as bool? ?? false,
      );

  final String userId;
  final String name;
  final String email;
  final TeamMemberStatus status;
  /// The member's workspace role. Values are always returned in uppercase.
  final TeamMemberRole role;
  final bool mfaEnabled;

  Map<String, Object?> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'status': status.wireValue,
        'role': role.wireValue,
        'mfaEnabled': mfaEnabled,
      };
}




class User {
  const User({
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, Object?> json) => User(
        email: json['email'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );

  final String email;
  final String name;

  Map<String, Object?> toJson() => {
        'email': email,
        'name': name,
      };
}


class WebServiceDetailsAutoscalingCriteriaCpu {
  const WebServiceDetailsAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory WebServiceDetailsAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => WebServiceDetailsAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class WebServiceDetailsAutoscalingCriteriaMemory {
  const WebServiceDetailsAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory WebServiceDetailsAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => WebServiceDetailsAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class WebServiceDetailsAutoscalingCriteria {
  const WebServiceDetailsAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory WebServiceDetailsAutoscalingCriteria.fromJson(Map<String, Object?> json) => WebServiceDetailsAutoscalingCriteria(
        cpu: WebServiceDetailsAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: WebServiceDetailsAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final WebServiceDetailsAutoscalingCriteriaCpu cpu;
  final WebServiceDetailsAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class WebServiceDetailsAutoscaling {
  const WebServiceDetailsAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory WebServiceDetailsAutoscaling.fromJson(Map<String, Object?> json) => WebServiceDetailsAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: WebServiceDetailsAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final WebServiceDetailsAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class WebServiceDetailsDisk {
  const WebServiceDetailsDisk({
    required this.id,
    required this.name,
    required this.sizeGb,
    required this.mountPath,
  });

  factory WebServiceDetailsDisk.fromJson(Map<String, Object?> json) => WebServiceDetailsDisk(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        sizeGb: (json['sizeGB'] as num?)?.toInt() ?? 0,
        mountPath: json['mountPath'] as String? ?? '',
      );

  final String id;
  final String name;
  final int sizeGb;
  final String mountPath;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'sizeGB': sizeGb,
        'mountPath': mountPath,
      };
}

class WebServiceDetails {
  const WebServiceDetails({
    this.autoscaling,
    this.cache,
    this.disk,
    required this.env,
    required this.envSpecificDetails,
    required this.healthCheckPath,
    this.ipAllowList,
    this.maintenanceMode,
    required this.numInstances,
    required this.openPorts,
    this.parentServer,
    required this.plan,
    this.pullRequestPreviewsEnabled,
    this.previews,
    required this.region,
    required this.runtime,
    this.sshAddress,
    required this.url,
    required this.buildPlan,
    this.maxShutdownDelaySeconds,
    this.renderSubdomainPolicy,
  });

  factory WebServiceDetails.fromJson(Map<String, Object?> json) => WebServiceDetails(
        autoscaling: json['autoscaling'] == null ? null : WebServiceDetailsAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        cache: json['cache'] == null ? null : Cache.fromJson(json['cache']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : WebServiceDetailsDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        envSpecificDetails: json['envSpecificDetails'],
        healthCheckPath: json['healthCheckPath'] as String? ?? '',
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        maintenanceMode: json['maintenanceMode'] == null ? null : MaintenanceMode.fromJson(json['maintenanceMode']! as Map<String, Object?>),
        numInstances: (json['numInstances'] as num?)?.toInt() ?? 0,
        openPorts: ((json['openPorts'] as List<Object?>?) ?? const []).map((e) => ServerPort.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        parentServer: json['parentServer'] == null ? null : Resource.fromJson(json['parentServer']! as Map<String, Object?>),
        plan: Plan.fromWire(json['plan']),
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        sshAddress: json['sshAddress'] as String?,
        url: json['url'] as String? ?? '',
        buildPlan: BuildPlan.fromWire(json['buildPlan']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
      );

  final WebServiceDetailsAutoscaling? autoscaling;
  final Cache? cache;
  final WebServiceDetailsDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv env;
  final Object? envSpecificDetails;
  final String healthCheckPath;
  final List<CidrBlockAndDescription>? ipAllowList;
  final MaintenanceMode? maintenanceMode;
  /// For a *manually* scaled service, this is the number of instances the service is scaled to. DOES NOT indicate the number of running instances for an *autoscaled* service.
  final int numInstances;
  final List<ServerPort> openPorts;
  final Resource? parentServer;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan plan;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region region;
  /// Runtime
  final ServiceRuntime runtime;
  /// The SSH address for the service. Only present for services that have SSH enabled.
  final String? sshAddress;
  final String url;
  final BuildPlan buildPlan;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (cache != null) 'cache': cache!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        'env': env.wireValue,
        'envSpecificDetails': envSpecificDetails,
        'healthCheckPath': healthCheckPath,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (maintenanceMode != null) 'maintenanceMode': maintenanceMode!.toJson(),
        'numInstances': numInstances,
        'openPorts': openPorts.map((e) => e.toJson()).toList(),
        if (parentServer != null) 'parentServer': parentServer!.toJson(),
        'plan': plan.wireValue,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        'region': region.wireValue,
        'runtime': runtime.wireValue,
        if (sshAddress != null) 'sshAddress': sshAddress,
        'url': url,
        'buildPlan': buildPlan.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
      };
}


class WebServiceDetailsPatch {
  const WebServiceDetailsPatch({
    this.envSpecificDetails,
    this.healthCheckPath,
    this.maintenanceMode,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.runtime,
    this.maxShutdownDelaySeconds,
    this.renderSubdomainPolicy,
    this.ipAllowList,
    this.cache,
  });

  factory WebServiceDetailsPatch.fromJson(Map<String, Object?> json) => WebServiceDetailsPatch(
        envSpecificDetails: json['envSpecificDetails'],
        healthCheckPath: json['healthCheckPath'] as String?,
        maintenanceMode: json['maintenanceMode'] == null ? null : MaintenanceMode.fromJson(json['maintenanceMode']! as Map<String, Object?>),
        plan: Plan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
        cache: json['cache'] == null ? null : Cache.fromJson(json['cache']! as Map<String, Object?>),
      );

  final Object? envSpecificDetails;
  final String? healthCheckPath;
  final MaintenanceMode? maintenanceMode;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Runtime
  final ServiceRuntime? runtime;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;
  final List<CidrBlockAndDescription>? ipAllowList;
  final Cache? cache;

  Map<String, Object?> toJson() => {
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (healthCheckPath != null) 'healthCheckPath': healthCheckPath,
        if (maintenanceMode != null) 'maintenanceMode': maintenanceMode!.toJson(),
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (runtime != null) 'runtime': runtime!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
        if (cache != null) 'cache': cache!.toJson(),
      };
}


class WebServiceDetailsPostAutoscalingCriteriaCpu {
  const WebServiceDetailsPostAutoscalingCriteriaCpu({
    required this.enabled,
    required this.percentage,
  });

  factory WebServiceDetailsPostAutoscalingCriteriaCpu.fromJson(Map<String, Object?> json) => WebServiceDetailsPostAutoscalingCriteriaCpu(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class WebServiceDetailsPostAutoscalingCriteriaMemory {
  const WebServiceDetailsPostAutoscalingCriteriaMemory({
    required this.enabled,
    required this.percentage,
  });

  factory WebServiceDetailsPostAutoscalingCriteriaMemory.fromJson(Map<String, Object?> json) => WebServiceDetailsPostAutoscalingCriteriaMemory(
        enabled: json['enabled'] as bool? ?? false,
        percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      );

  final bool enabled;
  /// Determines when your service will be scaled. If the average resource utilization is significantly above/below the target, we will increase/decrease the number of instances.
  final int percentage;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'percentage': percentage,
      };
}

class WebServiceDetailsPostAutoscalingCriteria {
  const WebServiceDetailsPostAutoscalingCriteria({
    required this.cpu,
    required this.memory,
  });

  factory WebServiceDetailsPostAutoscalingCriteria.fromJson(Map<String, Object?> json) => WebServiceDetailsPostAutoscalingCriteria(
        cpu: WebServiceDetailsPostAutoscalingCriteriaCpu.fromJson((json['cpu'] as Map<String, Object?>?) ?? const {}),
        memory: WebServiceDetailsPostAutoscalingCriteriaMemory.fromJson((json['memory'] as Map<String, Object?>?) ?? const {}),
      );

  final WebServiceDetailsPostAutoscalingCriteriaCpu cpu;
  final WebServiceDetailsPostAutoscalingCriteriaMemory memory;

  Map<String, Object?> toJson() => {
        'cpu': cpu.toJson(),
        'memory': memory.toJson(),
      };
}

class WebServiceDetailsPostAutoscaling {
  const WebServiceDetailsPostAutoscaling({
    required this.enabled,
    required this.min,
    required this.max,
    required this.criteria,
  });

  factory WebServiceDetailsPostAutoscaling.fromJson(Map<String, Object?> json) => WebServiceDetailsPostAutoscaling(
        enabled: json['enabled'] as bool? ?? false,
        min: (json['min'] as num?)?.toInt() ?? 0,
        max: (json['max'] as num?)?.toInt() ?? 0,
        criteria: WebServiceDetailsPostAutoscalingCriteria.fromJson((json['criteria'] as Map<String, Object?>?) ?? const {}),
      );

  final bool enabled;
  /// The minimum number of instances for the service
  final int min;
  /// The maximum number of instances for the service
  final int max;
  final WebServiceDetailsPostAutoscalingCriteria criteria;

  Map<String, Object?> toJson() => {
        'enabled': enabled,
        'min': min,
        'max': max,
        'criteria': criteria.toJson(),
      };
}

class WebServiceDetailsPost {
  const WebServiceDetailsPost({
    this.autoscaling,
    this.disk,
    this.env,
    required this.runtime,
    this.envSpecificDetails,
    this.healthCheckPath,
    this.maintenanceMode,
    this.numInstances,
    this.plan,
    this.preDeployCommand,
    this.pullRequestPreviewsEnabled,
    this.previews,
    this.region,
    this.maxShutdownDelaySeconds,
    this.renderSubdomainPolicy,
    this.ipAllowList,
  });

  factory WebServiceDetailsPost.fromJson(Map<String, Object?> json) => WebServiceDetailsPost(
        autoscaling: json['autoscaling'] == null ? null : WebServiceDetailsPostAutoscaling.fromJson(json['autoscaling']! as Map<String, Object?>),
        disk: json['disk'] == null ? null : ServiceDisk.fromJson(json['disk']! as Map<String, Object?>),
        env: ServiceEnv.fromWire(json['env']),
        runtime: ServiceRuntime.fromWire(json['runtime']),
        envSpecificDetails: json['envSpecificDetails'],
        healthCheckPath: json['healthCheckPath'] as String?,
        maintenanceMode: json['maintenanceMode'] == null ? null : MaintenanceMode.fromJson(json['maintenanceMode']! as Map<String, Object?>),
        numInstances: (json['numInstances'] as num?)?.toInt(),
        plan: Plan.fromWire(json['plan']),
        preDeployCommand: json['preDeployCommand'] as String?,
        pullRequestPreviewsEnabled: PullRequestPreviewsEnabled.fromWire(json['pullRequestPreviewsEnabled']),
        previews: json['previews'] == null ? null : Previews.fromJson(json['previews']! as Map<String, Object?>),
        region: Region.fromWire(json['region']),
        maxShutdownDelaySeconds: (json['maxShutdownDelaySeconds'] as num?)?.toInt(),
        renderSubdomainPolicy: RenderSubdomainPolicy.fromWire(json['renderSubdomainPolicy']),
        ipAllowList: (json['ipAllowList'] as List<Object?>?)?.map((e) => CidrBlockAndDescription.fromJson((e as Map<String, Object?>?) ?? const {})).toList(),
      );

  final WebServiceDetailsPostAutoscaling? autoscaling;
  final ServiceDisk? disk;
  /// This field has been deprecated, runtime should be used in its place.
  final ServiceEnv? env;
  /// Runtime
  final ServiceRuntime runtime;
  final Object? envSpecificDetails;
  final String? healthCheckPath;
  final MaintenanceMode? maintenanceMode;
  /// Defaults to 1
  final int? numInstances;
  /// The instance type to use. Legacy variants (`*_legacy`) identify grandfathered plans no longer offered for new services. Note that base services on any paid instance type can't create preview instances with the `free` instance type.
  final Plan? plan;
  final String? preDeployCommand;
  /// This field has been deprecated. previews.generation should be used in its place.
  final PullRequestPreviewsEnabled? pullRequestPreviewsEnabled;
  final Previews? previews;
  /// Defaults to "oregon"
  final Region? region;
  /// The maximum amount of time (in seconds) that Render waits for your application process to exit gracefully after sending it a SIGTERM signal.
  final int? maxShutdownDelaySeconds;
  /// Controls whether render.com subdomains are available for the service
  final RenderSubdomainPolicy? renderSubdomainPolicy;
  final List<CidrBlockAndDescription>? ipAllowList;

  Map<String, Object?> toJson() => {
        if (autoscaling != null) 'autoscaling': autoscaling!.toJson(),
        if (disk != null) 'disk': disk!.toJson(),
        if (env != null) 'env': env!.wireValue,
        'runtime': runtime.wireValue,
        if (envSpecificDetails != null) 'envSpecificDetails': envSpecificDetails,
        if (healthCheckPath != null) 'healthCheckPath': healthCheckPath,
        if (maintenanceMode != null) 'maintenanceMode': maintenanceMode!.toJson(),
        if (numInstances != null) 'numInstances': numInstances,
        if (plan != null) 'plan': plan!.wireValue,
        if (preDeployCommand != null) 'preDeployCommand': preDeployCommand,
        if (pullRequestPreviewsEnabled != null) 'pullRequestPreviewsEnabled': pullRequestPreviewsEnabled!.wireValue,
        if (previews != null) 'previews': previews!.toJson(),
        if (region != null) 'region': region!.wireValue,
        if (maxShutdownDelaySeconds != null) 'maxShutdownDelaySeconds': maxShutdownDelaySeconds,
        if (renderSubdomainPolicy != null) 'renderSubdomainPolicy': renderSubdomainPolicy!.wireValue,
        if (ipAllowList != null) 'ipAllowList': ipAllowList!.map((e) => e.toJson()).toList(),
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WebhookEventWithCursorWebhookEventEventType {
  artifactFetchFailed('artifact_fetch_failed'),
  artifactSourceChanged('artifact_source_changed'),
  autoscalingConfigChanged('autoscaling_config_changed'),
  autoscalingEnded('autoscaling_ended'),
  autoscalingStarted('autoscaling_started'),
  branchDeleted('branch_deleted'),
  buildEnded('build_ended'),
  buildStarted('build_started'),
  commitIgnored('commit_ignored'),
  cronJobRunEnded('cron_job_run_ended'),
  cronJobRunStarted('cron_job_run_started'),
  deployEnded('deploy_ended'),
  deployStarted('deploy_started'),
  diskCreated('disk_created'),
  diskUpdated('disk_updated'),
  diskDeleted('disk_deleted'),
  imagePullFailed('image_pull_failed'),
  instanceCountChanged('instance_count_changed'),
  jobRunEnded('job_run_ended'),
  maintenanceModeEnabled('maintenance_mode_enabled'),
  maintenanceModeUriUpdated('maintenance_mode_uri_updated'),
  maintenanceEnded('maintenance_ended'),
  maintenanceStarted('maintenance_started'),
  pipelineMinutesExhausted('pipeline_minutes_exhausted'),
  planChanged('plan_changed'),
  preDeployEnded('pre_deploy_ended'),
  preDeployStarted('pre_deploy_started'),
  serverAvailable('server_available'),
  serverFailed('server_failed'),
  serverHardwareFailure('server_hardware_failure'),
  serverRestarted('server_restarted'),
  serviceResumed('service_resumed'),
  serviceSuspended('service_suspended'),
  zeroDowntimeRedeployEnded('zero_downtime_redeploy_ended'),
  zeroDowntimeRedeployStarted('zero_downtime_redeploy_started'),
  edgeCacheEnabled('edge_cache_enabled'),
  edgeCacheDisabled('edge_cache_disabled'),
  edgeCachePurged('edge_cache_purged'),
  autoDeployDisabled('auto_deploy_disabled'),
  autoDeployEnabled('auto_deploy_enabled'),
  postgresAvailable('postgres_available'),
  postgresBackupCompleted('postgres_backup_completed'),
  postgresBackupFailed('postgres_backup_failed'),
  postgresBackupStarted('postgres_backup_started'),
  postgresClusterLeaderChanged('postgres_cluster_leader_changed'),
  postgresConnectionPoolChanged('postgres_connection_pool_changed'),
  postgresConnectionPoolEnabledChanged('postgres_connection_pool_enabled_changed'),
  postgresCreated('postgres_created'),
  postgresDiskSizeChanged('postgres_disk_size_changed'),
  postgresDiskAutoscalingEnabledChanged('postgres_disk_autoscaling_enabled_changed'),
  postgresHaStatusChanged('postgres_ha_status_changed'),
  postgresRestarted('postgres_restarted'),
  postgresUnavailable('postgres_unavailable'),
  postgresUpgradeFailed('postgres_upgrade_failed'),
  postgresUpgradeStarted('postgres_upgrade_started'),
  postgresUpgradeSucceeded('postgres_upgrade_succeeded'),
  postgresRestoreFailed('postgres_restore_failed'),
  postgresRestoreSucceeded('postgres_restore_succeeded'),
  postgresReadReplicasChanged('postgres_read_replicas_changed'),
  postgresPitrCheckpointStarted('postgres_pitr_checkpoint_started'),
  postgresPitrCheckpointFailed('postgres_pitr_checkpoint_failed'),
  postgresPitrCheckpointCompleted('postgres_pitr_checkpoint_completed'),
  postgresReadReplicaStale('postgres_read_replica_stale'),
  postgresWalArchiveFailed('postgres_wal_archive_failed'),
  keyValueAvailable('key_value_available'),
  keyValueConfigRestart('key_value_config_restart'),
  keyValueUnhealthy('key_value_unhealthy'),
  /// A value this package does not know about.
  unknown('');

  const WebhookEventWithCursorWebhookEventEventType(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WebhookEventWithCursorWebhookEventEventType fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class WebhookEventWithCursorWebhookEvent {
  const WebhookEventWithCursorWebhookEvent({
    required this.id,
    required this.eventId,
    required this.eventType,
    required this.sentAt,
    this.statusCode,
    this.responseBody,
    this.error,
  });

  factory WebhookEventWithCursorWebhookEvent.fromJson(Map<String, Object?> json) => WebhookEventWithCursorWebhookEvent(
        id: json['id'] as String? ?? '',
        eventId: json['eventId'] as String? ?? '',
        eventType: WebhookEventWithCursorWebhookEventEventType.fromWire(json['eventType']),
        sentAt: parseDate(json['sentAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        statusCode: (json['statusCode'] as num?)?.toInt(),
        responseBody: json['responseBody'] as String?,
        error: json['error'] as String?,
      );

  /// the id of the webhook event
  final String id;
  /// the id of the event that triggered the webhook
  final String eventId;
  final WebhookEventWithCursorWebhookEventEventType eventType;
  final DateTime sentAt;
  final int? statusCode;
  final String? responseBody;
  /// error is populated when an error occurs without a response such as a timeout
  final String? error;

  Map<String, Object?> toJson() => {
        'id': id,
        'eventId': eventId,
        'eventType': eventType.wireValue,
        'sentAt': sentAt.toIso8601String(),
        if (statusCode != null) 'statusCode': statusCode,
        if (responseBody != null) 'responseBody': responseBody,
        if (error != null) 'error': error,
      };
}

class WebhookEventWithCursor {
  const WebhookEventWithCursor({
    required this.webhookEvent,
    required this.cursor,
  });

  factory WebhookEventWithCursor.fromJson(Map<String, Object?> json) => WebhookEventWithCursor(
        webhookEvent: WebhookEventWithCursorWebhookEvent.fromJson((json['webhookEvent'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final WebhookEventWithCursorWebhookEvent webhookEvent;
  final String cursor;

  Map<String, Object?> toJson() => {
        'webhookEvent': webhookEvent.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WebhookWithCursorWebhookEventFilterItem {
  artifactFetchFailed('artifact_fetch_failed'),
  artifactSourceChanged('artifact_source_changed'),
  autoscalingConfigChanged('autoscaling_config_changed'),
  autoscalingEnded('autoscaling_ended'),
  autoscalingStarted('autoscaling_started'),
  branchDeleted('branch_deleted'),
  buildEnded('build_ended'),
  buildStarted('build_started'),
  commitIgnored('commit_ignored'),
  cronJobRunEnded('cron_job_run_ended'),
  cronJobRunStarted('cron_job_run_started'),
  deployEnded('deploy_ended'),
  deployStarted('deploy_started'),
  diskCreated('disk_created'),
  diskUpdated('disk_updated'),
  diskDeleted('disk_deleted'),
  imagePullFailed('image_pull_failed'),
  instanceCountChanged('instance_count_changed'),
  jobRunEnded('job_run_ended'),
  maintenanceModeEnabled('maintenance_mode_enabled'),
  maintenanceModeUriUpdated('maintenance_mode_uri_updated'),
  maintenanceEnded('maintenance_ended'),
  maintenanceStarted('maintenance_started'),
  pipelineMinutesExhausted('pipeline_minutes_exhausted'),
  planChanged('plan_changed'),
  preDeployEnded('pre_deploy_ended'),
  preDeployStarted('pre_deploy_started'),
  serverAvailable('server_available'),
  serverFailed('server_failed'),
  serverHardwareFailure('server_hardware_failure'),
  serverRestarted('server_restarted'),
  serviceResumed('service_resumed'),
  serviceSuspended('service_suspended'),
  zeroDowntimeRedeployEnded('zero_downtime_redeploy_ended'),
  zeroDowntimeRedeployStarted('zero_downtime_redeploy_started'),
  edgeCacheEnabled('edge_cache_enabled'),
  edgeCacheDisabled('edge_cache_disabled'),
  edgeCachePurged('edge_cache_purged'),
  autoDeployDisabled('auto_deploy_disabled'),
  autoDeployEnabled('auto_deploy_enabled'),
  postgresAvailable('postgres_available'),
  postgresBackupCompleted('postgres_backup_completed'),
  postgresBackupFailed('postgres_backup_failed'),
  postgresBackupStarted('postgres_backup_started'),
  postgresClusterLeaderChanged('postgres_cluster_leader_changed'),
  postgresConnectionPoolChanged('postgres_connection_pool_changed'),
  postgresConnectionPoolEnabledChanged('postgres_connection_pool_enabled_changed'),
  postgresCreated('postgres_created'),
  postgresDiskSizeChanged('postgres_disk_size_changed'),
  postgresDiskAutoscalingEnabledChanged('postgres_disk_autoscaling_enabled_changed'),
  postgresHaStatusChanged('postgres_ha_status_changed'),
  postgresRestarted('postgres_restarted'),
  postgresUnavailable('postgres_unavailable'),
  postgresUpgradeFailed('postgres_upgrade_failed'),
  postgresUpgradeStarted('postgres_upgrade_started'),
  postgresUpgradeSucceeded('postgres_upgrade_succeeded'),
  postgresRestoreFailed('postgres_restore_failed'),
  postgresRestoreSucceeded('postgres_restore_succeeded'),
  postgresReadReplicasChanged('postgres_read_replicas_changed'),
  postgresPitrCheckpointStarted('postgres_pitr_checkpoint_started'),
  postgresPitrCheckpointFailed('postgres_pitr_checkpoint_failed'),
  postgresPitrCheckpointCompleted('postgres_pitr_checkpoint_completed'),
  postgresReadReplicaStale('postgres_read_replica_stale'),
  postgresWalArchiveFailed('postgres_wal_archive_failed'),
  keyValueAvailable('key_value_available'),
  keyValueConfigRestart('key_value_config_restart'),
  keyValueUnhealthy('key_value_unhealthy'),
  /// A value this package does not know about.
  unknown('');

  const WebhookWithCursorWebhookEventFilterItem(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WebhookWithCursorWebhookEventFilterItem fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class WebhookWithCursorWebhook {
  const WebhookWithCursorWebhook({
    required this.id,
    required this.url,
    required this.name,
    required this.secret,
    required this.enabled,
    required this.eventFilter,
  });

  factory WebhookWithCursorWebhook.fromJson(Map<String, Object?> json) => WebhookWithCursorWebhook(
        id: json['id'] as String? ?? '',
        url: json['url'] as String? ?? '',
        name: json['name'] as String? ?? '',
        secret: json['secret'] as String? ?? '',
        enabled: json['enabled'] as bool? ?? false,
        eventFilter: ((json['eventFilter'] as List<Object?>?) ?? const []).map((e) => WebhookWithCursorWebhookEventFilterItem.fromWire(e)).toList(),
      );

  final String id;
  final String url;
  final String name;
  final String secret;
  final bool enabled;
  /// The event types that will trigger the webhook. An empty list means all event types will trigger the webhook.
  final List<WebhookWithCursorWebhookEventFilterItem> eventFilter;

  Map<String, Object?> toJson() => {
        'id': id,
        'url': url,
        'name': name,
        'secret': secret,
        'enabled': enabled,
        'eventFilter': eventFilter.map((e) => e.wireValue).toList(),
      };
}

class WebhookWithCursor {
  const WebhookWithCursor({
    required this.webhook,
    required this.cursor,
  });

  factory WebhookWithCursor.fromJson(Map<String, Object?> json) => WebhookWithCursor(
        webhook: WebhookWithCursorWebhook.fromJson((json['webhook'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final WebhookWithCursorWebhook webhook;
  final String cursor;

  Map<String, Object?> toJson() => {
        'webhook': webhook.toJson(),
        'cursor': cursor,
      };
}


/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WorkflowVersionWithCursorWorkflowVersionStatus {
  created('created'),
  building('building'),
  registering('registering'),
  buildFailed('build_failed'),
  registrationFailed('registration_failed'),
  ready('ready'),
  /// A value this package does not know about.
  unknown('');

  const WorkflowVersionWithCursorWorkflowVersionStatus(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WorkflowVersionWithCursorWorkflowVersionStatus fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class WorkflowVersionWithCursorWorkflowVersion {
  const WorkflowVersionWithCursorWorkflowVersion({
    required this.id,
    required this.workflowId,
    required this.name,
    required this.createdAt,
    required this.status,
  });

  factory WorkflowVersionWithCursorWorkflowVersion.fromJson(Map<String, Object?> json) => WorkflowVersionWithCursorWorkflowVersion(
        id: json['id'] as String? ?? '',
        workflowId: json['workflowId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        status: WorkflowVersionWithCursorWorkflowVersionStatus.fromWire(json['status']),
      );

  final String id;
  final String workflowId;
  final String name;
  final DateTime createdAt;
  final WorkflowVersionWithCursorWorkflowVersionStatus status;

  Map<String, Object?> toJson() => {
        'id': id,
        'workflowId': workflowId,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        'status': status.wireValue,
      };
}

class WorkflowVersionWithCursor {
  const WorkflowVersionWithCursor({
    required this.workflowVersion,
    required this.cursor,
  });

  factory WorkflowVersionWithCursor.fromJson(Map<String, Object?> json) => WorkflowVersionWithCursor(
        workflowVersion: WorkflowVersionWithCursorWorkflowVersion.fromJson((json['workflowVersion'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final WorkflowVersionWithCursorWorkflowVersion workflowVersion;
  final String cursor;

  Map<String, Object?> toJson() => {
        'workflowVersion': workflowVersion.toJson(),
        'cursor': cursor,
      };
}


/// The runtime environment for the workflow (e.g., node, python, etc.).
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WorkflowWithCursorWorkflowBuildConfigRuntime {
  elixir('elixir'),
  go('go'),
  node('node'),
  python('python'),
  ruby('ruby'),
  /// A value this package does not know about.
  unknown('');

  const WorkflowWithCursorWorkflowBuildConfigRuntime(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WorkflowWithCursorWorkflowBuildConfigRuntime fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class WorkflowWithCursorWorkflowBuildConfig {
  const WorkflowWithCursorWorkflowBuildConfig({
    this.branch,
    required this.buildCommand,
    required this.repo,
    this.rootDir,
    required this.runtime,
  });

  factory WorkflowWithCursorWorkflowBuildConfig.fromJson(Map<String, Object?> json) => WorkflowWithCursorWorkflowBuildConfig(
        branch: json['branch'] as String?,
        buildCommand: json['buildCommand'] as String? ?? '',
        repo: json['repo'] as String? ?? '',
        rootDir: json['rootDir'] as String?,
        runtime: WorkflowWithCursorWorkflowBuildConfigRuntime.fromWire(json['runtime']),
      );

  /// The branch to use for the build, if applicable.
  final String? branch;
  /// The command to run to build the workflow.
  final String buildCommand;
  /// The repository URL to use for the build.
  final String repo;
  /// The root directory of the repository to use for the build, if applicable.
  final String? rootDir;
  /// The runtime environment for the workflow (e.g., node, python, etc.).
  final WorkflowWithCursorWorkflowBuildConfigRuntime runtime;

  Map<String, Object?> toJson() => {
        if (branch != null) 'branch': branch,
        'buildCommand': buildCommand,
        'repo': repo,
        if (rootDir != null) 'rootDir': rootDir,
        'runtime': runtime.wireValue,
      };
}

/// Defaults to "oregon"
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WorkflowWithCursorWorkflowRegion {
  frankfurt('frankfurt'),
  oregon('oregon'),
  ohio('ohio'),
  singapore('singapore'),
  virginia('virginia'),
  /// A value this package does not know about.
  unknown('');

  const WorkflowWithCursorWorkflowRegion(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WorkflowWithCursorWorkflowRegion fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

/// Controls autodeploy behavior. "commit" deploys when a commit is pushed to the branch. "checksPass" waits for CI checks to pass before deploying. "off" disables autodeploy.
/// Decodes unrecognised values to [unknown] rather than
/// throwing: Render ships new values without warning.
enum WorkflowWithCursorWorkflowAutoDeployTrigger {
  commit('commit'),
  off('off'),
  checksPass('checksPass'),
  /// A value this package does not know about.
  unknown('');

  const WorkflowWithCursorWorkflowAutoDeployTrigger(this.wireValue);

  /// The value exactly as Render sends it.
  final String wireValue;

  static WorkflowWithCursorWorkflowAutoDeployTrigger fromWire(Object? value) => values.firstWhere(
        (e) => e.wireValue == value,
        orElse: () => unknown,
      );
}

class WorkflowWithCursorWorkflow {
  const WorkflowWithCursorWorkflow({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.buildConfig,
    required this.runCommand,
    required this.region,
    this.environmentId,
    this.slug,
    this.autoDeployTrigger,
  });

  factory WorkflowWithCursorWorkflow.fromJson(Map<String, Object?> json) => WorkflowWithCursorWorkflow(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        ownerId: json['ownerId'] as String? ?? '',
        createdAt: parseDate(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: parseDate(json['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
        buildConfig: WorkflowWithCursorWorkflowBuildConfig.fromJson((json['buildConfig'] as Map<String, Object?>?) ?? const {}),
        runCommand: json['runCommand'] as String? ?? '',
        region: WorkflowWithCursorWorkflowRegion.fromWire(json['region']),
        environmentId: json['environmentId'] as String?,
        slug: json['slug'] as String?,
        autoDeployTrigger: WorkflowWithCursorWorkflowAutoDeployTrigger.fromWire(json['autoDeployTrigger']),
      );

  final String id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final WorkflowWithCursorWorkflowBuildConfig buildConfig;
  /// Command to run the workflow.
  final String runCommand;
  /// Defaults to "oregon"
  final WorkflowWithCursorWorkflowRegion region;
  final String? environmentId;
  final String? slug;
  /// Controls autodeploy behavior. "commit" deploys when a commit is pushed to the branch. "checksPass" waits for CI checks to pass before deploying. "off" disables autodeploy.
  final WorkflowWithCursorWorkflowAutoDeployTrigger? autoDeployTrigger;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'buildConfig': buildConfig.toJson(),
        'runCommand': runCommand,
        'region': region.wireValue,
        if (environmentId != null) 'environmentId': environmentId,
        if (slug != null) 'slug': slug,
        if (autoDeployTrigger != null) 'autoDeployTrigger': autoDeployTrigger!.wireValue,
      };
}

class WorkflowWithCursor {
  const WorkflowWithCursor({
    required this.workflow,
    required this.cursor,
  });

  factory WorkflowWithCursor.fromJson(Map<String, Object?> json) => WorkflowWithCursor(
        workflow: WorkflowWithCursorWorkflow.fromJson((json['workflow'] as Map<String, Object?>?) ?? const {}),
        cursor: json['cursor'] as String? ?? '',
      );

  final WorkflowWithCursorWorkflow workflow;
  final String cursor;

  Map<String, Object?> toJson() => {
        'workflow': workflow.toJson(),
        'cursor': cursor,
      };
}


/// Lenient ISO-8601 parsing: a malformed timestamp yields null rather than
/// failing an entire response.
DateTime? parseDate(Object? value) =>
    value is String ? DateTime.tryParse(value) : null;

