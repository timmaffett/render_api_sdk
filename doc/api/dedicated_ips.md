# DedicatedIps

`render.raw.dedicatedIps` — 5 operations on `/dedicated-ips`.

| Method | | |
| --- | --- | --- |
| [`createDedicatedIp`](#creatededicatedip) | `POST /dedicated-ips` | Create dedicated IP set |
| [`deleteDedicatedIp`](#deletededicatedip) | `DELETE /dedicated-ips/{dedicatedIpId}` | Delete dedicated IP set |
| [`listDedicatedIps`](#listdedicatedips) | `GET /dedicated-ips` | List dedicated IPs |
| [`retrieveDedicatedIp`](#retrievededicatedip) | `GET /dedicated-ips/{dedicatedIpId}` | Retrieve dedicated IP set |
| [`updateDedicatedIp`](#updatededicatedip) | `PATCH /dedicated-ips/{dedicatedIpId}` | Update dedicated IP set |

---

## createDedicatedIp

**Create dedicated IP set**

Create a dedicated IP set. Provisioning an IP set is asynchronous. The response returns immediately with `status: CREATING` and `ips: []`. When provisioning completes, status changes to `RUNNING` and `ips` contains your assigned addresses.

If `environmentIds` is omitted or empty, this IP set applies to all services in the workspace in the selected region. Otherwise, it applies only to services in the listed environments in that region.


```dart
Future<DedicatedIp> createDedicatedIp({required DedicatedIppost body})
```

`POST /dedicated-ips`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `DedicatedIppost` | body | yes |  |

Returns `DedicatedIp`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this dedicated IP set. |
| `name` | `String` | Descriptive name for this dedicated IP set. |
| `description` | `String` | Free-form description for this dedicated IP set. |
| `ownerId` | `String` | The ID of the workspace that owns this dedicated IP set. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentIds` | `List<String>` | Environments this dedicated IP set applies to. If empty, it applies to all services in the workspace within its region.  |
| `ips` | `List<String>` | The IPv4 addresses assigned to this dedicated IP set.  |
| `status` | `DedicatedIpstatus` | Current status of a dedicated IP set. |
| `createdAt` | `DateTime` | Time the dedicated IP set was created. |
| `updatedAt` | `DateTime?` | Time the dedicated IP set was last updated. |

[Render documentation](https://api-docs.render.com/reference/create-dedicated-ip)

## deleteDedicatedIp

**Delete dedicated IP set**

Delete the dedicated IP set with the provided ID.


```dart
Future<void> deleteDedicatedIp({required String dedicatedIpId})
```

`DELETE /dedicated-ips/{dedicatedIpId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `dedicatedIpId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-dedicated-ip)

## listDedicatedIps

**List dedicated IPs**

List dedicated IP sets for a workspace.


```dart
Future<List<DedicatedIp>> listDedicatedIps({required String ownerId, String? environmentId})
```

`GET /dedicated-ips`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | query | yes | The ID of the workspace to list dedicated IP sets for. |
| `environmentId` | `String` | query | no | Filter dedicated IP sets limited to this environment. Excludes workspace-scoped dedicated IP sets.  The environment must belong to the workspace named by `ownerId`.  |

Returns `List<DedicatedIp>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this dedicated IP set. |
| `name` | `String` | Descriptive name for this dedicated IP set. |
| `description` | `String` | Free-form description for this dedicated IP set. |
| `ownerId` | `String` | The ID of the workspace that owns this dedicated IP set. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentIds` | `List<String>` | Environments this dedicated IP set applies to. If empty, it applies to all services in the workspace within its region.  |
| `ips` | `List<String>` | The IPv4 addresses assigned to this dedicated IP set.  |
| `status` | `DedicatedIpstatus` | Current status of a dedicated IP set. |
| `createdAt` | `DateTime` | Time the dedicated IP set was created. |
| `updatedAt` | `DateTime?` | Time the dedicated IP set was last updated. |

[Render documentation](https://api-docs.render.com/reference/list-dedicated-ips)

## retrieveDedicatedIp

**Retrieve dedicated IP set**

Retrieve the dedicated IP set with the provided ID.

```dart
Future<DedicatedIp> retrieveDedicatedIp({required String dedicatedIpId})
```

`GET /dedicated-ips/{dedicatedIpId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `dedicatedIpId` | `String` | path | yes |  |

Returns `DedicatedIp`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this dedicated IP set. |
| `name` | `String` | Descriptive name for this dedicated IP set. |
| `description` | `String` | Free-form description for this dedicated IP set. |
| `ownerId` | `String` | The ID of the workspace that owns this dedicated IP set. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentIds` | `List<String>` | Environments this dedicated IP set applies to. If empty, it applies to all services in the workspace within its region.  |
| `ips` | `List<String>` | The IPv4 addresses assigned to this dedicated IP set.  |
| `status` | `DedicatedIpstatus` | Current status of a dedicated IP set. |
| `createdAt` | `DateTime` | Time the dedicated IP set was created. |
| `updatedAt` | `DateTime?` | Time the dedicated IP set was last updated. |

[Render documentation](https://api-docs.render.com/reference/retrieve-dedicated-ip)

## updateDedicatedIp

**Update dedicated IP set**

Update the dedicated IP set with the provided ID. All fields are optional. Omitted fields are left unchanged. To switch from environment-scoped to workspace-scoped, provide `environmentIds: []`.


```dart
Future<DedicatedIp> updateDedicatedIp({required String dedicatedIpId, required DedicatedIppatch body})
```

`PATCH /dedicated-ips/{dedicatedIpId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `dedicatedIpId` | `String` | path | yes |  |
| `body` | `DedicatedIppatch` | body | yes |  |

Returns `DedicatedIp`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | Unique identifier for this dedicated IP set. |
| `name` | `String` | Descriptive name for this dedicated IP set. |
| `description` | `String` | Free-form description for this dedicated IP set. |
| `ownerId` | `String` | The ID of the workspace that owns this dedicated IP set. |
| `region` | `Region` | Defaults to "oregon" |
| `environmentIds` | `List<String>` | Environments this dedicated IP set applies to. If empty, it applies to all services in the workspace within its region.  |
| `ips` | `List<String>` | The IPv4 addresses assigned to this dedicated IP set.  |
| `status` | `DedicatedIpstatus` | Current status of a dedicated IP set. |
| `createdAt` | `DateTime` | Time the dedicated IP set was created. |
| `updatedAt` | `DateTime?` | Time the dedicated IP set was last updated. |

[Render documentation](https://api-docs.render.com/reference/update-dedicated-ip)

