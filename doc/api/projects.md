# Projects

`render.raw.projects` — 5 operations on `/projects`.

| Method | | |
| --- | --- | --- |
| [`createProject`](#createproject) | `POST /projects` | Create project |
| [`deleteProject`](#deleteproject) | `DELETE /projects/{projectId}` | Delete project |
| [`listProjects`](#listprojects) | `GET /projects` | List projects |
| [`retrieveProject`](#retrieveproject) | `GET /projects/{projectId}` | Retrieve Project |
| [`updateProject`](#updateproject) | `PATCH /projects/{projectId}` | Update project |

---

## createProject

**Create project**

Create a new project.


```dart
Future<Project> createProject({required ProjectPostinput body})
```

`POST /projects`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `ProjectPostinput` | body | yes |  |

Returns `Project`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the project |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `name` | `String` | The name of the project |
| `owner` | `Owner` |  |
| `environmentIds` | `List<String>` | The environments associated with the project |

[Render documentation](https://api-docs.render.com/reference/create-project)

## deleteProject

**Delete project**

Delete the project with the provided ID.

Requires _all_ of the project's environments to be empty (i.e., they must contain no services or other resources). Otherwise, deletion fails with a `409` response.

To delete a non-empty project, do one of the following:
- First move or delete all contained services and other resources.
- Delete the project in the [Render Dashboard](https://dashboard.render.com).


```dart
Future<void> deleteProject({required String projectId})
```

`DELETE /projects/{projectId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `projectId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-project)

## listProjects

**List projects**

List projects matching the provided filters. If no filters are provided, all projects are returned.


```dart
Future<List<ProjectWithCursor>> listProjects({List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, String? cursor, int? limit})
```

`GET /projects`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<ProjectWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `project` | `Project` | A project is a collection of environments |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-projects)

## retrieveProject

**Retrieve Project**

Retrieve the project with the provided ID.


```dart
Future<Project> retrieveProject({required String projectId})
```

`GET /projects/{projectId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `projectId` | `String` | path | yes |  |

Returns `Project`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the project |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `name` | `String` | The name of the project |
| `owner` | `Owner` |  |
| `environmentIds` | `List<String>` | The environments associated with the project |

[Render documentation](https://api-docs.render.com/reference/retrieve-project)

## updateProject

**Update project**

Update the details of a project.

To update the details of a particular _environment_ in the project, instead use the [Update environment](https://api-docs.render.com/reference/update-environment) endpoint.


```dart
Future<Project> updateProject({required String projectId, required ProjectPatchinput body})
```

`PATCH /projects/{projectId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `projectId` | `String` | path | yes |  |
| `body` | `ProjectPatchinput` | body | yes |  |

Returns `Project`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the project |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `name` | `String` | The name of the project |
| `owner` | `Owner` |  |
| `environmentIds` | `List<String>` | The environments associated with the project |

[Render documentation](https://api-docs.render.com/reference/update-project)

