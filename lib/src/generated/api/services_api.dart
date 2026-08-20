// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/services` endpoints.
class ServicesEndpoints {
  const ServicesEndpoints(this._client);

  final RenderApiClient _client;

  /// List services
  ///
  /// List services matching the provided filters. If no filters are provided, returns all services you have permissions to view.
  ///
  /// [name] Filter by name
  ///
  /// [type] Filter for types of services
  ///
  /// [environmentId] Filter for resources that belong to an environment
  ///
  /// [env] Filter for environments (runtimes) of services (deprecated; use `runtime` instead)
  ///
  /// [region] Filter by resource region
  ///
  /// [suspended] Filter resources based on whether they're suspended or not suspended
  ///
  /// [createdBefore] Filter for resources created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for resources created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedBefore] Filter for resources updated before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedAfter] Filter for resources updated after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [includePreviews] Include previews in the response
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<ServiceWithCursor>> listServices({List<String>? name, List<String>? type, List<String>? environmentId, List<String>? env, List<String>? region, List<String>? suspended, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, bool? includePreviews, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services',
      query: {
        'name': name,
        'type': type,
        'environmentId': environmentId,
        'env': env,
        'region': region,
        'suspended': suspended,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'ownerId': ownerId,
        'includePreviews': includePreviews,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(ServiceWithCursor.fromJson).toList();
  }


  /// Create service
  ///
  /// Creates a new Render service in the specified workspace with the specified configuration.
  Future<ServiceAndDeploy> createService({required ServicePost body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services',
      body: body.toJson(),
    );
    return ServiceAndDeploy.fromJson(json);
  }


  /// Retrieve service
  ///
  /// Retrieve the service with the provided ID.
  Future<Service> retrieveService({required String serviceId}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId',
    );
    return Service.fromJson(json);
  }


  /// Update service
  ///
  /// Update the service with the provided ID.
  Future<Service> updateService({required String serviceId, required ServicePatch body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/services/$serviceId',
      body: body.toJson(),
    );
    return Service.fromJson(json);
  }


  /// Delete service
  ///
  /// Delete the service with the provided ID.
  Future<void> deleteService({required String serviceId}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId',
    );
  }


  /// Purge Web Service Cache
  ///
  /// Trigger cache purge for the web service if caching is enabled.
  Future<void> purgeCache({required String serviceId}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/cache/purge',
    );
  }


  /// List deploys
  ///
  /// List deploys matching the provided filters. If no filters are provided, all deploys for the service are returned.
  ///
  /// [status] Filter for deploys with the specified statuses
  ///
  /// [createdBefore] Filter for deploys created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for deploys created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedBefore] Filter for deploys updated before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedAfter] Filter for deploys updated after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [finishedBefore] Filter for deploys finished before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [finishedAfter] Filter for deploys finished after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<DeployWithCursor>> listDeploys({required String serviceId, List<String>? status, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, String? finishedBefore, String? finishedAfter, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/deploys',
      query: {
        'status': status,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'finishedBefore': finishedBefore,
        'finishedAfter': finishedAfter,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(DeployWithCursor.fromJson).toList();
  }


  /// Trigger deploy
  ///
  /// Trigger a deploy for the service with the provided ID.
  Future<Deploy> createDeploy({required String serviceId, required CreateDeployRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/deploys',
      body: body.toJson(),
    );
    return Deploy.fromJson(json);
  }


  /// Retrieve deploy
  ///
  /// Retrieve the details of a particular deploy for a particular service.
  Future<Deploy> retrieveDeploy({required String serviceId, required String deployId}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/deploys/$deployId',
    );
    return Deploy.fromJson(json);
  }


  /// Cancel deploy
  ///
  /// Cancel an in-progress deploy for a service.
  ///
  /// Not supported for cron jobs.
  Future<Deploy> cancelDeploy({required String serviceId, required String deployId}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/deploys/$deployId/cancel',
    );
    return Deploy.fromJson(json);
  }


  /// Roll back deploy
  ///
  /// Trigger a rollback to a previous deploy of the specified service.
  ///
  /// Triggering a rollback with this endpoint does not disable autodeploys for the service. This means an autodeploy might restore changes you had intentionally rolled back.
  ///
  /// You can toggle autodeploys for your service with the [Update service](https://api-docs.render.com/reference/update-service) endpoint or in the Render Dashboard.
  Future<Deploy> rollbackDeploy({required String serviceId, required RollbackDeployRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/rollback',
      body: body.toJson(),
    );
    return Deploy.fromJson(json);
  }


  /// List environment variables
  ///
  /// List all environment variables for the service with the provided ID.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<EnvVarWithCursor>> getEnvVarsForService({required String serviceId, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/env-vars',
      query: {
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(EnvVarWithCursor.fromJson).toList();
  }


  /// Update environment variables
  ///
  /// Replace all environment variables for a service with the provided list of environment variables.
  Future<List<EnvVarWithCursor>> updateEnvVarsForService({required String serviceId, required List<UpdateEnvVarsForServiceRequestItem> body}) async {
    final json = await _client.sendList(
      'PUT',
      '/services/$serviceId/env-vars',
      body: body.map((e) => e.toJson()).toList(),
    );
    return json.whereType<Map<String, Object?>>().map(EnvVarWithCursor.fromJson).toList();
  }


  /// Retrieve environment variable
  ///
  /// Retrieve a particular environment variable for a particular service.
  ///
  /// This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.
  Future<EnvVar> retrieveEnvVar({required String serviceId, required String envVarKey}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/env-vars/$envVarKey',
    );
    return EnvVar.fromJson(json);
  }


  /// Add or update environment variable
  ///
  /// Add or update a particular environment variable for a particular service.
  ///
  /// This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.
  Future<EnvVar> updateEnvVar({required String serviceId, required String envVarKey, required AddUpdateEnvVarInput body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/services/$serviceId/env-vars/$envVarKey',
      body: body.toJson(),
    );
    return EnvVar.fromJson(json);
  }


  /// Delete environment variable
  ///
  /// Delete a particular environment variable from a particular service.
  ///
  /// This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.
  Future<void> deleteEnvVar({required String serviceId, required String envVarKey}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/env-vars/$envVarKey',
    );
  }


  /// List secret files
  ///
  /// List all secret files for the service with the provided ID.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<SecretFileWithCursor>> listSecretFilesForService({required String serviceId, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/secret-files',
      query: {
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(SecretFileWithCursor.fromJson).toList();
  }


  /// Update secret files
  ///
  /// Replace all secret files for a service with the provided list of secret files.
  ///
  /// **Any of the service's existing secret files not included in this request will be deleted.**
  ///
  /// This only applies to secret files set directly on the service, not to secret files in a linked environment group.
  Future<List<SecretFileWithCursor>> updateSecretFilesForService({required String serviceId, required List<UpdateSecretFilesForServiceRequestItem> body}) async {
    final json = await _client.sendList(
      'PUT',
      '/services/$serviceId/secret-files',
      body: body.map((e) => e.toJson()).toList(),
    );
    return json.whereType<Map<String, Object?>>().map(SecretFileWithCursor.fromJson).toList();
  }


  /// Retrieve secret file
  ///
  /// Retrieve a particular secret file for a particular service.
  ///
  /// This only applies to secret files set directly on the service, not to secret files in a linked environment group.
  Future<SecretFile> retrieveSecretFile({required String serviceId, required String envVarKey}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/secret-files/$envVarKey',
    );
    return SecretFile.fromJson(json);
  }


  /// Add or update secret file
  ///
  /// Add or update a particular secret file for a particular service.
  ///
  /// This only applies to secret files set directly on the service, not to secret files in a linked environment group.
  Future<SecretFile> addOrUpdateSecretFile({required String serviceId, required String envVarKey, required AddOrUpdateSecretFileRequest body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/services/$serviceId/secret-files/$envVarKey',
      body: body.toJson(),
    );
    return SecretFile.fromJson(json);
  }


  /// Delete secret file
  ///
  /// Delete a particular secret file from a particular service.
  ///
  /// This only applies to secret files set directly on the service, not to secret files in a linked environment group.
  Future<void> deleteSecretFile({required String serviceId, required String envVarKey}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/secret-files/$envVarKey',
    );
  }


  /// List events
  ///
  /// List recent events that occurred for the service with the provided ID.
  ///
  /// [type] The type of event to filter to
  ///
  /// [startTime] Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`.
  ///
  /// [endTime] Epoch/Unix timestamp of end of time range to return. Defaults to `now()`.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<ServiceEventWithCursor>> listEvents({required String serviceId, Object? type, String? startTime, String? endTime, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/events',
      query: {
        'type': type,
        'startTime': startTime,
        'endTime': endTime,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(ServiceEventWithCursor.fromJson).toList();
  }


  /// List header rules
  ///
  /// List a particular service's response header rules that match the provided filters. If no filters are provided, all rules for the service are returned.
  ///
  /// [path] Filter for specific paths that headers apply to
  ///
  /// [name] Filter for header names
  ///
  /// [value] Filter for header values
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<HeaderWithCursor>> listHeaders({required String serviceId, List<String>? path, List<String>? name, List<String>? value, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/headers',
      query: {
        'path': path,
        'name': name,
        'value': value,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(HeaderWithCursor.fromJson).toList();
  }


  /// Add header rule
  ///
  /// Add a response header rule to the service with the provided ID.
  Future<AddHeadersResponse> addHeaders({required String serviceId, required HeaderInput body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/headers',
      body: body.toJson(),
    );
    return AddHeadersResponse.fromJson(json);
  }


  /// Replace header rules
  ///
  /// Replace all header rules for a particular service with the provided list.
  ///
  /// **This deletes all existing header rules for the service that aren't included in the request.**
  Future<List<Header>> updateHeaders({required String serviceId, required List<HeaderInput> body}) async {
    final json = await _client.sendList(
      'PUT',
      '/services/$serviceId/headers',
      body: body.map((e) => e.toJson()).toList(),
    );
    return json.whereType<Map<String, Object?>>().map(Header.fromJson).toList();
  }


  /// Delete header rule
  ///
  /// Delete a particular response header rule for a particular service.
  Future<void> deleteHeader({required String serviceId, required String headerId}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/headers/$headerId',
    );
  }


  /// List redirect/rewrite rules
  ///
  /// List a particular service's redirect/rewrite rules that match the provided filters. If no filters are provided, all rules for the service are returned.
  ///
  /// [type] Filter for the type of route rule
  ///
  /// [source] Filter for the source path of the route
  ///
  /// [destination] Filter for the destination path of the route
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<RouteWithCursor>> listRoutes({required String serviceId, List<String>? type, List<String>? source, List<String>? destination, String? cursor, int? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/routes',
      query: {
        'type': type,
        'source': source,
        'destination': destination,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(RouteWithCursor.fromJson).toList();
  }


  /// Add redirect/rewrite rules
  ///
  /// Add redirect/rewrite rules to the service with the provided ID.
  Future<Route> addRoute({required String serviceId, required RoutePost body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/routes',
      body: body.toJson(),
    );
    return Route.fromJson(json);
  }


  /// Update redirect/rewrite rules
  ///
  /// Replace all redirect/rewrite rules for a particular service with the provided list.
  ///
  /// **This deletes all existing redirect/rewrite rules for the service that aren't included in the request.**
  ///
  /// Rule priority is assigned according to list order (the first rule in the list has the highest priority).
  Future<List<Route>> putRoutes({required String serviceId, required List<RoutePut> body}) async {
    final json = await _client.sendList(
      'PUT',
      '/services/$serviceId/routes',
      body: body.map((e) => e.toJson()).toList(),
    );
    return json.whereType<Map<String, Object?>>().map(Route.fromJson).toList();
  }


  /// Update redirect/rewrite rule priority
  ///
  /// Update the priority for a particular redirect/rewrite rule.
  ///
  /// To apply redirect/rewrite rules to an incoming request, Render starts from the rule with priority `0` and applies the first encountered rule that matches the request's path (if any).
  ///
  /// Render increments the priority of other rules by `1` as necessary to make space for the updated rule.
  Future<PatchRouteResponse> patchRoute({required String serviceId, required String routeId, required RoutePatch body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/services/$serviceId/routes/$routeId',
      body: body.toJson(),
    );
    return PatchRouteResponse.fromJson(json);
  }


  /// Delete redirect/rewrite rule
  ///
  /// Delete a particular redirect/rewrite rule for a particular service.
  Future<void> deleteRoute({required String serviceId, required String routeId}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/routes/$routeId',
    );
  }


  /// List custom domains
  ///
  /// List a particular service's custom domains that match the provided filters. If no filters are provided, all custom domains for the service are returned.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [name] Filter for the names of custom domain
  ///
  /// [domainType] Filter for domain type
  ///
  /// [verificationStatus] Filter for domain verification status (`verified` or `unverified`)
  ///
  /// [createdBefore] Filter for custom domains created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for custom domains created after a certain time (specified as an ISO 8601 timestamp)
  Future<List<CustomDomainWithCursor>> listCustomDomains({required String serviceId, String? cursor, int? limit, List<String>? name, String? domainType, String? verificationStatus, String? createdBefore, String? createdAfter}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/custom-domains',
      query: {
        'cursor': cursor,
        'limit': limit,
        'name': name,
        'domainType': domainType,
        'verificationStatus': verificationStatus,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
      },
    );
    return json.whereType<Map<String, Object?>>().map(CustomDomainWithCursor.fromJson).toList();
  }


  /// Add custom domain
  ///
  /// Add a custom domain to the service with the provided ID.
  Future<List<CustomDomain>> createCustomDomain({required String serviceId, required CreateCustomDomainRequest body}) async {
    final json = await _client.sendList(
      'POST',
      '/services/$serviceId/custom-domains',
      body: body.toJson(),
    );
    return json.whereType<Map<String, Object?>>().map(CustomDomain.fromJson).toList();
  }


  /// Retrieve custom domain
  ///
  /// Retrieve a particular custom domain for a particular service.
  Future<CustomDomain> retrieveCustomDomain({required String serviceId, required String customDomainNameOrId}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/custom-domains/$customDomainNameOrId',
    );
    return CustomDomain.fromJson(json);
  }


  /// Delete custom domain
  ///
  /// Delete a custom domain for a service given the service id and custom domain id or name.
  Future<void> deleteCustomDomain({required String serviceId, required String customDomainNameOrId}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/custom-domains/$customDomainNameOrId',
    );
  }


  /// Verify DNS configuration
  ///
  /// Verify the DNS configuration for a custom domain.
  Future<void> refreshCustomDomain({required String serviceId, required String customDomainNameOrId}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/custom-domains/$customDomainNameOrId/verify',
    );
  }


  /// Suspend service
  ///
  /// Suspend the service with the provided ID.
  Future<void> suspendService({required String serviceId}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/suspend',
    );
  }


  /// Resume service
  ///
  /// Resume the service with the provided ID (if it's currently suspended).
  Future<void> resumeService({required String serviceId}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/resume',
    );
  }


  /// Restart service
  ///
  /// Restart the service with the provided ID.
  ///
  /// Not supported for cron jobs.
  Future<void> restartService({required String serviceId}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/restart',
    );
  }


  /// Scale instance count
  ///
  /// [Scale](https://render.com/docs/scaling#manual-scaling) the service with the provided ID to a fixed number of instances.
  ///
  /// Render ignores this value as long as autoscaling is enabled for the service.
  Future<void> scaleService({required String serviceId, required ScaleServiceRequest body}) async {
    await _client.send(
      'POST',
      '/services/$serviceId/scale',
      body: body.toJson(),
    );
  }


  /// Update autoscaling config
  ///
  /// Update the [autoscaling](https://render.com/docs/scaling#autoscaling) config for the service with the provided ID.
  Future<AutoscaleServiceResponse> autoscaleService({required String serviceId, required AutoscaleServiceRequest body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/services/$serviceId/autoscaling',
      body: body.toJson(),
    );
    return AutoscaleServiceResponse.fromJson(json);
  }


  /// Delete autoscaling config
  ///
  /// Delete the autoscaling config for a service given the service id.
  Future<void> deleteAutoscalingConfig({required String serviceId}) async {
    await _client.send(
      'DELETE',
      '/services/$serviceId/autoscaling',
    );
  }


  /// Create service preview (image-backed)
  ///
  /// Create a preview instance for an image-backed service. The preview uses the settings of the base service (referenced by `serviceId`), except settings overridden via provided parameters.
  ///
  /// View all active previews from your service's Previews tab in the Render Dashboard.
  ///
  /// Note that you can't create previews for Git-backed services using the Render API.
  Future<ServiceAndDeploy> previewService({required String serviceId, required PreviewInput body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/preview',
      body: body.toJson(),
    );
    return ServiceAndDeploy.fromJson(json);
  }


  /// List jobs
  ///
  /// List jobs for the provided service that match the provided filters. If no filters are provided, all jobs for the service are returned.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [status] Filter for the status of the job (`pending`, `running`, `succeeded`, `failed`, or `canceled`)
  ///
  /// [createdBefore] Filter for jobs created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for jobs created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [startedBefore] Filter for jobs started before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [startedAfter] Filter for jobs started after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [finishedBefore] Filter for jobs finished before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [finishedAfter] Filter for jobs finished after a certain time (specified as an ISO 8601 timestamp)
  Future<List<JobWithCursor>> listJob({required String serviceId, String? cursor, int? limit, List<String>? status, String? createdBefore, String? createdAfter, String? startedBefore, String? startedAfter, String? finishedBefore, String? finishedAfter}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/jobs',
      query: {
        'cursor': cursor,
        'limit': limit,
        'status': status,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'startedBefore': startedBefore,
        'startedAfter': startedAfter,
        'finishedBefore': finishedBefore,
        'finishedAfter': finishedAfter,
      },
    );
    return json.whereType<Map<String, Object?>>().map(JobWithCursor.fromJson).toList();
  }


  /// Create job
  ///
  /// Create a one-off job using the provided service. For details, see [One-Off Jobs](https://render.com/docs/one-off-jobs).
  Future<PostJobResponse> postJob({required String serviceId, required PostJobRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/jobs',
      body: body.toJson(),
    );
    return PostJobResponse.fromJson(json);
  }


  /// Retrieve job
  ///
  /// Retrieve the details of a particular one-off job for a particular service.
  Future<RetrieveJobResponse> retrieveJob({required String serviceId, required String jobId}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/jobs/$jobId',
    );
    return RetrieveJobResponse.fromJson(json);
  }


  /// Cancel running job
  ///
  /// Cancel a particular one-off job for a particular service.
  Future<CancelJobResponse> cancelJob({required String serviceId, required String jobId}) async {
    final json = await _client.sendObject(
      'POST',
      '/services/$serviceId/jobs/$jobId/cancel',
    );
    return CancelJobResponse.fromJson(json);
  }


  /// List instances
  ///
  /// List instances for the provided service.
  Future<List<ServiceInstance>> listInstances({required String serviceId}) async {
    final json = await _client.sendList(
      'GET',
      '/services/$serviceId/instances',
    );
    return json.whereType<Map<String, Object?>>().map(ServiceInstance.fromJson).toList();
  }


  /// Retrieve service outbound IPs
  ///
  /// Retrieve the IP addresses the service's outbound traffic originates from.
  ///
  /// A service uses either a dedicated IP set that applies to it, or the shared Render IPs for its region.
  Future<OutboundIps> retrieveServiceOutboundIps({required String serviceId}) async {
    final json = await _client.sendObject(
      'GET',
      '/services/$serviceId/outbound-ips',
    );
    return OutboundIps.fromJson(json);
  }


}
