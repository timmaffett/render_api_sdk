// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../render_api.dart';

/// Every REST operation, named exactly as Render names it.
///
/// The official Node bindings expose one flat object, so
/// `renderApi.listHeaders({serviceId, limit})` becomes
/// `render.listHeaders(serviceId: ..., limit: ...)`. Each of
/// these forwards to the grouped form on [RenderApi.raw],
/// which is the same call by a different route.
extension RenderRestApi on RenderApi {
  /// Add disk
  Future<AddDiskResponse> addDisk({required Map<String, Object?> body}) =>
      raw.disks.addDisk(body: body);

  /// Add header rule
  Future<AddHeadersResponse> addHeaders({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.addHeaders(serviceId: serviceId, body: body);

  /// Add or update secret file
  Future<SecretFile> addOrUpdateSecretFile({required String serviceId, required String envVarKey, required Map<String, Object?> body}) =>
      raw.services.addOrUpdateSecretFile(serviceId: serviceId, envVarKey: envVarKey, body: body);

  /// Add resources to environment
  Future<Environment> addResourcesToEnvironment({required String environmentId, required Map<String, Object?> body}) =>
      raw.environments.addResourcesToEnvironment(environmentId: environmentId, body: body);

  /// Add redirect/rewrite rules
  Future<Route> addRoute({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.addRoute(serviceId: serviceId, body: body);

  /// Update autoscaling config
  Future<AutoscaleServiceResponse> autoscaleService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.autoscaleService(serviceId: serviceId, body: body);

  /// Cancel running cron job
  Future<void> cancelCronJobRun({required String cronJobId}) =>
      raw.cronJobs.cancelCronJobRun(cronJobId: cronJobId);

  /// Cancel deploy
  Future<Deploy> cancelDeploy({required String serviceId, required String deployId}) =>
      raw.services.cancelDeploy(serviceId: serviceId, deployId: deployId);

  /// Cancel running job
  Future<CancelJobResponse> cancelJob({required String serviceId, required String jobId}) =>
      raw.services.cancelJob(serviceId: serviceId, jobId: jobId);

  /// Cancel task run
  Future<void> cancelTaskRun({required String taskRunId}) =>
      raw.taskRuns.cancelTaskRun(taskRunId: taskRunId);

  /// Add custom domain
  Future<List<CustomDomain>> createCustomDomain({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.createCustomDomain(serviceId: serviceId, body: body);

  /// Create dedicated IP set
  Future<DedicatedIp> createDedicatedIp({required Map<String, Object?> body}) =>
      raw.dedicatedIps.createDedicatedIp(body: body);

  /// Trigger deploy
  Future<Deploy> createDeploy({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.createDeploy(serviceId: serviceId, body: body);

  /// Create environment group
  Future<Map<String, Object?>> createEnvGroup({required Map<String, Object?> body}) =>
      raw.envGroups.createEnvGroup(body: body);

  /// Create environment
  Future<Environment> createEnvironment({required Map<String, Object?> body}) =>
      raw.environments.createEnvironment(body: body);

  /// Create Key Value instance
  Future<KeyValueDetail> createKeyValue({required Map<String, Object?> body}) =>
      raw.keyValue.createKeyValue(body: body);

  /// Create Postgres instance
  Future<PostgresDetail> createPostgres({required Map<String, Object?> body}) =>
      raw.postgres.createPostgres(body: body);

  /// Create Postgres export
  Future<void> createPostgresExport({required String postgresId}) =>
      raw.postgres.createPostgresExport(postgresId: postgresId);

  /// Create PostgreSQL User
  Future<void> createPostgresUser({required String postgresId, required Map<String, Object?> body}) =>
      raw.postgres.createPostgresUser(postgresId: postgresId, body: body);

  /// Create project
  Future<Project> createProject({required Map<String, Object?> body}) =>
      raw.projects.createProject(body: body);

  /// Create Redis instance
  Future<RedisDetail> createRedis({required Map<String, Object?> body}) =>
      raw.redis.createRedis(body: body);

  /// Create registry credential
  Future<RegistryCredential> createRegistryCredential({required Map<String, Object?> body}) =>
      raw.registrycredentials.createRegistryCredential(body: body);

  /// Create service
  Future<ServiceAndDeploy> createService({required Map<String, Object?> body}) =>
      raw.services.createService(body: body);

  /// Run task
  Future<CreateTaskResponse> createTask({required Map<String, Object?> body}) =>
      raw.taskRuns.createTask(body: body);

  /// Create a webhook
  Future<CreateWebhookResponse> createWebhook({required Map<String, Object?> body}) =>
      raw.webhooks.createWebhook(body: body);

  /// Create a workflow
  Future<CreateWorkflowResponse> createWorkflow({required Map<String, Object?> body}) =>
      raw.workflows.createWorkflow(body: body);

  /// Deploy a workflow version
  Future<void> createWorkflowVersion({required Map<String, Object?> body}) =>
      raw.workflowversions.createWorkflowVersion(body: body);

  /// Delete autoscaling config
  Future<void> deleteAutoscalingConfig({required String serviceId}) =>
      raw.services.deleteAutoscalingConfig(serviceId: serviceId);

  /// Delete custom domain
  Future<void> deleteCustomDomain({required String serviceId, required String customDomainNameOrId}) =>
      raw.services.deleteCustomDomain(serviceId: serviceId, customDomainNameOrId: customDomainNameOrId);

  /// Delete dedicated IP set
  Future<void> deleteDedicatedIp({required String dedicatedIpId}) =>
      raw.dedicatedIps.deleteDedicatedIp(dedicatedIpId: dedicatedIpId);

  /// Delete disk
  Future<void> deleteDisk({required String diskId}) =>
      raw.disks.deleteDisk(diskId: diskId);

  /// Delete environment group
  Future<void> deleteEnvGroup({required String envGroupId}) =>
      raw.envGroups.deleteEnvGroup(envGroupId: envGroupId);

  /// Remove environment variable
  Future<void> deleteEnvGroupEnvVar({required String envGroupId, required String envVarKey}) =>
      raw.envGroups.deleteEnvGroupEnvVar(envGroupId: envGroupId, envVarKey: envVarKey);

  /// Remove secret file
  Future<void> deleteEnvGroupSecretFile({required String envGroupId, required String envVarKey}) =>
      raw.envGroups.deleteEnvGroupSecretFile(envGroupId: envGroupId, envVarKey: envVarKey);

  /// Delete environment variable
  Future<void> deleteEnvVar({required String serviceId, required String envVarKey}) =>
      raw.services.deleteEnvVar(serviceId: serviceId, envVarKey: envVarKey);

  /// Delete environment
  Future<void> deleteEnvironment({required String environmentId}) =>
      raw.environments.deleteEnvironment(environmentId: environmentId);

  /// Delete header rule
  Future<void> deleteHeader({required String serviceId, required String headerId}) =>
      raw.services.deleteHeader(serviceId: serviceId, headerId: headerId);

  /// Delete Key Value instance
  Future<void> deleteKeyValue({required String redisId}) =>
      raw.keyValue.deleteKeyValue(redisId: redisId);

  /// Delete log stream
  Future<void> deleteOwnerLogStream({required String ownerId}) =>
      raw.logs.deleteOwnerLogStream(ownerId: ownerId);

  /// Delete metrics stream
  Future<void> deleteOwnerMetricsStream({required String ownerId}) =>
      raw.metricsStream.deleteOwnerMetricsStream(ownerId: ownerId);

  /// Delete Postgres instance
  Future<void> deletePostgres({required String postgresId}) =>
      raw.postgres.deletePostgres(postgresId: postgresId);

  /// Delete PostgreSQL User
  Future<void> deletePostgresUser({required String postgresId, required String username}) =>
      raw.postgres.deletePostgresUser(postgresId: postgresId, username: username);

  /// Delete project
  Future<void> deleteProject({required String projectId}) =>
      raw.projects.deleteProject(projectId: projectId);

  /// Delete Redis instance
  Future<void> deleteRedis({required String redisId}) =>
      raw.redis.deleteRedis(redisId: redisId);

  /// Delete registry credential
  Future<void> deleteRegistryCredential({required String registryCredentialId}) =>
      raw.registrycredentials.deleteRegistryCredential(registryCredentialId: registryCredentialId);

  /// Delete log stream override
  Future<void> deleteResourceLogStream({required String resourceId}) =>
      raw.logs.deleteResourceLogStream(resourceId: resourceId);

  /// Delete redirect/rewrite rule
  Future<void> deleteRoute({required String serviceId, required String routeId}) =>
      raw.services.deleteRoute(serviceId: serviceId, routeId: routeId);

  /// Delete secret file
  Future<void> deleteSecretFile({required String serviceId, required String envVarKey}) =>
      raw.services.deleteSecretFile(serviceId: serviceId, envVarKey: envVarKey);

  /// Delete service
  Future<void> deleteService({required String serviceId}) =>
      raw.services.deleteService(serviceId: serviceId);

  /// Delete a webhook
  Future<void> deleteWebhook({required String webhookId}) =>
      raw.webhooks.deleteWebhook(webhookId: webhookId);

  /// Delete workflow
  Future<void> deleteWorkflow({required String workflowId}) =>
      raw.workflows.deleteWorkflow(workflowId: workflowId);

  /// Disconnect Blueprint
  Future<void> disconnectBlueprint({required String blueprintId}) =>
      raw.blueprints.disconnectBlueprint(blueprintId: blueprintId);

  /// Failover Postgres instance
  Future<void> failoverPostgres({required String postgresId}) =>
      raw.postgres.failoverPostgres(postgresId: postgresId);

  /// Get active connection count
  Future<List<GetActiveConnectionsResponse>> getActiveConnections({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) =>
      raw.metrics.getActiveConnections(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource);

  /// Get bandwidth usage
  Future<List<GetBandwidthResponse>> getBandwidth({String? startTime, String? endTime, String? resource, String? service}) =>
      raw.metrics.getBandwidth(startTime: startTime, endTime: endTime, resource: resource, service: service);

  /// Get bandwidth usage breakdown by traffic source
  Future<GetBandwidthSourcesResponse> getBandwidthSources({String? startTime, String? endTime, String? resource, String? service}) =>
      raw.metrics.getBandwidthSources(startTime: startTime, endTime: endTime, resource: resource, service: service);

  /// Get CPU usage
  Future<List<GetCpuResponse>> getCpu({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance, String? aggregationMethod}) =>
      raw.metrics.getCpu(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance, aggregationMethod: aggregationMethod);

  /// Get CPU limit
  Future<List<GetCpuLimitResponse>> getCpuLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) =>
      raw.metrics.getCpuLimit(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance);

  /// Get CPU target
  Future<List<GetCpuTargetResponse>> getCpuTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) =>
      raw.metrics.getCpuTarget(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance);

  /// Get disk capacity
  Future<List<GetDiskCapacityResponse>> getDiskCapacity({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) =>
      raw.metrics.getDiskCapacity(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service);

  /// Get disk usage
  Future<List<GetDiskUsageResponse>> getDiskUsage({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) =>
      raw.metrics.getDiskUsage(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service);

  /// List environment variables
  Future<List<EnvVarWithCursor>> getEnvVarsForService({required String serviceId, String? cursor, int? limit}) =>
      raw.services.getEnvVarsForService(serviceId: serviceId, cursor: cursor, limit: limit);

  /// Get HTTP latency
  Future<List<GetHttpLatencyResponse>> getHttpLatency({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, double? quantile}) =>
      raw.metrics.getHttpLatency(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, host: host, path: path, quantile: quantile);

  /// Get HTTP request count
  Future<List<GetHttpRequestsResponse>> getHttpRequests({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? path, String? aggregateBy}) =>
      raw.metrics.getHttpRequests(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, host: host, path: path, aggregateBy: aggregateBy);

  /// Get instance count
  Future<List<GetInstanceCountResponse>> getInstanceCount({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) =>
      raw.metrics.getInstanceCount(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service);

  /// Get memory usage
  Future<List<GetMemoryResponse>> getMemory({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) =>
      raw.metrics.getMemory(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance);

  /// Get memory limit
  Future<List<GetMemoryLimitResponse>> getMemoryLimit({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) =>
      raw.metrics.getMemoryLimit(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance);

  /// Get memory target
  Future<List<GetMemoryTargetResponse>> getMemoryTarget({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? instance}) =>
      raw.metrics.getMemoryTarget(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, instance: instance);

  /// Retrieve log stream
  Future<GetOwnerLogStreamResponse> getOwnerLogStream({required String ownerId}) =>
      raw.logs.getOwnerLogStream(ownerId: ownerId);

  /// Retrieve metrics stream
  Future<GetOwnerMetricsStreamResponse> getOwnerMetricsStream({required String ownerId}) =>
      raw.metricsStream.getOwnerMetricsStream(ownerId: ownerId);

  /// Get replica lag
  Future<List<GetReplicationLagResponse>> getReplicationLag({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) =>
      raw.metrics.getReplicationLag(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource);

  /// Retrieve log stream override
  Future<GetResourceLogStreamResponse> getResourceLogStream({required String resourceId}) =>
      raw.logs.getResourceLogStream(resourceId: resourceId);

  /// Retrieve task
  Future<GetTaskResponse> getTask({required String taskId}) =>
      raw.tasks.getTask(taskId: taskId);

  /// Retrieve task run
  Future<GetTaskRunResponse> getTaskRun({required String taskRunId}) =>
      raw.taskRuns.getTaskRun(taskRunId: taskRunId);

  /// Get task runs completed count
  Future<List<GetTaskRunsCompletedResponse>> getTaskRunsCompleted({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? state, String? aggregateBy}) =>
      raw.metrics.getTaskRunsCompleted(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, state: state, aggregateBy: aggregateBy);

  /// Get task runs queued count
  Future<List<GetTaskRunsQueuedResponse>> getTaskRunsQueued({String? startTime, String? endTime, double? resolutionSeconds, String? resource}) =>
      raw.metrics.getTaskRunsQueued(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource);

  /// Get the authenticated user
  Future<User> getUser() =>
      raw.users.getUser();

  /// Retrieve workflow
  Future<GetWorkflowResponse> getWorkflow({required String workflowId}) =>
      raw.workflows.getWorkflow(workflowId: workflowId);

  /// Retrieve workflow version
  Future<GetWorkflowVersionResponse> getWorkflowVersion({required String workflowVersionId}) =>
      raw.workflowversions.getWorkflowVersion(workflowVersionId: workflowVersionId);

  /// Link service
  Future<Map<String, Object?>> linkServiceToEnvGroup({required String envGroupId, required String serviceId}) =>
      raw.envGroups.linkServiceToEnvGroup(envGroupId: envGroupId, serviceId: serviceId);

  /// List queryable instance values
  Future<List<ListApplicationFilterValuesResponse>> listApplicationFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service}) =>
      raw.metrics.listApplicationFilterValues(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service);

  /// List Blueprint syncs
  Future<List<SyncWithCursor>> listBlueprintSyncs({required String blueprintId, String? cursor, int? limit}) =>
      raw.blueprints.listBlueprintSyncs(blueprintId: blueprintId, cursor: cursor, limit: limit);

  /// List Blueprints
  Future<List<BlueprintWithCursor>> listBlueprints({List<String>? ownerId, String? cursor, int? limit}) =>
      raw.blueprints.listBlueprints(ownerId: ownerId, cursor: cursor, limit: limit);

  /// List custom domains
  Future<List<CustomDomainWithCursor>> listCustomDomains({required String serviceId, String? cursor, int? limit, List<String>? name, String? domainType, String? verificationStatus, String? createdBefore, String? createdAfter}) =>
      raw.services.listCustomDomains(serviceId: serviceId, cursor: cursor, limit: limit, name: name, domainType: domainType, verificationStatus: verificationStatus, createdBefore: createdBefore, createdAfter: createdAfter);

  /// List dedicated IPs
  Future<List<DedicatedIp>> listDedicatedIps({required String ownerId, String? environmentId}) =>
      raw.dedicatedIps.listDedicatedIps(ownerId: ownerId, environmentId: environmentId);

  /// List deploys
  Future<List<DeployWithCursor>> listDeploys({required String serviceId, List<String>? status, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, String? finishedBefore, String? finishedAfter, String? cursor, int? limit}) =>
      raw.services.listDeploys(serviceId: serviceId, status: status, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, finishedBefore: finishedBefore, finishedAfter: finishedAfter, cursor: cursor, limit: limit);

  /// List disks
  Future<List<DiskWithCursor>> listDisks({List<String>? ownerId, List<String>? diskId, List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? serviceId, String? cursor, int? limit}) =>
      raw.disks.listDisks(ownerId: ownerId, diskId: diskId, name: name, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, serviceId: serviceId, cursor: cursor, limit: limit);

  /// List environment groups
  Future<List<EnvGroupMeta>> listEnvGroups({List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) =>
      raw.envGroups.listEnvGroups(name: name, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, environmentId: environmentId, cursor: cursor, limit: limit);

  /// List environments
  Future<List<EnvironmentWithCursor>> listEnvironments({List<String>? name, required List<String> projectId, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) =>
      raw.environments.listEnvironments(name: name, projectId: projectId, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, environmentId: environmentId, cursor: cursor, limit: limit);

  /// List events
  Future<List<ServiceEventWithCursor>> listEvents({required String serviceId, Object? type, String? startTime, String? endTime, String? cursor, int? limit}) =>
      raw.services.listEvents(serviceId: serviceId, type: type, startTime: startTime, endTime: endTime, cursor: cursor, limit: limit);

  /// List header rules
  Future<List<HeaderWithCursor>> listHeaders({required String serviceId, List<String>? path, List<String>? name, List<String>? value, String? cursor, int? limit}) =>
      raw.services.listHeaders(serviceId: serviceId, path: path, name: name, value: value, cursor: cursor, limit: limit);

  /// List queryable status codes and host values
  Future<List<ListHttpFilterValuesResponse>> listHttpFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode}) =>
      raw.metrics.listHttpFilterValues(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, host: host, statusCode: statusCode);

  /// List instances
  Future<List<ServiceInstance>> listInstances({required String serviceId}) =>
      raw.services.listInstances(serviceId: serviceId);

  /// List jobs
  Future<List<JobWithCursor>> listJob({required String serviceId, String? cursor, int? limit, List<String>? status, String? createdBefore, String? createdAfter, String? startedBefore, String? startedAfter, String? finishedBefore, String? finishedAfter}) =>
      raw.services.listJob(serviceId: serviceId, cursor: cursor, limit: limit, status: status, createdBefore: createdBefore, createdAfter: createdAfter, startedBefore: startedBefore, startedAfter: startedAfter, finishedBefore: finishedBefore, finishedAfter: finishedAfter);

  /// List Key Value instances
  Future<List<KeyValueWithCursor>> listKeyValue({List<String>? name, List<String>? region, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) =>
      raw.keyValue.listKeyValue(name: name, region: region, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, environmentId: environmentId, cursor: cursor, limit: limit);

  /// List logs
  Future<ListLogsResponse> listLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) =>
      raw.logs.listLogs(ownerId: ownerId, startTime: startTime, endTime: endTime, direction: direction, resource: resource, instance: instance, host: host, statusCode: statusCode, method: method, task: task, taskRun: taskRun, sandbox: sandbox, level: level, type: type, text: text, path: path, limit: limit);

  /// List log label values
  Future<List<Object?>> listLogsValues({required String ownerId, required String label, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) =>
      raw.logs.listLogsValues(ownerId: ownerId, label: label, startTime: startTime, endTime: endTime, direction: direction, resource: resource, instance: instance, host: host, statusCode: statusCode, method: method, task: task, taskRun: taskRun, sandbox: sandbox, level: level, type: type, text: text, path: path, limit: limit);

  /// List maintenance runs
  Future<List<ListMaintenanceResponse>> listMaintenance({List<String>? resourceId, List<String>? ownerId, List<String>? state}) =>
      raw.maintenance.listMaintenance(resourceId: resourceId, ownerId: ownerId, state: state);

  /// List notification overrides
  Future<List<NotificationOverrideWithCursor>> listNotificationOverrides({List<String>? ownerId, List<String>? serviceId, String? cursor, int? limit}) =>
      raw.notificationSettings.listNotificationOverrides(ownerId: ownerId, serviceId: serviceId, cursor: cursor, limit: limit);

  /// List organization audit logs
  Future<List<AuditLogWithCursor>> listOrganizationAuditLogs({required String orgId, String? startTime, String? endTime, String? direction, String? cursor, int? limit}) =>
      raw.organizations.listOrganizationAuditLogs(orgId: orgId, startTime: startTime, endTime: endTime, direction: direction, cursor: cursor, limit: limit);

  /// List workspace audit logs
  Future<List<AuditLogWithCursor>> listOwnerAuditLogs({required String ownerId, String? startTime, String? endTime, String? direction, String? cursor, int? limit}) =>
      raw.owners.listOwnerAuditLogs(ownerId: ownerId, startTime: startTime, endTime: endTime, direction: direction, cursor: cursor, limit: limit);

  /// List workspaces
  Future<List<OwnerWithCursor>> listOwners({List<String>? name, List<String>? email, String? cursor, int? limit}) =>
      raw.owners.listOwners(name: name, email: email, cursor: cursor, limit: limit);

  /// List queryable paths
  Future<List<Object?>> listPathFilterValues({String? startTime, String? endTime, double? resolutionSeconds, String? resource, String? service, String? host, String? statusCode, String? path}) =>
      raw.metrics.listPathFilterValues(startTime: startTime, endTime: endTime, resolutionSeconds: resolutionSeconds, resource: resource, service: service, host: host, statusCode: statusCode, path: path);

  /// List Postgres instances
  Future<List<PostgresWithCursor>> listPostgres({List<String>? name, List<String>? region, List<String>? suspended, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, bool? includeReplicas, String? cursor, int? limit}) =>
      raw.postgres.listPostgres(name: name, region: region, suspended: suspended, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, environmentId: environmentId, includeReplicas: includeReplicas, cursor: cursor, limit: limit);

  /// List Postgres exports
  Future<List<ListPostgresExportResponse>> listPostgresExport({required String postgresId}) =>
      raw.postgres.listPostgresExport(postgresId: postgresId);

  /// List live queries
  Future<ListPostgresProcessesResponse> listPostgresProcesses({required String postgresId}) =>
      raw.postgres.listPostgresProcesses(postgresId: postgresId);

  /// List database, table, and index sizes
  Future<ListPostgresSizesResponse> listPostgresSizes({required String postgresId}) =>
      raw.postgres.listPostgresSizes(postgresId: postgresId);

  /// List table scans
  Future<ListPostgresTableScansResponse> listPostgresTableScans({required String postgresId}) =>
      raw.postgres.listPostgresTableScans(postgresId: postgresId);

  /// List top queries
  Future<ListPostgresTopQueriesResponse> listPostgresTopQueries({required String postgresId}) =>
      raw.postgres.listPostgresTopQueries(postgresId: postgresId);

  /// List PostgreSQL Users
  Future<List<ListPostgresUsersResponse>> listPostgresUsers({required String postgresId}) =>
      raw.postgres.listPostgresUsers(postgresId: postgresId);

  /// List projects
  Future<List<ProjectWithCursor>> listProjects({List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, String? cursor, int? limit}) =>
      raw.projects.listProjects(name: name, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, cursor: cursor, limit: limit);

  /// List Redis instances
  Future<List<RedisWithCursor>> listRedis({List<String>? name, List<String>? region, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit}) =>
      raw.redis.listRedis(name: name, region: region, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, environmentId: environmentId, cursor: cursor, limit: limit);

  /// List registry credentials
  Future<List<RegistryCredential>> listRegistryCredentials({List<String>? name, List<String>? username, List<String>? type, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, String? cursor, int? limit}) =>
      raw.registrycredentials.listRegistryCredentials(name: name, username: username, type: type, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, cursor: cursor, limit: limit);

  /// List log stream overrides
  Future<List<ListResourceLogStreamsResponse>> listResourceLogStreams({List<String>? ownerId, List<String>? logStreamId, List<String>? resourceId, List<String>? setting, String? cursor, int? limit}) =>
      raw.logs.listResourceLogStreams(ownerId: ownerId, logStreamId: logStreamId, resourceId: resourceId, setting: setting, cursor: cursor, limit: limit);

  /// List redirect/rewrite rules
  Future<List<RouteWithCursor>> listRoutes({required String serviceId, List<String>? type, List<String>? source, List<String>? destination, String? cursor, int? limit}) =>
      raw.services.listRoutes(serviceId: serviceId, type: type, source: source, destination: destination, cursor: cursor, limit: limit);

  /// List secret files
  Future<List<SecretFileWithCursor>> listSecretFilesForService({required String serviceId, String? cursor, int? limit}) =>
      raw.services.listSecretFilesForService(serviceId: serviceId, cursor: cursor, limit: limit);

  /// List services
  Future<List<ServiceWithCursor>> listServices({List<String>? name, List<String>? type, List<String>? environmentId, List<String>? env, List<String>? region, List<String>? suspended, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, bool? includePreviews, String? cursor, int? limit}) =>
      raw.services.listServices(name: name, type: type, environmentId: environmentId, env: env, region: region, suspended: suspended, createdBefore: createdBefore, createdAfter: createdAfter, updatedBefore: updatedBefore, updatedAfter: updatedAfter, ownerId: ownerId, includePreviews: includePreviews, cursor: cursor, limit: limit);

  /// List snapshots
  Future<List<DiskSnapshot>> listSnapshots({required String diskId}) =>
      raw.disks.listSnapshots(diskId: diskId);

  /// List task runs
  Future<List<TaskRunWithCursor>> listTaskRuns({String? cursor, int? limit, List<String>? taskSlug, List<String>? rootTaskRunId, List<String>? ownerId, List<String>? workflowVersionId, List<String>? workflowId}) =>
      raw.taskRuns.listTaskRuns(cursor: cursor, limit: limit, taskSlug: taskSlug, rootTaskRunId: rootTaskRunId, ownerId: ownerId, workflowVersionId: workflowVersionId, workflowId: workflowId);

  /// List tasks
  Future<List<TaskWithCursor>> listTasks({String? cursor, int? limit, List<String>? ownerId, List<String>? taskSlug, List<String>? workflowVersionId, List<String>? workflowId}) =>
      raw.tasks.listTasks(cursor: cursor, limit: limit, ownerId: ownerId, taskSlug: taskSlug, workflowVersionId: workflowVersionId, workflowId: workflowId);

  /// List webhook events
  Future<List<WebhookEventWithCursor>> listWebhookEvents({required String webhookId, String? sentBefore, String? sentAfter, int? limit, String? cursor}) =>
      raw.webhooks.listWebhookEvents(webhookId: webhookId, sentBefore: sentBefore, sentAfter: sentAfter, limit: limit, cursor: cursor);

  /// List webhooks
  Future<List<WebhookWithCursor>> listWebhooks({String? cursor, int? limit, List<String>? ownerId}) =>
      raw.webhooks.listWebhooks(cursor: cursor, limit: limit, ownerId: ownerId);

  /// List workflow versions
  Future<List<WorkflowVersionWithCursor>> listWorkflowVersions({List<String>? ownerId, List<String>? workflowId, List<String>? workflowVersionId, String? cursor, int? limit}) =>
      raw.workflowversions.listWorkflowVersions(ownerId: ownerId, workflowId: workflowId, workflowVersionId: workflowVersionId, cursor: cursor, limit: limit);

  /// List workflows
  Future<List<WorkflowWithCursor>> listWorkflows({List<String>? name, List<String>? ownerId, List<String>? workflowId, List<String>? environmentId, String? cursor, int? limit}) =>
      raw.workflows.listWorkflows(name: name, ownerId: ownerId, workflowId: workflowId, environmentId: environmentId, cursor: cursor, limit: limit);

  /// Update notification settings
  Future<PatchOwnerNotificationSettingsResponse> patchOwnerNotificationSettings({required String ownerId, required Map<String, Object?> body}) =>
      raw.notificationSettings.patchOwnerNotificationSettings(ownerId: ownerId, body: body);

  /// Update redirect/rewrite rule priority
  Future<PatchRouteResponse> patchRoute({required String serviceId, required String routeId, required Map<String, Object?> body}) =>
      raw.services.patchRoute(serviceId: serviceId, routeId: routeId, body: body);

  /// Update notification override
  Future<PatchServiceNotificationOverridesResponse> patchServiceNotificationOverrides({required String serviceId, required Map<String, Object?> body}) =>
      raw.notificationSettings.patchServiceNotificationOverrides(serviceId: serviceId, body: body);

  /// Create job
  Future<PostJobResponse> postJob({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.postJob(serviceId: serviceId, body: body);

  /// Create service preview (image-backed)
  Future<ServiceAndDeploy> previewService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.previewService(serviceId: serviceId, body: body);

  /// Purge Web Service Cache
  Future<void> purgeCache({required String serviceId}) =>
      raw.services.purgeCache(serviceId: serviceId);

  /// Update redirect/rewrite rules
  Future<List<Route>> putRoutes({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.putRoutes(serviceId: serviceId, body: body);

  /// Trigger point-in-time recovery
  Future<PostgresDetail> recoverPostgres({required String postgresId, required Map<String, Object?> body}) =>
      raw.postgres.recoverPostgres(postgresId: postgresId, body: body);

  /// Verify DNS configuration
  Future<void> refreshCustomDomain({required String serviceId, required String customDomainNameOrId}) =>
      raw.services.refreshCustomDomain(serviceId: serviceId, customDomainNameOrId: customDomainNameOrId);

  /// Remove resources from environment
  Future<void> removeResourcesFromEnvironment({required String environmentId, required List<String> resourceIds}) =>
      raw.environments.removeResourcesFromEnvironment(environmentId: environmentId, resourceIds: resourceIds);

  /// Remove workspace member
  Future<void> removeWorkspaceMember({required String ownerId, required String userId}) =>
      raw.owners.removeWorkspaceMember(ownerId: ownerId, userId: userId);

  /// Restart Postgres instance
  Future<void> restartPostgres({required String postgresId}) =>
      raw.postgres.restartPostgres(postgresId: postgresId);

  /// Restart service
  Future<void> restartService({required String serviceId}) =>
      raw.services.restartService(serviceId: serviceId);

  /// Restore snapshot
  Future<RestoreSnapshotResponse> restoreSnapshot({required String diskId, required Map<String, Object?> body}) =>
      raw.disks.restoreSnapshot(diskId: diskId, body: body);

  /// Resume Key Value instance
  Future<void> resumeKeyValue({required String redisId}) =>
      raw.keyValue.resumeKeyValue(redisId: redisId);

  /// Resume Postgres instance
  Future<void> resumePostgres({required String postgresId}) =>
      raw.postgres.resumePostgres(postgresId: postgresId);

  /// Resume Redis instance
  Future<void> resumeRedis({required String redisId}) =>
      raw.redis.resumeRedis(redisId: redisId);

  /// Resume service
  Future<void> resumeService({required String serviceId}) =>
      raw.services.resumeService(serviceId: serviceId);

  /// Retrieve Blueprint
  Future<RetrieveBlueprintResponse> retrieveBlueprint({required String blueprintId}) =>
      raw.blueprints.retrieveBlueprint(blueprintId: blueprintId);

  /// Retrieve custom domain
  Future<CustomDomain> retrieveCustomDomain({required String serviceId, required String customDomainNameOrId}) =>
      raw.services.retrieveCustomDomain(serviceId: serviceId, customDomainNameOrId: customDomainNameOrId);

  /// Retrieve dedicated IP set
  Future<DedicatedIp> retrieveDedicatedIp({required String dedicatedIpId}) =>
      raw.dedicatedIps.retrieveDedicatedIp(dedicatedIpId: dedicatedIpId);

  /// Retrieve deploy
  Future<Deploy> retrieveDeploy({required String serviceId, required String deployId}) =>
      raw.services.retrieveDeploy(serviceId: serviceId, deployId: deployId);

  /// Retrieve disk
  Future<RetrieveDiskResponse> retrieveDisk({required String diskId}) =>
      raw.disks.retrieveDisk(diskId: diskId);

  /// Retrieve environment group
  Future<Map<String, Object?>> retrieveEnvGroup({required String envGroupId}) =>
      raw.envGroups.retrieveEnvGroup(envGroupId: envGroupId);

  /// Retrieve environment variable
  Future<EnvVar> retrieveEnvGroupEnvVar({required String envGroupId, required String envVarKey}) =>
      raw.envGroups.retrieveEnvGroupEnvVar(envGroupId: envGroupId, envVarKey: envVarKey);

  /// Retrieve secret file
  Future<SecretFile> retrieveEnvGroupSecretFile({required String envGroupId, required String envVarKey}) =>
      raw.envGroups.retrieveEnvGroupSecretFile(envGroupId: envGroupId, envVarKey: envVarKey);

  /// Retrieve environment variable
  Future<EnvVar> retrieveEnvVar({required String serviceId, required String envVarKey}) =>
      raw.services.retrieveEnvVar(serviceId: serviceId, envVarKey: envVarKey);

  /// Retrieve environment
  Future<Environment> retrieveEnvironment({required String environmentId}) =>
      raw.environments.retrieveEnvironment(environmentId: environmentId);

  /// Retrieve event
  Future<RetrieveEventResponse> retrieveEvent({required String eventId}) =>
      raw.events.retrieveEvent(eventId: eventId);

  /// Retrieve job
  Future<RetrieveJobResponse> retrieveJob({required String serviceId, required String jobId}) =>
      raw.services.retrieveJob(serviceId: serviceId, jobId: jobId);

  /// Retrieve Key Value instance
  Future<KeyValueDetail> retrieveKeyValue({required String redisId}) =>
      raw.keyValue.retrieveKeyValue(redisId: redisId);

  /// Retrieve Key Value connection info
  Future<KeyValueConnectionInfo> retrieveKeyValueConnectionInfo({required String redisId}) =>
      raw.keyValue.retrieveKeyValueConnectionInfo(redisId: redisId);

  /// Retrieve maintenance run
  Future<RetrieveMaintenanceResponse> retrieveMaintenance({required String maintenanceRunId}) =>
      raw.maintenance.retrieveMaintenance(maintenanceRunId: maintenanceRunId);

  /// Retrieve workspace
  Future<Owner> retrieveOwner({required String ownerId}) =>
      raw.owners.retrieveOwner(ownerId: ownerId);

  /// List workspace members
  Future<List<TeamMember>> retrieveOwnerMembers({required String ownerId}) =>
      raw.owners.retrieveOwnerMembers(ownerId: ownerId);

  /// Retrieve notification settings
  Future<RetrieveOwnerNotificationSettingsResponse> retrieveOwnerNotificationSettings({required String ownerId}) =>
      raw.notificationSettings.retrieveOwnerNotificationSettings(ownerId: ownerId);

  /// Retrieve Postgres instance
  Future<PostgresDetail> retrievePostgres({required String postgresId}) =>
      raw.postgres.retrievePostgres(postgresId: postgresId);

  /// Retrieve Postgres connection info
  Future<PostgresConnectionInfo> retrievePostgresConnectionInfo({required String postgresId}) =>
      raw.postgres.retrievePostgresConnectionInfo(postgresId: postgresId);

  /// Retrieve point-in-time recovery status
  Future<RetrievePostgresRecoveryInfoResponse> retrievePostgresRecoveryInfo({required String postgresId}) =>
      raw.postgres.retrievePostgresRecoveryInfo(postgresId: postgresId);

  /// Retrieve Project
  Future<Project> retrieveProject({required String projectId}) =>
      raw.projects.retrieveProject(projectId: projectId);

  /// Retrieve Redis instance
  Future<RedisDetail> retrieveRedis({required String redisId}) =>
      raw.redis.retrieveRedis(redisId: redisId);

  /// Retrieve Redis connection info
  Future<RedisConnectionInfo> retrieveRedisConnectionInfo({required String redisId}) =>
      raw.redis.retrieveRedisConnectionInfo(redisId: redisId);

  /// Retrieve registry credential
  Future<RegistryCredential> retrieveRegistryCredential({required String registryCredentialId}) =>
      raw.registrycredentials.retrieveRegistryCredential(registryCredentialId: registryCredentialId);

  /// Retrieve secret file
  Future<SecretFile> retrieveSecretFile({required String serviceId, required String envVarKey}) =>
      raw.services.retrieveSecretFile(serviceId: serviceId, envVarKey: envVarKey);

  /// Retrieve service
  Future<Service> retrieveService({required String serviceId}) =>
      raw.services.retrieveService(serviceId: serviceId);

  /// Retrieve notification override
  Future<RetrieveServiceNotificationOverridesResponse> retrieveServiceNotificationOverrides({required String serviceId}) =>
      raw.notificationSettings.retrieveServiceNotificationOverrides(serviceId: serviceId);

  /// Retrieve service outbound IPs
  Future<OutboundIps> retrieveServiceOutboundIps({required String serviceId}) =>
      raw.services.retrieveServiceOutboundIps(serviceId: serviceId);

  /// Retrieve a webhook
  Future<RetrieveWebhookResponse> retrieveWebhook({required String webhookId}) =>
      raw.webhooks.retrieveWebhook(webhookId: webhookId);

  /// Roll back deploy
  Future<Deploy> rollbackDeploy({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.rollbackDeploy(serviceId: serviceId, body: body);

  /// Trigger cron job run
  Future<CronJobRun> runCronJob({required String cronJobId}) =>
      raw.cronJobs.runCronJob(cronJobId: cronJobId);

  /// Scale instance count
  Future<void> scaleService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.scaleService(serviceId: serviceId, body: body);

  /// Stream realtime events (SSE)
  Future<void> streamTaskRunsEvents({required List<String> taskRunIds}) =>
      raw.taskRuns.streamTaskRunsEvents(taskRunIds: taskRunIds);

  /// Subscribe to new logs
  Future<void> subscribeLogs({required String ownerId, String? startTime, String? endTime, String? direction, required List<String> resource, List<String>? instance, List<String>? host, List<String>? statusCode, List<String>? method, List<String>? task, List<String>? taskRun, List<String>? sandbox, List<String>? level, List<String>? type, List<String>? text, List<String>? path, int? limit}) =>
      raw.logs.subscribeLogs(ownerId: ownerId, startTime: startTime, endTime: endTime, direction: direction, resource: resource, instance: instance, host: host, statusCode: statusCode, method: method, task: task, taskRun: taskRun, sandbox: sandbox, level: level, type: type, text: text, path: path, limit: limit);

  /// Suspend Key Value instance
  Future<void> suspendKeyValue({required String redisId}) =>
      raw.keyValue.suspendKeyValue(redisId: redisId);

  /// Suspend Postgres instance
  Future<void> suspendPostgres({required String postgresId}) =>
      raw.postgres.suspendPostgres(postgresId: postgresId);

  /// Suspend Redis instance
  Future<void> suspendRedis({required String redisId}) =>
      raw.redis.suspendRedis(redisId: redisId);

  /// Suspend service
  Future<void> suspendService({required String serviceId}) =>
      raw.services.suspendService(serviceId: serviceId);

  /// Trigger maintenance run
  Future<void> triggerMaintenance({required String maintenanceRunId}) =>
      raw.maintenance.triggerMaintenance(maintenanceRunId: maintenanceRunId);

  /// Unlink service
  Future<void> unlinkServiceFromEnvGroup({required String envGroupId, required String serviceId}) =>
      raw.envGroups.unlinkServiceFromEnvGroup(envGroupId: envGroupId, serviceId: serviceId);

  /// Update Blueprint
  Future<UpdateBlueprintResponse> updateBlueprint({required String blueprintId, required Map<String, Object?> body}) =>
      raw.blueprints.updateBlueprint(blueprintId: blueprintId, body: body);

  /// Update dedicated IP set
  Future<DedicatedIp> updateDedicatedIp({required String dedicatedIpId, required Map<String, Object?> body}) =>
      raw.dedicatedIps.updateDedicatedIp(dedicatedIpId: dedicatedIpId, body: body);

  /// Update disk
  Future<UpdateDiskResponse> updateDisk({required String diskId, required Map<String, Object?> body}) =>
      raw.disks.updateDisk(diskId: diskId, body: body);

  /// Update environment group
  Future<Map<String, Object?>> updateEnvGroup({required String envGroupId, required Map<String, Object?> body}) =>
      raw.envGroups.updateEnvGroup(envGroupId: envGroupId, body: body);

  /// Add or update environment variable
  Future<Map<String, Object?>> updateEnvGroupEnvVar({required String envGroupId, required String envVarKey, required Map<String, Object?> body}) =>
      raw.envGroups.updateEnvGroupEnvVar(envGroupId: envGroupId, envVarKey: envVarKey, body: body);

  /// Add or update secret file
  Future<Map<String, Object?>> updateEnvGroupSecretFile({required String envGroupId, required String envVarKey, required Map<String, Object?> body}) =>
      raw.envGroups.updateEnvGroupSecretFile(envGroupId: envGroupId, envVarKey: envVarKey, body: body);

  /// Add or update environment variable
  Future<EnvVar> updateEnvVar({required String serviceId, required String envVarKey, required Map<String, Object?> body}) =>
      raw.services.updateEnvVar(serviceId: serviceId, envVarKey: envVarKey, body: body);

  /// Update environment variables
  Future<List<EnvVarWithCursor>> updateEnvVarsForService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.updateEnvVarsForService(serviceId: serviceId, body: body);

  /// Update environment
  Future<Environment> updateEnvironment({required String environmentId, required Map<String, Object?> body}) =>
      raw.environments.updateEnvironment(environmentId: environmentId, body: body);

  /// Replace header rules
  Future<List<Header>> updateHeaders({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.updateHeaders(serviceId: serviceId, body: body);

  /// Update Key Value instance
  Future<KeyValueDetail> updateKeyValue({required String redisId, required Map<String, Object?> body}) =>
      raw.keyValue.updateKeyValue(redisId: redisId, body: body);

  /// Update maintenance run
  Future<void> updateMaintenance({required String maintenanceRunId, required Map<String, Object?> body}) =>
      raw.maintenance.updateMaintenance(maintenanceRunId: maintenanceRunId, body: body);

  /// Update log stream
  Future<UpdateOwnerLogStreamResponse> updateOwnerLogStream({required String ownerId, required Map<String, Object?> body}) =>
      raw.logs.updateOwnerLogStream(ownerId: ownerId, body: body);

  /// Update Postgres instance
  Future<PostgresDetail> updatePostgres({required String postgresId, required Map<String, Object?> body}) =>
      raw.postgres.updatePostgres(postgresId: postgresId, body: body);

  /// Update project
  Future<Project> updateProject({required String projectId, required Map<String, Object?> body}) =>
      raw.projects.updateProject(projectId: projectId, body: body);

  /// Update Redis instance
  Future<RedisDetail> updateRedis({required String redisId, required Map<String, Object?> body}) =>
      raw.redis.updateRedis(redisId: redisId, body: body);

  /// Update registry credential
  Future<RegistryCredential> updateRegistryCredential({required String registryCredentialId, required Map<String, Object?> body}) =>
      raw.registrycredentials.updateRegistryCredential(registryCredentialId: registryCredentialId, body: body);

  /// Update log stream override
  Future<UpdateResourceLogStreamResponse> updateResourceLogStream({required String resourceId, required Map<String, Object?> body}) =>
      raw.logs.updateResourceLogStream(resourceId: resourceId, body: body);

  /// Update secret files
  Future<List<SecretFileWithCursor>> updateSecretFilesForService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.updateSecretFilesForService(serviceId: serviceId, body: body);

  /// Update service
  Future<Service> updateService({required String serviceId, required Map<String, Object?> body}) =>
      raw.services.updateService(serviceId: serviceId, body: body);

  /// Update a webhook
  Future<UpdateWebhookResponse> updateWebhook({required String webhookId, required Map<String, Object?> body}) =>
      raw.webhooks.updateWebhook(webhookId: webhookId, body: body);

  /// Update workflow
  Future<UpdateWorkflowResponse> updateWorkflow({required String workflowId, required Map<String, Object?> body}) =>
      raw.workflows.updateWorkflow(workflowId: workflowId, body: body);

  /// Update workspace member role
  Future<TeamMember> updateWorkspaceMember({required String ownerId, required String userId, required Map<String, Object?> body}) =>
      raw.owners.updateWorkspaceMember(ownerId: ownerId, userId: userId, body: body);

  /// Create or update metrics stream
  Future<UpsertOwnerMetricsStreamResponse> upsertOwnerMetricsStream({required String ownerId, required Map<String, Object?> body}) =>
      raw.metricsStream.upsertOwnerMetricsStream(ownerId: ownerId, body: body);

  /// Validate Blueprint
  Future<ValidateBlueprintResponse> validateBlueprint() =>
      raw.blueprints.validateBlueprint();

}
