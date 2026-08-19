# Services

`render.raw.services` — 49 operations on `/services`.

| Method | | |
| --- | --- | --- |
| [`addHeaders`](#addheaders) | `POST /services/{serviceId}/headers` | Add header rule |
| [`addOrUpdateSecretFile`](#addorupdatesecretfile) | `PUT /services/{serviceId}/secret-files/{envVarKey}` | Add or update secret file |
| [`addRoute`](#addroute) | `POST /services/{serviceId}/routes` | Add redirect/rewrite rules |
| [`autoscaleService`](#autoscaleservice) | `PUT /services/{serviceId}/autoscaling` | Update autoscaling config |
| [`cancelDeploy`](#canceldeploy) | `POST /services/{serviceId}/deploys/{deployId}/cancel` | Cancel deploy |
| [`cancelJob`](#canceljob) | `POST /services/{serviceId}/jobs/{jobId}/cancel` | Cancel running job |
| [`createCustomDomain`](#createcustomdomain) | `POST /services/{serviceId}/custom-domains` | Add custom domain |
| [`createDeploy`](#createdeploy) | `POST /services/{serviceId}/deploys` | Trigger deploy |
| [`createService`](#createservice) | `POST /services` | Create service |
| [`deleteAutoscalingConfig`](#deleteautoscalingconfig) | `DELETE /services/{serviceId}/autoscaling` | Delete autoscaling config |
| [`deleteCustomDomain`](#deletecustomdomain) | `DELETE /services/{serviceId}/custom-domains/{customDomainNameOrID}` | Delete custom domain |
| [`deleteEnvVar`](#deleteenvvar) | `DELETE /services/{serviceId}/env-vars/{envVarKey}` | Delete environment variable |
| [`deleteHeader`](#deleteheader) | `DELETE /services/{serviceId}/headers/{headerId}` | Delete header rule |
| [`deleteRoute`](#deleteroute) | `DELETE /services/{serviceId}/routes/{routeId}` | Delete redirect/rewrite rule |
| [`deleteSecretFile`](#deletesecretfile) | `DELETE /services/{serviceId}/secret-files/{envVarKey}` | Delete secret file |
| [`deleteService`](#deleteservice) | `DELETE /services/{serviceId}` | Delete service |
| [`getEnvVarsForService`](#getenvvarsforservice) | `GET /services/{serviceId}/env-vars` | List environment variables |
| [`listCustomDomains`](#listcustomdomains) | `GET /services/{serviceId}/custom-domains` | List custom domains |
| [`listDeploys`](#listdeploys) | `GET /services/{serviceId}/deploys` | List deploys |
| [`listEvents`](#listevents) | `GET /services/{serviceId}/events` | List events |
| [`listHeaders`](#listheaders) | `GET /services/{serviceId}/headers` | List header rules |
| [`listInstances`](#listinstances) | `GET /services/{serviceId}/instances` | List instances |
| [`listJob`](#listjob) | `GET /services/{serviceId}/jobs` | List jobs |
| [`listRoutes`](#listroutes) | `GET /services/{serviceId}/routes` | List redirect/rewrite rules |
| [`listSecretFilesForService`](#listsecretfilesforservice) | `GET /services/{serviceId}/secret-files` | List secret files |
| [`listServices`](#listservices) | `GET /services` | List services |
| [`patchRoute`](#patchroute) | `PATCH /services/{serviceId}/routes/{routeId}` | Update redirect/rewrite rule priority |
| [`postJob`](#postjob) | `POST /services/{serviceId}/jobs` | Create job |
| [`previewService`](#previewservice) | `POST /services/{serviceId}/preview` | Create service preview (image-backed) |
| [`purgeCache`](#purgecache) | `POST /services/{serviceId}/cache/purge` | Purge Web Service Cache |
| [`putRoutes`](#putroutes) | `PUT /services/{serviceId}/routes` | Update redirect/rewrite rules |
| [`refreshCustomDomain`](#refreshcustomdomain) | `POST /services/{serviceId}/custom-domains/{customDomainNameOrID}/verify` | Verify DNS configuration |
| [`restartService`](#restartservice) | `POST /services/{serviceId}/restart` | Restart service |
| [`resumeService`](#resumeservice) | `POST /services/{serviceId}/resume` | Resume service |
| [`retrieveCustomDomain`](#retrievecustomdomain) | `GET /services/{serviceId}/custom-domains/{customDomainNameOrID}` | Retrieve custom domain |
| [`retrieveDeploy`](#retrievedeploy) | `GET /services/{serviceId}/deploys/{deployId}` | Retrieve deploy |
| [`retrieveEnvVar`](#retrieveenvvar) | `GET /services/{serviceId}/env-vars/{envVarKey}` | Retrieve environment variable |
| [`retrieveJob`](#retrievejob) | `GET /services/{serviceId}/jobs/{jobId}` | Retrieve job |
| [`retrieveSecretFile`](#retrievesecretfile) | `GET /services/{serviceId}/secret-files/{envVarKey}` | Retrieve secret file |
| [`retrieveService`](#retrieveservice) | `GET /services/{serviceId}` | Retrieve service |
| [`retrieveServiceOutboundIps`](#retrieveserviceoutboundips) | `GET /services/{serviceId}/outbound-ips` | Retrieve service outbound IPs |
| [`rollbackDeploy`](#rollbackdeploy) | `POST /services/{serviceId}/rollback` | Roll back deploy |
| [`scaleService`](#scaleservice) | `POST /services/{serviceId}/scale` | Scale instance count |
| [`suspendService`](#suspendservice) | `POST /services/{serviceId}/suspend` | Suspend service |
| [`updateEnvVar`](#updateenvvar) | `PUT /services/{serviceId}/env-vars/{envVarKey}` | Add or update environment variable |
| [`updateEnvVarsForService`](#updateenvvarsforservice) | `PUT /services/{serviceId}/env-vars` | Update environment variables |
| [`updateHeaders`](#updateheaders) | `PUT /services/{serviceId}/headers` | Replace header rules |
| [`updateSecretFilesForService`](#updatesecretfilesforservice) | `PUT /services/{serviceId}/secret-files` | Update secret files |
| [`updateService`](#updateservice) | `PATCH /services/{serviceId}` | Update service |

---

## addHeaders

**Add header rule**

Add a response header rule to the service with the provided ID.


```dart
Future<AddHeadersResponse> addHeaders({required String serviceId, required HeaderInput body})
```

`POST /services/{serviceId}/headers`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `HeaderInput` | body | yes |  |

Returns `AddHeadersResponse`.

| Field | Type | |
| --- | --- | --- |
| `headers` | `Header?` |  |

[Render documentation](https://api-docs.render.com/reference/add-headers)

## addOrUpdateSecretFile

**Add or update secret file**

Add or update a particular secret file for a particular service.

This only applies to secret files set directly on the service, not to secret files in a linked environment group.


```dart
Future<SecretFile> addOrUpdateSecretFile({required String serviceId, required String envVarKey, required AddOrUpdateSecretFileRequest body})
```

`PUT /services/{serviceId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |
| `body` | `AddOrUpdateSecretFileRequest` | body | yes |  |

Returns `SecretFile`.

| Field | Type | |
| --- | --- | --- |
| `name` | `String` |  |
| `content` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/add-or-update-secret-file)

## addRoute

**Add redirect/rewrite rules**

Add redirect/rewrite rules to the service with the provided ID.


```dart
Future<Route> addRoute({required String serviceId, required RoutePost body})
```

`POST /services/{serviceId}/routes`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `RoutePost` | body | yes |  |

Returns `Route`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `type` | `RouteType` |  |
| `source` | `String` |  |
| `destination` | `String` |  |
| `priority` | `int` | Redirect and Rewrite Rules are applied in priority order starting at 0 |

[Render documentation](https://api-docs.render.com/reference/add-route)

## autoscaleService

**Update autoscaling config**

Update the [autoscaling](https://render.com/docs/scaling#autoscaling) config for the service with the provided ID.


```dart
Future<AutoscaleServiceResponse> autoscaleService({required String serviceId, required AutoscaleServiceRequest body})
```

`PUT /services/{serviceId}/autoscaling`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `AutoscaleServiceRequest` | body | yes |  |

Returns `AutoscaleServiceResponse`.

| Field | Type | |
| --- | --- | --- |
| `enabled` | `bool` |  |
| `min` | `int` | The minimum number of instances for the service |
| `max` | `int` | The maximum number of instances for the service |
| `criteria` | `AutoscaleServiceResponseCriteria` |  |

[Render documentation](https://api-docs.render.com/reference/autoscale-service)

## cancelDeploy

**Cancel deploy**

Cancel an in-progress deploy for a service.

Not supported for cron jobs.


```dart
Future<Deploy> cancelDeploy({required String serviceId, required String deployId})
```

`POST /services/{serviceId}/deploys/{deployId}/cancel`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `deployId` | `String` | path | yes |  |

Returns `Deploy`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `commit` | `DeployCommit?` |  |
| `image` | `DeployImage?` | Image information used when creating the deploy. Not present for Git-backed deploys |
| `status` | `DeployStatus?` |  |
| `trigger` | `Trigger?` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |
| `createdAt` | `DateTime?` |  |
| `updatedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/cancel-deploy)

## cancelJob

**Cancel running job**

Cancel a particular one-off job for a particular service.


```dart
Future<CancelJobResponse> cancelJob({required String serviceId, required String jobId})
```

`POST /services/{serviceId}/jobs/{jobId}/cancel`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `jobId` | `String` | path | yes |  |

Returns `CancelJobResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `serviceId` | `String` |  |
| `startCommand` | `String` |  |
| `planId` | `String` |  |
| `status` | `JobWithCursorJobStatus?` |  |
| `createdAt` | `DateTime` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/cancel-job)

## createCustomDomain

**Add custom domain**

Add a custom domain to the service with the provided ID.


```dart
Future<List<CustomDomain>> createCustomDomain({required String serviceId, required CreateCustomDomainRequest body})
```

`POST /services/{serviceId}/custom-domains`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `CreateCustomDomainRequest` | body | yes |  |

Returns `List<CustomDomain>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `domainType` | `DomainType` |  |
| `publicSuffix` | `String` |  |
| `redirectForName` | `String` |  |
| `verificationStatus` | `VerificationStatus` |  |
| `createdAt` | `DateTime` |  |
| `server` | `CustomDomainServer?` |  |

[Render documentation](https://api-docs.render.com/reference/create-custom-domain)

## createDeploy

**Trigger deploy**

Trigger a deploy for the service with the provided ID.


```dart
Future<Deploy> createDeploy({required String serviceId, required CreateDeployRequest body})
```

`POST /services/{serviceId}/deploys`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `CreateDeployRequest` | body | yes |  |

Returns `Deploy`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `commit` | `DeployCommit?` |  |
| `image` | `DeployImage?` | Image information used when creating the deploy. Not present for Git-backed deploys |
| `status` | `DeployStatus?` |  |
| `trigger` | `Trigger?` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |
| `createdAt` | `DateTime?` |  |
| `updatedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/create-deploy)

## createService

**Create service**

Creates a new Render service in the specified workspace with the specified configuration.


```dart
Future<ServiceAndDeploy> createService({required ServicePost body})
```

`POST /services`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `ServicePost` | body | yes |  |

Returns `ServiceAndDeploy`.

| Field | Type | |
| --- | --- | --- |
| `service` | `Service?` |  |
| `deployId` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/create-service)

## deleteAutoscalingConfig

**Delete autoscaling config**

Delete the autoscaling config for a service given the service id.


```dart
Future<void> deleteAutoscalingConfig({required String serviceId})
```

`DELETE /services/{serviceId}/autoscaling`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-autoscaling-config)

## deleteCustomDomain

**Delete custom domain**

Delete a custom domain for a service given the service id and custom domain id or name.


```dart
Future<void> deleteCustomDomain({required String serviceId, required String customDomainNameOrId})
```

`DELETE /services/{serviceId}/custom-domains/{customDomainNameOrID}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `customDomainNameOrId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-custom-domain)

## deleteEnvVar

**Delete environment variable**

Delete a particular environment variable from a particular service.

This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.


```dart
Future<void> deleteEnvVar({required String serviceId, required String envVarKey})
```

`DELETE /services/{serviceId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-env-var)

## deleteHeader

**Delete header rule**

Delete a particular response header rule for a particular service.


```dart
Future<void> deleteHeader({required String serviceId, required String headerId})
```

`DELETE /services/{serviceId}/headers/{headerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `headerId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-header)

## deleteRoute

**Delete redirect/rewrite rule**

Delete a particular redirect/rewrite rule for a particular service.


```dart
Future<void> deleteRoute({required String serviceId, required String routeId})
```

`DELETE /services/{serviceId}/routes/{routeId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `routeId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-route)

## deleteSecretFile

**Delete secret file**

Delete a particular secret file from a particular service.

This only applies to secret files set directly on the service, not to secret files in a linked environment group.


```dart
Future<void> deleteSecretFile({required String serviceId, required String envVarKey})
```

`DELETE /services/{serviceId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-secret-file)

## deleteService

**Delete service**

Delete the service with the provided ID.


```dart
Future<void> deleteService({required String serviceId})
```

`DELETE /services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-service)

## getEnvVarsForService

**List environment variables**

List all environment variables for the service with the provided ID.


```dart
Future<List<EnvVarWithCursor>> getEnvVarsForService({required String serviceId, String? cursor, int? limit})
```

`GET /services/{serviceId}/env-vars`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<EnvVarWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `envVar` | `EnvVar` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-env-vars-for-service)

## listCustomDomains

**List custom domains**

List a particular service's custom domains that match the provided filters. If no filters are provided, all custom domains for the service are returned.


```dart
Future<List<CustomDomainWithCursor>> listCustomDomains({required String serviceId, String? cursor, int? limit, List<String>? name, String? domainType, String? verificationStatus, String? createdBefore, String? createdAfter})
```

`GET /services/{serviceId}/custom-domains`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `name` | `List<String>` | query | no | Filter for the names of custom domain |
| `domainType` | `String` | query | no | Filter for domain type |
| `verificationStatus` | `String` | query | no | Filter for domain verification status (`verified` or `unverified`) |
| `createdBefore` | `String` | query | no | Filter for custom domains created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for custom domains created after a certain time (specified as an ISO 8601 timestamp) |

Returns `List<CustomDomainWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `customDomain` | `CustomDomain` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-custom-domains)

## listDeploys

**List deploys**

List deploys matching the provided filters. If no filters are provided, all deploys for the service are returned.


```dart
Future<List<DeployWithCursor>> listDeploys({required String serviceId, List<String>? status, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, String? finishedBefore, String? finishedAfter, String? cursor, int? limit})
```

`GET /services/{serviceId}/deploys`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `status` | `List<String>` | query | no | Filter for deploys with the specified statuses |
| `createdBefore` | `String` | query | no | Filter for deploys created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for deploys created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for deploys updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for deploys updated after a certain time (specified as an ISO 8601 timestamp) |
| `finishedBefore` | `String` | query | no | Filter for deploys finished before a certain time (specified as an ISO 8601 timestamp) |
| `finishedAfter` | `String` | query | no | Filter for deploys finished after a certain time (specified as an ISO 8601 timestamp) |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<DeployWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `deploy` | `Deploy?` |  |
| `cursor` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/list-deploys)

## listEvents

**List events**

List recent events that occurred for the service with the provided ID.

```dart
Future<List<ServiceEventWithCursor>> listEvents({required String serviceId, Object? type, String? startTime, String? endTime, String? cursor, int? limit})
```

`GET /services/{serviceId}/events`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `type` | `Object` | query | no | The type of event to filter to |
| `startTime` | `String` | query | no | Epoch/Unix timestamp of start of time range to return. Defaults to `now() - 1 hour`. |
| `endTime` | `String` | query | no | Epoch/Unix timestamp of end of time range to return. Defaults to `now()`. |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<ServiceEventWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `event` | `ServiceEventWithCursorEvent` |  |

[Render documentation](https://api-docs.render.com/reference/list-events)

## listHeaders

**List header rules**

List a particular service's response header rules that match the provided filters. If no filters are provided, all rules for the service are returned.


```dart
Future<List<HeaderWithCursor>> listHeaders({required String serviceId, List<String>? path, List<String>? name, List<String>? value, String? cursor, int? limit})
```

`GET /services/{serviceId}/headers`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `path` | `List<String>` | query | no | Filter for specific paths that headers apply to |
| `name` | `List<String>` | query | no | Filter for header names |
| `value` | `List<String>` | query | no | Filter for header values |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<HeaderWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `header` | `Header` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-headers)

## listInstances

**List instances**

List instances for the provided service.

```dart
Future<List<ServiceInstance>> listInstances({required String serviceId})
```

`GET /services/{serviceId}/instances`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `List<ServiceInstance>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `createdAt` | `DateTime` |  |

[Render documentation](https://api-docs.render.com/reference/list-instances)

## listJob

**List jobs**

List jobs for the provided service that match the provided filters. If no filters are provided, all jobs for the service are returned.


```dart
Future<List<JobWithCursor>> listJob({required String serviceId, String? cursor, int? limit, List<String>? status, String? createdBefore, String? createdAfter, String? startedBefore, String? startedAfter, String? finishedBefore, String? finishedAfter})
```

`GET /services/{serviceId}/jobs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `status` | `List<String>` | query | no | Filter for the status of the job (`pending`, `running`, `succeeded`, `failed`, or `canceled`) |
| `createdBefore` | `String` | query | no | Filter for jobs created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for jobs created after a certain time (specified as an ISO 8601 timestamp) |
| `startedBefore` | `String` | query | no | Filter for jobs started before a certain time (specified as an ISO 8601 timestamp) |
| `startedAfter` | `String` | query | no | Filter for jobs started after a certain time (specified as an ISO 8601 timestamp) |
| `finishedBefore` | `String` | query | no | Filter for jobs finished before a certain time (specified as an ISO 8601 timestamp) |
| `finishedAfter` | `String` | query | no | Filter for jobs finished after a certain time (specified as an ISO 8601 timestamp) |

Returns `List<JobWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `job` | `JobWithCursorJob` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-job)

## listRoutes

**List redirect/rewrite rules**

List a particular service's redirect/rewrite rules that match the provided filters. If no filters are provided, all rules for the service are returned.


```dart
Future<List<RouteWithCursor>> listRoutes({required String serviceId, List<String>? type, List<String>? source, List<String>? destination, String? cursor, int? limit})
```

`GET /services/{serviceId}/routes`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `type` | `List<String>` | query | no | Filter for the type of route rule |
| `source` | `List<String>` | query | no | Filter for the source path of the route |
| `destination` | `List<String>` | query | no | Filter for the destination path of the route |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<RouteWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `route` | `Route` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-routes)

## listSecretFilesForService

**List secret files**

List all secret files for the service with the provided ID.


```dart
Future<List<SecretFileWithCursor>> listSecretFilesForService({required String serviceId, String? cursor, int? limit})
```

`GET /services/{serviceId}/secret-files`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<SecretFileWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `secretFile` | `SecretFile` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-secret-files-for-service)

## listServices

**List services**

List services matching the provided filters. If no filters are provided, returns all services you have permissions to view.


```dart
Future<List<ServiceWithCursor>> listServices({List<String>? name, List<String>? type, List<String>? environmentId, List<String>? env, List<String>? region, List<String>? suspended, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, bool? includePreviews, String? cursor, int? limit})
```

`GET /services`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `type` | `List<String>` | query | no | Filter for types of services |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `env` | `List<String>` | query | no | Filter for environments (runtimes) of services (deprecated; use `runtime` instead) |
| `region` | `List<String>` | query | no | Filter by resource region |
| `suspended` | `List<String>` | query | no | Filter resources based on whether they're suspended or not suspended |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `includePreviews` | `bool` | query | no | Include previews in the response |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<ServiceWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `service` | `Service` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-services)

## patchRoute

**Update redirect/rewrite rule priority**

Update the priority for a particular redirect/rewrite rule.

To apply redirect/rewrite rules to an incoming request, Render starts from the rule with priority `0` and applies the first encountered rule that matches the request's path (if any).

Render increments the priority of other rules by `1` as necessary to make space for the updated rule.


```dart
Future<PatchRouteResponse> patchRoute({required String serviceId, required String routeId, required RoutePatch body})
```

`PATCH /services/{serviceId}/routes/{routeId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `routeId` | `String` | path | yes |  |
| `body` | `RoutePatch` | body | yes |  |

Returns `PatchRouteResponse`.

| Field | Type | |
| --- | --- | --- |
| `headers` | `Route?` |  |

[Render documentation](https://api-docs.render.com/reference/patch-route)

## postJob

**Create job**

Create a one-off job using the provided service. For details, see [One-Off Jobs](https://render.com/docs/one-off-jobs).


```dart
Future<PostJobResponse> postJob({required String serviceId, required PostJobRequest body})
```

`POST /services/{serviceId}/jobs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `PostJobRequest` | body | yes |  |

Returns `PostJobResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `serviceId` | `String` |  |
| `startCommand` | `String` |  |
| `planId` | `String` |  |
| `status` | `JobWithCursorJobStatus?` |  |
| `createdAt` | `DateTime` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/post-job)

## previewService

**Create service preview (image-backed)**

Create a preview instance for an image-backed service. The preview uses the settings of the base service (referenced by `serviceId`), except settings overridden via provided parameters.

View all active previews from your service's Previews tab in the Render Dashboard.

Note that you can't create previews for Git-backed services using the Render API.


```dart
Future<ServiceAndDeploy> previewService({required String serviceId, required PreviewInput body})
```

`POST /services/{serviceId}/preview`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `PreviewInput` | body | yes |  |

Returns `ServiceAndDeploy`.

| Field | Type | |
| --- | --- | --- |
| `service` | `Service?` |  |
| `deployId` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/preview-service)

## purgeCache

**Purge Web Service Cache**

Trigger cache purge for the web service if caching is enabled.


```dart
Future<void> purgeCache({required String serviceId})
```

`POST /services/{serviceId}/cache/purge`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/purge-cache)

## putRoutes

**Update redirect/rewrite rules**

Replace all redirect/rewrite rules for a particular service with the provided list.

**This deletes all existing redirect/rewrite rules for the service that aren't included in the request.**

Rule priority is assigned according to list order (the first rule in the list has the highest priority).


```dart
Future<List<Route>> putRoutes({required String serviceId, required List<RoutePut> body})
```

`PUT /services/{serviceId}/routes`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `List<RoutePut>` | body | yes |  |

Returns `List<Route>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `type` | `RouteType` |  |
| `source` | `String` |  |
| `destination` | `String` |  |
| `priority` | `int` | Redirect and Rewrite Rules are applied in priority order starting at 0 |

[Render documentation](https://api-docs.render.com/reference/put-routes)

## refreshCustomDomain

**Verify DNS configuration**

Verify the DNS configuration for a custom domain.


```dart
Future<void> refreshCustomDomain({required String serviceId, required String customDomainNameOrId})
```

`POST /services/{serviceId}/custom-domains/{customDomainNameOrID}/verify`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `customDomainNameOrId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/refresh-custom-domain)

## restartService

**Restart service**

Restart the service with the provided ID.

Not supported for cron jobs.


```dart
Future<void> restartService({required String serviceId})
```

`POST /services/{serviceId}/restart`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/restart-service)

## resumeService

**Resume service**

Resume the service with the provided ID (if it's currently suspended).


```dart
Future<void> resumeService({required String serviceId})
```

`POST /services/{serviceId}/resume`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/resume-service)

## retrieveCustomDomain

**Retrieve custom domain**

Retrieve a particular custom domain for a particular service.


```dart
Future<CustomDomain> retrieveCustomDomain({required String serviceId, required String customDomainNameOrId})
```

`GET /services/{serviceId}/custom-domains/{customDomainNameOrID}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `customDomainNameOrId` | `String` | path | yes |  |

Returns `CustomDomain`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `domainType` | `DomainType` |  |
| `publicSuffix` | `String` |  |
| `redirectForName` | `String` |  |
| `verificationStatus` | `VerificationStatus` |  |
| `createdAt` | `DateTime` |  |
| `server` | `CustomDomainServer?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-custom-domain)

## retrieveDeploy

**Retrieve deploy**

Retrieve the details of a particular deploy for a particular service.


```dart
Future<Deploy> retrieveDeploy({required String serviceId, required String deployId})
```

`GET /services/{serviceId}/deploys/{deployId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `deployId` | `String` | path | yes |  |

Returns `Deploy`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `commit` | `DeployCommit?` |  |
| `image` | `DeployImage?` | Image information used when creating the deploy. Not present for Git-backed deploys |
| `status` | `DeployStatus?` |  |
| `trigger` | `Trigger?` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |
| `createdAt` | `DateTime?` |  |
| `updatedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-deploy)

## retrieveEnvVar

**Retrieve environment variable**

Retrieve a particular environment variable for a particular service.

This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.


```dart
Future<EnvVar> retrieveEnvVar({required String serviceId, required String envVarKey})
```

`GET /services/{serviceId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `EnvVar`.

| Field | Type | |
| --- | --- | --- |
| `key` | `String` |  |
| `value` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-env-var)

## retrieveJob

**Retrieve job**

Retrieve the details of a particular one-off job for a particular service.


```dart
Future<RetrieveJobResponse> retrieveJob({required String serviceId, required String jobId})
```

`GET /services/{serviceId}/jobs/{jobId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `jobId` | `String` | path | yes |  |

Returns `RetrieveJobResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `serviceId` | `String` |  |
| `startCommand` | `String` |  |
| `planId` | `String` |  |
| `status` | `JobWithCursorJobStatus?` |  |
| `createdAt` | `DateTime` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-job)

## retrieveSecretFile

**Retrieve secret file**

Retrieve a particular secret file for a particular service.

This only applies to secret files set directly on the service, not to secret files in a linked environment group.


```dart
Future<SecretFile> retrieveSecretFile({required String serviceId, required String envVarKey})
```

`GET /services/{serviceId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `SecretFile`.

| Field | Type | |
| --- | --- | --- |
| `name` | `String` |  |
| `content` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-secret-file)

## retrieveService

**Retrieve service**

Retrieve the service with the provided ID.


```dart
Future<Service> retrieveService({required String serviceId})
```

`GET /services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `Service`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `autoDeploy` | `AutoDeploy` |  |
| `branch` | `String?` |  |
| `buildFilter` | `BuildFilter?` |  |
| `createdAt` | `DateTime` |  |
| `dashboardUrl` | `String` | The URL to view the service in the Render Dashboard |
| `environmentId` | `String?` |  |
| `imagePath` | `String?` |  |
| `name` | `String` |  |
| `notifyOnFail` | `NotifySetting` |  |
| `ownerId` | `String` |  |
| `registryCredential` | `RegistryCredentialSummary?` |  |
| `repo` | `String?` |  |
| `rootDir` | `String` |  |
| `slug` | `String` |  |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `type` | `ServiceType` |  |
| `updatedAt` | `DateTime` |  |
| `serviceDetails` | `Object?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-service)

## retrieveServiceOutboundIps

**Retrieve service outbound IPs**

Retrieve the IP addresses the service's outbound traffic originates from.

A service uses either a dedicated IP set that applies to it, or the shared Render IPs for its region.


```dart
Future<OutboundIps> retrieveServiceOutboundIps({required String serviceId})
```

`GET /services/{serviceId}/outbound-ips`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `OutboundIps`.

| Field | Type | |
| --- | --- | --- |
| `type` | `OutboundIpsType` | `dedicated` if a dedicated IP set applies to the resource, `shared` if its traffic originates from the shared Render IPs for its region.  |
| `dedicatedIpId` | `String?` | The dedicated IP set the traffic originates from. Only present when `type` is `dedicated`. |
| `ips` | `List<String>` | The IP addresses the resource's outbound traffic originates from. |

[Render documentation](https://api-docs.render.com/reference/retrieve-service-outbound-ips)

## rollbackDeploy

**Roll back deploy**

Trigger a rollback to a previous deploy of the specified service.

Triggering a rollback with this endpoint does not disable autodeploys for the service. This means an autodeploy might restore changes you had intentionally rolled back.

You can toggle autodeploys for your service with the [Update service](https://api-docs.render.com/reference/update-service) endpoint or in the Render Dashboard.


```dart
Future<Deploy> rollbackDeploy({required String serviceId, required RollbackDeployRequest body})
```

`POST /services/{serviceId}/rollback`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `RollbackDeployRequest` | body | yes |  |

Returns `Deploy`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `commit` | `DeployCommit?` |  |
| `image` | `DeployImage?` | Image information used when creating the deploy. Not present for Git-backed deploys |
| `status` | `DeployStatus?` |  |
| `trigger` | `Trigger?` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |
| `createdAt` | `DateTime?` |  |
| `updatedAt` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/rollback-deploy)

## scaleService

**Scale instance count**

[Scale](https://render.com/docs/scaling#manual-scaling) the service with the provided ID to a fixed number of instances.

Render ignores this value as long as autoscaling is enabled for the service.


```dart
Future<void> scaleService({required String serviceId, required ScaleServiceRequest body})
```

`POST /services/{serviceId}/scale`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `ScaleServiceRequest` | body | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/scale-service)

## suspendService

**Suspend service**

Suspend the service with the provided ID.


```dart
Future<void> suspendService({required String serviceId})
```

`POST /services/{serviceId}/suspend`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/suspend-service)

## updateEnvVar

**Add or update environment variable**

Add or update a particular environment variable for a particular service.

This only applies to environment variables set directly on the service, not to environment variables in a linked environment group.


```dart
Future<EnvVar> updateEnvVar({required String serviceId, required String envVarKey, required Map<String, Object?> body})
```

`PUT /services/{serviceId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |
| `body` | `Map<String, Object?>` | body | yes |  |

Returns `EnvVar`.

| Field | Type | |
| --- | --- | --- |
| `key` | `String` |  |
| `value` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/update-env-var)

## updateEnvVarsForService

**Update environment variables**

Replace all environment variables for a service with the provided list of environment variables.

```dart
Future<List<EnvVarWithCursor>> updateEnvVarsForService({required String serviceId, required List<Map<String, Object?>> body})
```

`PUT /services/{serviceId}/env-vars`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `List<Map<String, Object?>>` | body | yes |  |

Returns `List<EnvVarWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `envVar` | `EnvVar` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/update-env-vars-for-service)

## updateHeaders

**Replace header rules**

Replace all header rules for a particular service with the provided list.

**This deletes all existing header rules for the service that aren't included in the request.**


```dart
Future<List<Header>> updateHeaders({required String serviceId, required List<HeaderInput> body})
```

`PUT /services/{serviceId}/headers`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `List<HeaderInput>` | body | yes |  |

Returns `List<Header>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `path` | `String` |  |
| `name` | `String` |  |
| `value` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/update-headers)

## updateSecretFilesForService

**Update secret files**

Replace all secret files for a service with the provided list of secret files.

**Any of the service's existing secret files not included in this request will be deleted.**

This only applies to secret files set directly on the service, not to secret files in a linked environment group.


```dart
Future<List<SecretFileWithCursor>> updateSecretFilesForService({required String serviceId, required List<UpdateSecretFilesForServiceRequestItem> body})
```

`PUT /services/{serviceId}/secret-files`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `List<UpdateSecretFilesForServiceRequestItem>` | body | yes |  |

Returns `List<SecretFileWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `secretFile` | `SecretFile` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/update-secret-files-for-service)

## updateService

**Update service**

Update the service with the provided ID.


```dart
Future<Service> updateService({required String serviceId, required ServicePatch body})
```

`PATCH /services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `ServicePatch` | body | yes |  |

Returns `Service`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `autoDeploy` | `AutoDeploy` |  |
| `branch` | `String?` |  |
| `buildFilter` | `BuildFilter?` |  |
| `createdAt` | `DateTime` |  |
| `dashboardUrl` | `String` | The URL to view the service in the Render Dashboard |
| `environmentId` | `String?` |  |
| `imagePath` | `String?` |  |
| `name` | `String` |  |
| `notifyOnFail` | `NotifySetting` |  |
| `ownerId` | `String` |  |
| `registryCredential` | `RegistryCredentialSummary?` |  |
| `repo` | `String?` |  |
| `rootDir` | `String` |  |
| `slug` | `String` |  |
| `suspended` | `Suspended` |  |
| `suspenders` | `List<SuspenderType>` |  |
| `type` | `ServiceType` |  |
| `updatedAt` | `DateTime` |  |
| `serviceDetails` | `Object?` |  |

[Render documentation](https://api-docs.render.com/reference/update-service)

