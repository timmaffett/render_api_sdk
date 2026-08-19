# Registrycredentials

`render.raw.registrycredentials` — 5 operations on `/registrycredentials`.

| Method | | |
| --- | --- | --- |
| [`createRegistryCredential`](#createregistrycredential) | `POST /registrycredentials` | Create registry credential |
| [`deleteRegistryCredential`](#deleteregistrycredential) | `DELETE /registrycredentials/{registryCredentialId}` | Delete registry credential |
| [`listRegistryCredentials`](#listregistrycredentials) | `GET /registrycredentials` | List registry credentials |
| [`retrieveRegistryCredential`](#retrieveregistrycredential) | `GET /registrycredentials/{registryCredentialId}` | Retrieve registry credential |
| [`updateRegistryCredential`](#updateregistrycredential) | `PATCH /registrycredentials/{registryCredentialId}` | Update registry credential |

---

## createRegistryCredential

**Create registry credential**

Create a new registry credential.

```dart
Future<RegistryCredential> createRegistryCredential({required CreateRegistryCredentialRequest body})
```

`POST /registrycredentials`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `CreateRegistryCredentialRequest` | body | yes |  |

Returns `RegistryCredential`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this credential |
| `name` | `String` | Descriptive name for this credential |
| `registry` | `RegistryCredentialRegistry` | The registry to use this credential with |
| `username` | `String` | The username associated with the credential |
| `updatedAt` | `DateTime` | Last updated time for the credential |

[Render documentation](https://api-docs.render.com/reference/create-registry-credential)

## deleteRegistryCredential

**Delete registry credential**

Delete the registry credential with the provided ID.

```dart
Future<void> deleteRegistryCredential({required String registryCredentialId})
```

`DELETE /registrycredentials/{registryCredentialId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `registryCredentialId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-registry-credential)

## listRegistryCredentials

**List registry credentials**

List registry credentials matching the provided filters. If no filters are provided, returns all registry credentials you have permissions to view.


```dart
Future<List<RegistryCredential>> listRegistryCredentials({List<String>? name, List<String>? username, List<String>? type, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, String? cursor, int? limit})
```

`GET /registrycredentials`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter for the name of a credential |
| `username` | `List<String>` | query | no | Filter for the username of a credential |
| `type` | `List<String>` | query | no | Filter for the registry type for the credential |
| `createdBefore` | `String` | query | no | Filter for services created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for services created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for services updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for services updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<RegistryCredential>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this credential |
| `name` | `String` | Descriptive name for this credential |
| `registry` | `RegistryCredentialRegistry` | The registry to use this credential with |
| `username` | `String` | The username associated with the credential |
| `updatedAt` | `DateTime` | Last updated time for the credential |

[Render documentation](https://api-docs.render.com/reference/list-registry-credentials)

## retrieveRegistryCredential

**Retrieve registry credential**

Retrieve the registry credential with the provided ID.

```dart
Future<RegistryCredential> retrieveRegistryCredential({required String registryCredentialId})
```

`GET /registrycredentials/{registryCredentialId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `registryCredentialId` | `String` | path | yes |  |

Returns `RegistryCredential`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this credential |
| `name` | `String` | Descriptive name for this credential |
| `registry` | `RegistryCredentialRegistry` | The registry to use this credential with |
| `username` | `String` | The username associated with the credential |
| `updatedAt` | `DateTime` | Last updated time for the credential |

[Render documentation](https://api-docs.render.com/reference/retrieve-registry-credential)

## updateRegistryCredential

**Update registry credential**

Update the registry credential with the provided ID. Services that use this credential must be redeployed to use updated values.

```dart
Future<RegistryCredential> updateRegistryCredential({required String registryCredentialId, required UpdateRegistryCredentialRequest body})
```

`PATCH /registrycredentials/{registryCredentialId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `registryCredentialId` | `String` | path | yes |  |
| `body` | `UpdateRegistryCredentialRequest` | body | yes |  |

Returns `RegistryCredential`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this credential |
| `name` | `String` | Descriptive name for this credential |
| `registry` | `RegistryCredentialRegistry` | The registry to use this credential with |
| `username` | `String` | The username associated with the credential |
| `updatedAt` | `DateTime` | Last updated time for the credential |

[Render documentation](https://api-docs.render.com/reference/update-registry-credential)

