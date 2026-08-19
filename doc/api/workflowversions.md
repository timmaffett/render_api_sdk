# Workflowversions

`render.raw.workflowversions` — 3 operations on `/workflowversions`.

| Method | | |
| --- | --- | --- |
| [`createWorkflowVersion`](#createworkflowversion) | `POST /workflowversions` | Deploy a workflow version |
| [`getWorkflowVersion`](#getworkflowversion) | `GET /workflowversions/{workflowVersionId}` | Retrieve workflow version |
| [`listWorkflowVersions`](#listworkflowversions) | `GET /workflowversions` | List workflow versions |

---

## createWorkflowVersion

**Deploy a workflow version**

Creates and deploys a new version of a workflow.

```dart
Future<void> createWorkflowVersion({required CreateWorkflowVersionRequest body})
```

`POST /workflowversions`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `CreateWorkflowVersionRequest` | body | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/createWorkflowVersion)

## getWorkflowVersion

**Retrieve workflow version**

Retrieve the specific workflow service version with the provided ID.

```dart
Future<GetWorkflowVersionResponse> getWorkflowVersion({required String workflowVersionId})
```

`GET /workflowversions/{workflowVersionId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `workflowVersionId` | `String` | path | yes |  |

Returns `GetWorkflowVersionResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `workflowId` | `String` |  |
| `name` | `String` |  |
| `createdAt` | `DateTime` |  |
| `status` | `GetWorkflowVersionStatus` |  |

[Render documentation](https://api-docs.render.com/reference/getWorkflowVersion)

## listWorkflowVersions

**List workflow versions**

List known versions of the workflow service with the provided ID.

```dart
Future<List<WorkflowVersionWithCursor>> listWorkflowVersions({List<String>? ownerId, List<String>? workflowId, List<String>? workflowVersionId, String? cursor, int? limit})
```

`GET /workflowversions`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `workflowId` | `List<String>` | query | no | The IDs of the workflows to return resources for |
| `workflowVersionId` | `List<String>` | query | no | The IDs of the workflow versions to return resources for |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<WorkflowVersionWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `workflowVersion` | `WorkflowVersionWithCursorWorkflowVersion` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/listWorkflowVersions)

