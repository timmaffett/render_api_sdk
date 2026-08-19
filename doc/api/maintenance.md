# Maintenance

`render.raw.maintenance` — 4 operations on `/maintenance`.

| Method | | |
| --- | --- | --- |
| [`listMaintenance`](#listmaintenance) | `GET /maintenance` | List maintenance runs |
| [`retrieveMaintenance`](#retrievemaintenance) | `GET /maintenance/{maintenanceRunID}` | Retrieve maintenance run |
| [`triggerMaintenance`](#triggermaintenance) | `POST /maintenance/{maintenanceRunID}/trigger` | Trigger maintenance run |
| [`updateMaintenance`](#updatemaintenance) | `PATCH /maintenance/{maintenanceRunID}` | Update maintenance run |

---

## listMaintenance

**List maintenance runs**

List scheduled and/or recent maintenance runs for specified resources.


```dart
Future<List<ListMaintenanceResponse>> listMaintenance({List<String>? resourceId, List<String>? ownerId, List<String>? state})
```

`GET /maintenance`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `resourceId` | `List<String>` | query | no |  |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `state` | `List<String>` | query | no |  |

Returns `List<ListMaintenanceResponse>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `type` | `String` |  |
| `scheduledAt` | `DateTime` |  |
| `pendingMaintenanceBy` | `DateTime?` | If present, the maintenance run cannot be scheduled for later than this date-time. |
| `state` | `KeyValueDetailMaintenanceState` |  |
| `resourceId` | `String` | The Id of a resource that can undergo maintenance (Id of a service, a Postgres instance, or a Redis instance) |

[Render documentation](https://api-docs.render.com/reference/list-maintenance)

## retrieveMaintenance

**Retrieve maintenance run**

Retrieve the maintenance run with the provided ID.

```dart
Future<RetrieveMaintenanceResponse> retrieveMaintenance({required String maintenanceRunId})
```

`GET /maintenance/{maintenanceRunID}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `maintenanceRunId` | `String` | path | yes |  |

Returns `RetrieveMaintenanceResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `type` | `String` |  |
| `scheduledAt` | `DateTime` |  |
| `pendingMaintenanceBy` | `DateTime?` | If present, the maintenance run cannot be scheduled for later than this date-time. |
| `state` | `KeyValueDetailMaintenanceState` |  |
| `resourceId` | `String` | The Id of a resource that can undergo maintenance (Id of a service, a Postgres instance, or a Redis instance) |

[Render documentation](https://api-docs.render.com/reference/retrieve-maintenance)

## triggerMaintenance

**Trigger maintenance run**

Trigger the scheduled maintenance run with the provided ID.

Triggering maintenance is asynchronous. To check whether maintenance has started, use the [Retrieve maintenance run](https://api-docs.render.com/reference/retrieve-maintenance) endpoint.

As maintenance progresses, the run's `state` will change from `scheduled` to other values, such as `in_progress` and `succeeded`.


```dart
Future<void> triggerMaintenance({required String maintenanceRunId})
```

`POST /maintenance/{maintenanceRunID}/trigger`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `maintenanceRunId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/trigger-maintenance)

## updateMaintenance

**Update maintenance run**

Update the maintenance run with the provided ID.

Updates from this endpoint are asynchronous. To check your update's status, use the [Retrieve maintenance run](https://api-docs.render.com/reference/retrieve-maintenance) endpoint.


```dart
Future<void> updateMaintenance({required String maintenanceRunId, required UpdateMaintenanceRequest body})
```

`PATCH /maintenance/{maintenanceRunID}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `maintenanceRunId` | `String` | path | yes |  |
| `body` | `UpdateMaintenanceRequest` | body | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/update-maintenance)

