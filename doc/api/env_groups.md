# EnvGroups

`render.raw.envGroups` — 13 operations on `/env-groups`.

| Method | | |
| --- | --- | --- |
| [`createEnvGroup`](#createenvgroup) | `POST /env-groups` | Create environment group |
| [`deleteEnvGroup`](#deleteenvgroup) | `DELETE /env-groups/{envGroupId}` | Delete environment group |
| [`deleteEnvGroupEnvVar`](#deleteenvgroupenvvar) | `DELETE /env-groups/{envGroupId}/env-vars/{envVarKey}` | Remove environment variable |
| [`deleteEnvGroupSecretFile`](#deleteenvgroupsecretfile) | `DELETE /env-groups/{envGroupId}/secret-files/{envVarKey}` | Remove secret file |
| [`linkServiceToEnvGroup`](#linkservicetoenvgroup) | `POST /env-groups/{envGroupId}/services/{serviceId}` | Link service |
| [`listEnvGroups`](#listenvgroups) | `GET /env-groups` | List environment groups |
| [`retrieveEnvGroup`](#retrieveenvgroup) | `GET /env-groups/{envGroupId}` | Retrieve environment group |
| [`retrieveEnvGroupEnvVar`](#retrieveenvgroupenvvar) | `GET /env-groups/{envGroupId}/env-vars/{envVarKey}` | Retrieve environment variable |
| [`retrieveEnvGroupSecretFile`](#retrieveenvgroupsecretfile) | `GET /env-groups/{envGroupId}/secret-files/{envVarKey}` | Retrieve secret file |
| [`unlinkServiceFromEnvGroup`](#unlinkservicefromenvgroup) | `DELETE /env-groups/{envGroupId}/services/{serviceId}` | Unlink service |
| [`updateEnvGroup`](#updateenvgroup) | `PATCH /env-groups/{envGroupId}` | Update environment group |
| [`updateEnvGroupEnvVar`](#updateenvgroupenvvar) | `PUT /env-groups/{envGroupId}/env-vars/{envVarKey}` | Add or update environment variable |
| [`updateEnvGroupSecretFile`](#updateenvgroupsecretfile) | `PUT /env-groups/{envGroupId}/secret-files/{envVarKey}` | Add or update secret file |

---

## createEnvGroup

**Create environment group**

Create a new environment group.


```dart
Future<EnvGroup> createEnvGroup({required EnvGroupPostinput body})
```

`POST /env-groups`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `EnvGroupPostinput` | body | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/create-env-group)

## deleteEnvGroup

**Delete environment group**

Delete the environment group with the provided ID, including all environment variables and secret files it contains.

```dart
Future<void> deleteEnvGroup({required String envGroupId})
```

`DELETE /env-groups/{envGroupId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-env-group)

## deleteEnvGroupEnvVar

**Remove environment variable**

Remove a particular environment variable from a particular environment group.


```dart
Future<void> deleteEnvGroupEnvVar({required String envGroupId, required String envVarKey})
```

`DELETE /env-groups/{envGroupId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-env-group-env-var)

## deleteEnvGroupSecretFile

**Remove secret file**

Remove a particular secret file from a particular environment group.


```dart
Future<void> deleteEnvGroupSecretFile({required String envGroupId, required String envVarKey})
```

`DELETE /env-groups/{envGroupId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-env-group-secret-file)

## linkServiceToEnvGroup

**Link service**

Link a particular service to a particular environment group.

The linked service will have access to the environment variables and secret files in the group.


```dart
Future<EnvGroup> linkServiceToEnvGroup({required String envGroupId, required String serviceId})
```

`POST /env-groups/{envGroupId}/services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `serviceId` | `String` | path | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/link-service-to-env-group)

## listEnvGroups

**List environment groups**

List environment groups matching the provided filters. If no filters are provided, all environment groups are returned.


```dart
Future<List<EnvGroupMeta>> listEnvGroups({List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit})
```

`GET /env-groups`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<EnvGroupMeta>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/list-env-groups)

## retrieveEnvGroup

**Retrieve environment group**

Retrieve an environment group by ID.


```dart
Future<EnvGroup> retrieveEnvGroup({required String envGroupId})
```

`GET /env-groups/{envGroupId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-env-group)

## retrieveEnvGroupEnvVar

**Retrieve environment variable**

Retrieve a particular environment variable in a particular environment group.


```dart
Future<EnvVar> retrieveEnvGroupEnvVar({required String envGroupId, required String envVarKey})
```

`GET /env-groups/{envGroupId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `EnvVar`.

| Field | Type | |
| --- | --- | --- |
| `key` | `String` |  |
| `value` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-env-group-env-var)

## retrieveEnvGroupSecretFile

**Retrieve secret file**

Retrieve a particular secret file in a particular environment group.


```dart
Future<SecretFile> retrieveEnvGroupSecretFile({required String envGroupId, required String envVarKey})
```

`GET /env-groups/{envGroupId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |

Returns `SecretFile`.

| Field | Type | |
| --- | --- | --- |
| `name` | `String` |  |
| `content` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-env-group-secret-file)

## unlinkServiceFromEnvGroup

**Unlink service**

Unlink a particular service from a particular environment group.

The service will lose access to the environment variables and secret files in the group.


```dart
Future<void> unlinkServiceFromEnvGroup({required String envGroupId, required String serviceId})
```

`DELETE /env-groups/{envGroupId}/services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `serviceId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/unlink-service-from-env-group)

## updateEnvGroup

**Update environment group**

Update the attributes of an environment group.

```dart
Future<EnvGroup> updateEnvGroup({required String envGroupId, required EnvGroupPatchinput body})
```

`PATCH /env-groups/{envGroupId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `body` | `EnvGroupPatchinput` | body | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/update-env-group)

## updateEnvGroupEnvVar

**Add or update environment variable**

Add or update a particular environment variable in a particular environment group.


```dart
Future<EnvGroup> updateEnvGroupEnvVar({required String envGroupId, required String envVarKey, required Map<String, Object?> body})
```

`PUT /env-groups/{envGroupId}/env-vars/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |
| `body` | `Map<String, Object?>` | body | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/update-env-group-env-var)

## updateEnvGroupSecretFile

**Add or update secret file**

Add or update a particular secret file in an particular environment group.


```dart
Future<EnvGroup> updateEnvGroupSecretFile({required String envGroupId, required String envVarKey, required UpdateEnvGroupSecretFileRequest body})
```

`PUT /env-groups/{envGroupId}/secret-files/{envVarKey}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `envGroupId` | `String` | path | yes |  |
| `envVarKey` | `String` | path | yes |  |
| `body` | `UpdateEnvGroupSecretFileRequest` | body | yes |  |

Returns `EnvGroup`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `serviceLinks` | `List<EnvGroupLink>` | List of serviceIds linked to the envGroup |
| `environmentId` | `String?` |  |
| `envVars` | `List<EnvVar>` |  |
| `secretFiles` | `List<SecretFile>` |  |

[Render documentation](https://api-docs.render.com/reference/update-env-group-secret-file)

