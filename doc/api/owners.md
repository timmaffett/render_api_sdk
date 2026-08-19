# Owners

`render.raw.owners` — 6 operations on `/owners`.

| Method | | |
| --- | --- | --- |
| [`listOwnerAuditLogs`](#listownerauditlogs) | `GET /owners/{ownerId}/audit-logs` | List workspace audit logs |
| [`listOwners`](#listowners) | `GET /owners` | List workspaces |
| [`removeWorkspaceMember`](#removeworkspacemember) | `DELETE /owners/{ownerId}/members/{userId}` | Remove workspace member |
| [`retrieveOwner`](#retrieveowner) | `GET /owners/{ownerId}` | Retrieve workspace |
| [`retrieveOwnerMembers`](#retrieveownermembers) | `GET /owners/{ownerId}/members` | List workspace members |
| [`updateWorkspaceMember`](#updateworkspacemember) | `PATCH /owners/{ownerId}/members/{userId}` | Update workspace member role |

---

## listOwnerAuditLogs

**List workspace audit logs**

Retrieve audit logs for a specific workspace with optional filtering and pagination.


```dart
Future<List<AuditLogWithCursor>> listOwnerAuditLogs({required String ownerId, String? startTime, String? endTime, String? direction, String? cursor, int? limit})
```

`GET /owners/{ownerId}/audit-logs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `startTime` | `String` | query | no | Start time for filtering audit logs (ISO 8601 format) |
| `endTime` | `String` | query | no | End time for filtering audit logs (ISO 8601 format) |
| `direction` | `String` | query | no | The direction to query logs for. Backward will return most recent logs first. Forward will start with the oldest logs in the time range.  |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of audit log items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<AuditLogWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `cursor` | `String` |  |
| `auditLog` | `AuditLog` |  |

[Render documentation](https://api-docs.render.com/reference/list-owner-audit-logs)

## listOwners

**List workspaces**

List the workspaces that your API key has access to, optionally filtered by name or owner email address.


```dart
Future<List<OwnerWithCursor>> listOwners({List<String>? name, List<String>? email, String? cursor, int? limit})
```

`GET /owners`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Only return workspaces with one of the provided names. Only exact matches are returned. |
| `email` | `List<String>` | query | no | Only return workspaces owned by one of the provided email addresses. |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<OwnerWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `owner` | `Owner?` |  |
| `cursor` | `String?` |  |

[Render documentation](https://api-docs.render.com/reference/list-owners)

## removeWorkspaceMember

**Remove workspace member**

Remove a user from the specified workspace.


```dart
Future<void> removeWorkspaceMember({required String ownerId, required String userId})
```

`DELETE /owners/{ownerId}/members/{userId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `userId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/remove-workspace-member)

## retrieveOwner

**Retrieve workspace**

Retrieve the workspace with the provided ID.

Workspace IDs start with `tea-`. If you provide a user ID (starts with `own-`), this endpoint returns the user's default workspace.


```dart
Future<Owner> retrieveOwner({required String ownerId})
```

`GET /owners/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `Owner`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `email` | `String` |  |
| `ipAllowList` | `List<CidrBlockAndDescription>?` |  |
| `twoFactorAuthEnabled` | `bool?` | Whether two-factor authentication is enabled for the owner. Only present if `type` is `user`. |
| `type` | `OwnerType` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-owner)

## retrieveOwnerMembers

**List workspace members**

Retrieves the list of users belonging to the workspace with the provided ID.


```dart
Future<List<TeamMember>> retrieveOwnerMembers({required String ownerId})
```

`GET /owners/{ownerId}/members`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `List<TeamMember>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `userId` | `String` |  |
| `name` | `String` |  |
| `email` | `String` |  |
| `status` | `TeamMemberStatus` |  |
| `role` | `TeamMemberRole` | The member's workspace role. Values are always returned in uppercase. |
| `mfaEnabled` | `bool` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-owner-members)

## updateWorkspaceMember

**Update workspace member role**

Update the role of an existing workspace member.


```dart
Future<TeamMember> updateWorkspaceMember({required String ownerId, required String userId, required UpdateWorkspaceMemberRequest body})
```

`PATCH /owners/{ownerId}/members/{userId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `userId` | `String` | path | yes |  |
| `body` | `UpdateWorkspaceMemberRequest` | body | yes |  |

Returns `TeamMember`.

| Field | Type | |
| --- | --- | --- |
| `userId` | `String` |  |
| `name` | `String` |  |
| `email` | `String` |  |
| `status` | `TeamMemberStatus` |  |
| `role` | `TeamMemberRole` | The member's workspace role. Values are always returned in uppercase. |
| `mfaEnabled` | `bool` |  |

[Render documentation](https://api-docs.render.com/reference/update-workspace-member)

