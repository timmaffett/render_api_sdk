# Tasks

`render.raw.tasks` — 2 operations on `/tasks`.

| Method | | |
| --- | --- | --- |
| [`getTask`](#gettask) | `GET /tasks/{taskId}` | Retrieve task |
| [`listTasks`](#listtasks) | `GET /tasks` | List tasks |

---

## getTask

**Retrieve task**

Retrieve the workflow task with the provided ID.

```dart
Future<GetTaskResponse> getTask({required String taskId})
```

`GET /tasks/{taskId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `taskId` | `String` | path | yes |  |

Returns `GetTaskResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `createdAt` | `DateTime` |  |
| `workflowId` | `String?` |  |
| `workflowVersionId` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/getTask)

## listTasks

**List tasks**

List workflow tasks that match the provided filters. If no filters are provided, all task definitions accessible by the authenticated user are returned.

```dart
Future<List<TaskWithCursor>> listTasks({String? cursor, int? limit, List<String>? ownerId, List<String>? taskSlug, List<String>? workflowVersionId, List<String>? workflowId})
```

`GET /tasks`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `taskSlug` | `List<String>` | query | no | An array of task slugs in the format workflow-slug/task-name. An optional version can be appended (workflow-slug/task-name:version). If no version is provided, the latest version is used. |
| `workflowVersionId` | `List<String>` | query | no | An array of workflow version IDs |
| `workflowId` | `List<String>` | query | no | An array of workflow IDs |

Returns `List<TaskWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `task` | `TaskWithCursorTask` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/listTasks)

