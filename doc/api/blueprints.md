# Blueprints

`render.raw.blueprints` — 6 operations on `/blueprints`.

| Method | | |
| --- | --- | --- |
| [`disconnectBlueprint`](#disconnectblueprint) | `DELETE /blueprints/{blueprintId}` | Disconnect Blueprint |
| [`listBlueprintSyncs`](#listblueprintsyncs) | `GET /blueprints/{blueprintId}/syncs` | List Blueprint syncs |
| [`listBlueprints`](#listblueprints) | `GET /blueprints` | List Blueprints |
| [`retrieveBlueprint`](#retrieveblueprint) | `GET /blueprints/{blueprintId}` | Retrieve Blueprint |
| [`updateBlueprint`](#updateblueprint) | `PATCH /blueprints/{blueprintId}` | Update Blueprint |
| [`validateBlueprint`](#validateblueprint) | `POST /blueprints/validate` | Validate Blueprint |

---

## disconnectBlueprint

**Disconnect Blueprint**

Disconnect the Blueprint with the provided ID.

Disconnecting a Blueprint stops automatic resource syncing via the associated `render.yaml` file. It does not _delete_ any services or other resources that were managed by the blueprint.


```dart
Future<void> disconnectBlueprint({required String blueprintId})
```

`DELETE /blueprints/{blueprintId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `blueprintId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/disconnect-blueprint)

## listBlueprintSyncs

**List Blueprint syncs**

List syncs for the Blueprint with the provided ID.


```dart
Future<List<SyncWithCursor>> listBlueprintSyncs({required String blueprintId, String? cursor, int? limit})
```

`GET /blueprints/{blueprintId}/syncs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `blueprintId` | `String` | path | yes |  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<SyncWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `sync_` | `SyncWithCursorSync` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-blueprint-syncs)

## listBlueprints

**List Blueprints**

List Blueprints for the specified workspaces. If no workspaces are provided, returns all Blueprints the API key has access to.


```dart
Future<List<BlueprintWithCursor>> listBlueprints({List<String>? ownerId, String? cursor, int? limit})
```

`GET /blueprints`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<BlueprintWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `blueprint` | `BlueprintWithCursorBlueprint` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-blueprints)

## retrieveBlueprint

**Retrieve Blueprint**

Retrieve the Blueprint with the provided ID.


```dart
Future<RetrieveBlueprintResponse> retrieveBlueprint({required String blueprintId})
```

`GET /blueprints/{blueprintId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `blueprintId` | `String` | path | yes |  |

Returns `RetrieveBlueprintResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `status` | `RetrieveBlueprintStatus` |  |
| `autoSync` | `bool` | Automatically sync changes to render.yaml |
| `repo` | `String` |  |
| `branch` | `String` |  |
| `path` | `String` | Path to the Blueprint file in the repository |
| `lastSync` | `DateTime?` |  |
| `resources` | `List<RetrieveBlueprintResponseResourcesItem>` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-blueprint)

## updateBlueprint

**Update Blueprint**

Update the Blueprint with the provided ID.


```dart
Future<UpdateBlueprintResponse> updateBlueprint({required String blueprintId, required UpdateBlueprintRequest body})
```

`PATCH /blueprints/{blueprintId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `blueprintId` | `String` | path | yes |  |
| `body` | `UpdateBlueprintRequest` | body | yes |  |

Returns `UpdateBlueprintResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `status` | `RetrieveBlueprintStatus` |  |
| `autoSync` | `bool` | Automatically sync changes to render.yaml |
| `repo` | `String` |  |
| `branch` | `String` |  |
| `path` | `String` | Path to the Blueprint file in the repository |
| `lastSync` | `DateTime?` |  |

[Render documentation](https://api-docs.render.com/reference/update-blueprint)

## validateBlueprint

**Validate Blueprint**

Validate a `render.yaml` Blueprint file without creating or modifying any resources. This endpoint checks the syntax and structure of the Blueprint, validates that all required fields are present, and returns a plan indicating the resources that would be created.

Requests to this endpoint use `Content-Type: multipart/form-data`. The request body (including the Blueprint file) cannot exceed 10MB in size.


```dart
Future<ValidateBlueprintResponse> validateBlueprint()
```

`POST /blueprints/validate`

Takes no parameters.

Returns `ValidateBlueprintResponse`.

| Field | Type | |
| --- | --- | --- |
| `valid` | `bool` | If `true`, the Blueprint validated successfully. If `false`, at least one validation error occurred. |
| `errors` | `List<ValidateBlueprintResponseErrorsItem>?` | A list of validation errors. Only present if `valid` is `false`. |
| `plan` | `ValidateBlueprintResponsePlan?` | A summary of the resources that would be created as part of the Blueprint. Only present if `valid` is `true`. |

[Render documentation](https://api-docs.render.com/reference/validate-blueprint)

