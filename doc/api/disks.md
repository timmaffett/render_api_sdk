# Disks

`render.raw.disks` — 7 operations on `/disks`.

| Method | | |
| --- | --- | --- |
| [`addDisk`](#adddisk) | `POST /disks` | Add disk |
| [`deleteDisk`](#deletedisk) | `DELETE /disks/{diskId}` | Delete disk |
| [`listDisks`](#listdisks) | `GET /disks` | List disks |
| [`listSnapshots`](#listsnapshots) | `GET /disks/{diskId}/snapshots` | List snapshots |
| [`restoreSnapshot`](#restoresnapshot) | `POST /disks/{diskId}/snapshots/restore` | Restore snapshot |
| [`retrieveDisk`](#retrievedisk) | `GET /disks/{diskId}` | Retrieve disk |
| [`updateDisk`](#updatedisk) | `PATCH /disks/{diskId}` | Update disk |

---

## addDisk

**Add disk**

Attach a persistent disk to a web service, private service, or background worker.

The service must be redeployed for the disk to be attached.


```dart
Future<AddDiskResponse> addDisk({required AddDiskRequest body})
```

`POST /disks`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `AddDiskRequest` | body | yes |  |

Returns `AddDiskResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `sizeGb` | `int` |  |
| `mountPath` | `String` |  |
| `serviceId` | `String?` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |

[Render documentation](https://api-docs.render.com/reference/add-disk)

## deleteDisk

**Delete disk**

Delete a persistent disk attached to a service.

**All data on the disk will be lost.** The disk's associated service will immediately lose access to it.


```dart
Future<void> deleteDisk({required String diskId})
```

`DELETE /disks/{diskId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `diskId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-disk)

## listDisks

**List disks**

List persistent disks matching the provided filters. If no filters are provided, returns all disks you have permissions to view.


```dart
Future<List<DiskWithCursor>> listDisks({List<String>? ownerId, List<String>? diskId, List<String>? name, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? serviceId, String? cursor, int? limit})
```

`GET /disks`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `diskId` | `List<String>` | query | no | Filter by disk IDs |
| `name` | `List<String>` | query | no | Filter by name |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `serviceId` | `List<String>` | query | no | Filter for resources by service ID |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<DiskWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `disk` | `DiskWithCursorDisk` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-disks)

## listSnapshots

**List snapshots**

List snapshots for the persistent disk with the provided ID. Each snapshot is a point-in-time copy of the disk's data.


```dart
Future<List<DiskSnapshot>> listSnapshots({required String diskId})
```

`GET /disks/{diskId}/snapshots`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `diskId` | `String` | path | yes |  |

Returns `List<DiskSnapshot>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `createdAt` | `DateTime?` |  |
| `snapshotKey` | `String?` |  |
| `instanceId` | `String?` | When a service with a disk is scaled, the instanceId is used to identify the instance that the disk is attached to. Each instance's disks get their own snapshots, and can be restored separately. |

[Render documentation](https://api-docs.render.com/reference/list-snapshots)

## restoreSnapshot

**Restore snapshot**

Restore a persistent disk to an available snapshot.

**This operation is irreversible.** It will overwrite the current disk data. It might also trigger a service deploy.

Snapshot keys returned from the [List snapshots](https://api-docs.render.com/reference/list-snapshots) endpoint expire after 24 hours. If a snapshot key has expired, query the endpoint again for a new key.


```dart
Future<RestoreSnapshotResponse> restoreSnapshot({required String diskId, required SnapshotRestorePost body})
```

`POST /disks/{diskId}/snapshots/restore`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `diskId` | `String` | path | yes |  |
| `body` | `SnapshotRestorePost` | body | yes |  |

Returns `RestoreSnapshotResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `sizeGb` | `int` |  |
| `mountPath` | `String` |  |
| `serviceId` | `String?` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |

[Render documentation](https://api-docs.render.com/reference/restore-snapshot)

## retrieveDisk

**Retrieve disk**

Retrieve the persistent disk with the provided ID.


```dart
Future<RetrieveDiskResponse> retrieveDisk({required String diskId})
```

`GET /disks/{diskId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `diskId` | `String` | path | yes |  |

Returns `RetrieveDiskResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `sizeGb` | `int` |  |
| `mountPath` | `String` |  |
| `serviceId` | `String?` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-disk)

## updateDisk

**Update disk**

Update the persistent disk with the provided ID.

The disk's associated service must be deployed and active for updates to take effect.

When resizing a disk, the new size must be greater than the current size.


```dart
Future<UpdateDiskResponse> updateDisk({required String diskId, required UpdateDiskRequest body})
```

`PATCH /disks/{diskId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `diskId` | `String` | path | yes |  |
| `body` | `UpdateDiskRequest` | body | yes |  |

Returns `UpdateDiskResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `sizeGb` | `int` |  |
| `mountPath` | `String` |  |
| `serviceId` | `String?` |  |
| `createdAt` | `DateTime` |  |
| `updatedAt` | `DateTime` |  |

[Render documentation](https://api-docs.render.com/reference/update-disk)

