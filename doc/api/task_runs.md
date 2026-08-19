# TaskRuns

`render.raw.taskRuns` — 5 operations on `/task-runs`.

| Method | | |
| --- | --- | --- |
| [`cancelTaskRun`](#canceltaskrun) | `DELETE /task-runs/{taskRunId}` | Cancel task run |
| [`createTask`](#createtask) | `POST /task-runs` | Run task |
| [`getTaskRun`](#gettaskrun) | `GET /task-runs/{taskRunId}` | Retrieve task run |
| [`listTaskRuns`](#listtaskruns) | `GET /task-runs` | List task runs |
| [`streamTaskRunsEvents`](#streamtaskrunsevents) | `GET /task-runs/events` | Stream realtime events (SSE) |

---

## cancelTaskRun

**Cancel task run**

Cancel a running task run with the provided ID.

```dart
Future<void> cancelTaskRun({required String taskRunId})
```

`DELETE /task-runs/{taskRunId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `taskRunId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/cancelTaskRun)

## createTask

**Run task**

Kicks off a run of the workflow task with the provided ID, passing the provided input data.

```dart
Future<CreateTaskResponse> createTask({required CreateTaskRequest body})
```

`POST /task-runs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `CreateTaskRequest` | body | yes |  |

Returns `CreateTaskResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `taskId` | `String` |  |
| `status` | `GetTaskRunStatus` |  |
| `startedAt` | `DateTime?` |  |
| `completedAt` | `DateTime?` |  |
| `parentTaskRunId` | `String` |  |
| `parentTaskAttempt` | `int?` | The 0-indexed attempt of the parent task run that spawned this task run. Omitted for root task runs and for task runs created before this field was introduced. |
| `rootTaskRunId` | `String` |  |
| `retries` | `int` |  |
| `attempts` | `List<CreateTaskResponseAttemptsItem>` |  |

[Render documentation](https://api-docs.render.com/reference/createTask)

## getTaskRun

**Retrieve task run**

Retrieve the workflow task run with the provided ID.

```dart
Future<GetTaskRunResponse> getTaskRun({required String taskRunId})
```

`GET /task-runs/{taskRunId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `taskRunId` | `String` | path | yes |  |

Returns `GetTaskRunResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `taskId` | `String` |  |
| `status` | `GetTaskRunStatus` |  |
| `results` | `List<Object?>` |  |
| `error` | `String?` | Error message if the task run failed. |
| `startedAt` | `DateTime?` |  |
| `completedAt` | `DateTime?` |  |
| `input` | `Object?` | Input data for a task. Can be either an array (for positional arguments) or an object (for named parameters). |
| `parentTaskRunId` | `String` |  |
| `parentTaskAttempt` | `int?` | The 0-indexed attempt of the parent task run that spawned this task run. Omitted for root task runs and for task runs created before this field was introduced. |
| `rootTaskRunId` | `String` |  |
| `retries` | `int` |  |
| `attempts` | `List<GetTaskRunResponseAttemptsItem>` |  |

[Render documentation](https://api-docs.render.com/reference/getTaskRun)

## listTaskRuns

**List task runs**

List task runs that match the provided filters. If no filters are provided, all task runs accessible by the authenticated user are returned.

```dart
Future<List<TaskRunWithCursor>> listTaskRuns({String? cursor, int? limit, List<String>? taskSlug, List<String>? rootTaskRunId, List<String>? ownerId, List<String>? workflowVersionId, List<String>? workflowId})
```

`GET /task-runs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `taskSlug` | `List<String>` | query | no | An array of task slugs in the format workflow-slug/task-name. An optional version can be appended (workflow-slug/task-name:version). If no version is provided, the latest version is used. |
| `rootTaskRunId` | `List<String>` | query | no | An array of root task run IDs to filter on |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `workflowVersionId` | `List<String>` | query | no | An array of workflow version IDs |
| `workflowId` | `List<String>` | query | no | An array of workflow IDs |

Returns `List<TaskRunWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `taskRun` | `TaskRunWithCursorTaskRun` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/listTaskRuns)

## streamTaskRunsEvents

**Stream realtime events (SSE)**

Establishes a unidirectional event stream. The server sends events as lines
formatted per the SSE spec. Clients SHOULD set `Accept: text/event-stream`
and keep the connection open.


```dart
Future<void> streamTaskRunsEvents({required List<String> taskRunIds})
```

`GET /task-runs/events`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `taskRunIds` | `List<String>` | query | yes | Filter to a subset of task run IDs. |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/streamTaskRunsEvents)

