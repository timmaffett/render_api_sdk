# Workflows

`render.raw.workflows` — 5 operations on `/workflows`.

| Method | | |
| --- | --- | --- |
| [`createWorkflow`](#createworkflow) | `POST /workflows` | Create a workflow |
| [`deleteWorkflow`](#deleteworkflow) | `DELETE /workflows/{workflowId}` | Delete workflow |
| [`getWorkflow`](#getworkflow) | `GET /workflows/{workflowId}` | Retrieve workflow |
| [`listWorkflows`](#listworkflows) | `GET /workflows` | List workflows |
| [`updateWorkflow`](#updateworkflow) | `PATCH /workflows/{workflowId}` | Update workflow |

---

## createWorkflow

**Create a workflow**

Create a new workflow service with the specified configuration.

```dart
Future<CreateWorkflowResponse> createWorkflow({required CreateWorkflowRequest body})
```

`POST /workflows`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `CreateWorkflowRequest` | body | yes |  |

Returns `CreateWorkflowResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `buildConfig` | `CreateWorkflowResponseBuildConfig` |  |
| `runCommand` | `String` | Command to run the workflow. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentId` | `String?` |  |
| `slug` | `String?` |  |
| `autoDeployTrigger` | `NewTrigger?` | Controls autodeploy behavior. "commit" deploys when a commit is pushed to the branch. "checksPass" waits for CI checks to pass before deploying. "off" disables autodeploy. |

[Render documentation](https://api-docs.render.com/reference/createWorkflow)

## deleteWorkflow

**Delete workflow**

Delete the workflow service with the provided ID.

```dart
Future<void> deleteWorkflow({required String workflowId})
```

`DELETE /workflows/{workflowId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `workflowId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/deleteWorkflow)

## getWorkflow

**Retrieve workflow**

Retrieve the workflow service with the provided ID.

```dart
Future<GetWorkflowResponse> getWorkflow({required String workflowId})
```

`GET /workflows/{workflowId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `workflowId` | `String` | path | yes |  |

Returns `GetWorkflowResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `buildConfig` | `GetWorkflowResponseBuildConfig` |  |
| `runCommand` | `String` | Command to run the workflow. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentId` | `String?` |  |
| `slug` | `String?` |  |
| `autoDeployTrigger` | `NewTrigger?` | Controls autodeploy behavior. "commit" deploys when a commit is pushed to the branch. "checksPass" waits for CI checks to pass before deploying. "off" disables autodeploy. |

[Render documentation](https://api-docs.render.com/reference/getWorkflow)

## listWorkflows

**List workflows**

List workflows that match the provided filters. If no filters are provided, all workflows accessible by the authenticated user are returned.

```dart
Future<List<WorkflowWithCursor>> listWorkflows({List<String>? name, List<String>? ownerId, List<String>? workflowId, List<String>? environmentId, String? cursor, int? limit})
```

`GET /workflows`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `workflowId` | `List<String>` | query | no | The IDs of the workflows to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<WorkflowWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `workflow` | `WorkflowWithCursorWorkflow` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/listWorkflows)

## updateWorkflow

**Update workflow**

Update the workflow service with the provided ID.

```dart
Future<UpdateWorkflowResponse> updateWorkflow({required String workflowId, required UpdateWorkflowRequest body})
```

`PATCH /workflows/{workflowId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `workflowId` | `String` | path | yes |  |
| `body` | `UpdateWorkflowRequest` | body | yes |  |

Returns `UpdateWorkflowResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `ownerId` | `String` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |
| `buildConfig` | `UpdateWorkflowResponseBuildConfig` |  |
| `runCommand` | `String` | Command to run the workflow. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentId` | `String?` |  |
| `slug` | `String?` |  |
| `autoDeployTrigger` | `NewTrigger?` | Controls autodeploy behavior. "commit" deploys when a commit is pushed to the branch. "checksPass" waits for CI checks to pass before deploying. "off" disables autodeploy. |

[Render documentation](https://api-docs.render.com/reference/updateWorkflow)

