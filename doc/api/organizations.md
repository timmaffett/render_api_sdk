# Organizations

`render.raw.organizations` — 1 operation on `/organizations`.

| Method | | |
| --- | --- | --- |
| [`listOrganizationAuditLogs`](#listorganizationauditlogs) | `GET /organizations/{orgId}/audit-logs` | List organization audit logs |

---

## listOrganizationAuditLogs

**List organization audit logs**

Retrieve audit logs for a specific organization with optional filtering and pagination.


```dart
Future<List<AuditLogWithCursor>> listOrganizationAuditLogs({required String orgId, String? startTime, String? endTime, String? direction, String? cursor, int? limit})
```

`GET /organizations/{orgId}/audit-logs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `orgId` | `String` | path | yes |  |
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

[Render documentation](https://api-docs.render.com/reference/list-organization-audit-logs)

