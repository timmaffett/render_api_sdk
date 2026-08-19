# Environments

`render.raw.environments` — 7 operations on `/environments`.

| Method | | |
| --- | --- | --- |
| [`addResourcesToEnvironment`](#addresourcestoenvironment) | `POST /environments/{environmentId}/resources` | Add resources to environment |
| [`createEnvironment`](#createenvironment) | `POST /environments` | Create environment |
| [`deleteEnvironment`](#deleteenvironment) | `DELETE /environments/{environmentId}` | Delete environment |
| [`listEnvironments`](#listenvironments) | `GET /environments` | List environments |
| [`removeResourcesFromEnvironment`](#removeresourcesfromenvironment) | `DELETE /environments/{environmentId}/resources` | Remove resources from environment |
| [`retrieveEnvironment`](#retrieveenvironment) | `GET /environments/{environmentId}` | Retrieve environment |
| [`updateEnvironment`](#updateenvironment) | `PATCH /environments/{environmentId}` | Update environment |

---

## addResourcesToEnvironment

**Add resources to environment**

Add resources to the environment with the provided ID.


```dart
Future<Environment> addResourcesToEnvironment({required String environmentId, required EnvironmentResourcesPostinput body})
```

`POST /environments/{environmentId}/resources`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `environmentId` | `String` | path | yes |  |
| `body` | `EnvironmentResourcesPostinput` | body | yes |  |

Returns `Environment`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `projectId` | `String` |  |
| `databasesIds` | `List<String>` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>?` |  |
| `redisIds` | `List<String>` |  |
| `serviceIds` | `List<String>` |  |
| `envGroupIds` | `List<String>` |  |
| `protectedStatus` | `ProtectedStatus` | Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments. |
| `networkIsolationEnabled` | `bool` | Indicates whether network connections across environments are allowed. |

[Render documentation](https://api-docs.render.com/reference/add-resources-to-environment)

## createEnvironment

**Create environment**

Create a new environment belonging to the project with the provided ID.


```dart
Future<Environment> createEnvironment({required EnvironmentPostinput body})
```

`POST /environments`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `EnvironmentPostinput` | body | yes |  |

Returns `Environment`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `projectId` | `String` |  |
| `databasesIds` | `List<String>` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>?` |  |
| `redisIds` | `List<String>` |  |
| `serviceIds` | `List<String>` |  |
| `envGroupIds` | `List<String>` |  |
| `protectedStatus` | `ProtectedStatus` | Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments. |
| `networkIsolationEnabled` | `bool` | Indicates whether network connections across environments are allowed. |

[Render documentation](https://api-docs.render.com/reference/create-environment)

## deleteEnvironment

**Delete environment**

Delete the environment with the provided ID.

Requires the environment to be empty (i.e., it must contain no services or other resources). Otherwise, deletion fails with a `409` response.

To delete a non-empty environment, do one of the following:
- First move or delete all contained services and other resources.
- Delete the environment in the [Render Dashboard](https://dashboard.render.com).


```dart
Future<void> deleteEnvironment({required String environmentId})
```

`DELETE /environments/{environmentId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `environmentId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-environment)

## listEnvironments

**List environments**

List a particular project's environments matching the provided filters. If no filters are provided, all environments are returned.


```dart
Future<List<EnvironmentWithCursor>> listEnvironments({List<String>? name, required List<String> projectId, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit})
```

`GET /environments`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `projectId` | `List<String>` | query | yes | Filter for resources that belong to a project |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<EnvironmentWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `environment` | `Environment` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-environments)

## removeResourcesFromEnvironment

**Remove resources from environment**

Remove resources from the environment with the provided ID.


```dart
Future<void> removeResourcesFromEnvironment({required String environmentId, required List<String> resourceIds})
```

`DELETE /environments/{environmentId}/resources`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `environmentId` | `String` | path | yes |  |
| `resourceIds` | `List<String>` | query | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/remove-resources-from-environment)

## retrieveEnvironment

**Retrieve environment**

Retrieve the environment with the provided ID.

```dart
Future<Environment> retrieveEnvironment({required String environmentId})
```

`GET /environments/{environmentId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `environmentId` | `String` | path | yes |  |

Returns `Environment`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `projectId` | `String` |  |
| `databasesIds` | `List<String>` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>?` |  |
| `redisIds` | `List<String>` |  |
| `serviceIds` | `List<String>` |  |
| `envGroupIds` | `List<String>` |  |
| `protectedStatus` | `ProtectedStatus` | Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments. |
| `networkIsolationEnabled` | `bool` | Indicates whether network connections across environments are allowed. |

[Render documentation](https://api-docs.render.com/reference/retrieve-environment)

## updateEnvironment

**Update environment**

Update the details of the environment with the provided ID.

```dart
Future<Environment> updateEnvironment({required String environmentId, required EnvironmentPatchinput body})
```

`PATCH /environments/{environmentId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `environmentId` | `String` | path | yes |  |
| `body` | `EnvironmentPatchinput` | body | yes |  |

Returns `Environment`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `projectId` | `String` |  |
| `databasesIds` | `List<String>` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>?` |  |
| `redisIds` | `List<String>` |  |
| `serviceIds` | `List<String>` |  |
| `envGroupIds` | `List<String>` |  |
| `protectedStatus` | `ProtectedStatus` | Indicates whether an environment is `unprotected` or `protected`. Only admin users can perform destructive actions in `protected` environments. |
| `networkIsolationEnabled` | `bool` | Indicates whether network connections across environments are allowed. |

[Render documentation](https://api-docs.render.com/reference/update-environment)

