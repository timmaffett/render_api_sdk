# NotificationSettings

`render.raw.notificationSettings` — 5 operations on `/notification-settings`.

| Method | | |
| --- | --- | --- |
| [`listNotificationOverrides`](#listnotificationoverrides) | `GET /notification-settings/overrides` | List notification overrides |
| [`patchOwnerNotificationSettings`](#patchownernotificationsettings) | `PATCH /notification-settings/owners/{ownerId}` | Update notification settings |
| [`patchServiceNotificationOverrides`](#patchservicenotificationoverrides) | `PATCH /notification-settings/overrides/services/{serviceId}` | Update notification override |
| [`retrieveOwnerNotificationSettings`](#retrieveownernotificationsettings) | `GET /notification-settings/owners/{ownerId}` | Retrieve notification settings |
| [`retrieveServiceNotificationOverrides`](#retrieveservicenotificationoverrides) | `GET /notification-settings/overrides/services/{serviceId}` | Retrieve notification override |

---

## listNotificationOverrides

**List notification overrides**

List notification overrides matching the provided filters. If no filters are provided, returns all notification overrides for all workspaces the user belongs to.


```dart
Future<List<NotificationOverrideWithCursor>> listNotificationOverrides({List<String>? ownerId, List<String>? serviceId, String? cursor, int? limit})
```

`GET /notification-settings/overrides`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `serviceId` | `List<String>` | query | no | Filter for resources by service ID |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<NotificationOverrideWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `override` | `NotificationOverrideWithCursorOverride` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-notification-overrides)

## patchOwnerNotificationSettings

**Update notification settings**

Update notification settings for the owner with the provided ID.


```dart
Future<PatchOwnerNotificationSettingsResponse> patchOwnerNotificationSettings({required String ownerId, required PatchOwnerNotificationSettingsRequest body})
```

`PATCH /notification-settings/owners/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `body` | `PatchOwnerNotificationSettingsRequest` | body | yes |  |

Returns `PatchOwnerNotificationSettingsResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String` |  |
| `slackEnabled` | `bool` |  |
| `emailEnabled` | `bool` |  |
| `previewNotificationsEnabled` | `bool` |  |
| `notificationsToSend` | `NotificationsToSend` |  |

[Render documentation](https://api-docs.render.com/reference/patch-owner-notification-settings)

## patchServiceNotificationOverrides

**Update notification override**

Update the notification override for the service with the provided ID.


```dart
Future<PatchServiceNotificationOverridesResponse> patchServiceNotificationOverrides({required String serviceId, required PatchServiceNotificationOverridesRequest body})
```

`PATCH /notification-settings/overrides/services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |
| `body` | `PatchServiceNotificationOverridesRequest` | body | yes |  |

Returns `PatchServiceNotificationOverridesResponse`.

| Field | Type | |
| --- | --- | --- |
| `serviceId` | `String` |  |
| `previewNotificationsEnabled` | `PreviewNotificationsEnabled` |  |
| `notificationsToSend` | `PatchServiceNotificationOverridesNotificationsToSend` |  |

[Render documentation](https://api-docs.render.com/reference/patch-service-notification-overrides)

## retrieveOwnerNotificationSettings

**Retrieve notification settings**

Retrieve notification settings for the owner with the provided ID.

Note that you provide an owner ID to this endpoint, not the ID for a particular resource.


```dart
Future<RetrieveOwnerNotificationSettingsResponse> retrieveOwnerNotificationSettings({required String ownerId})
```

`GET /notification-settings/owners/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `RetrieveOwnerNotificationSettingsResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String` |  |
| `slackEnabled` | `bool` |  |
| `emailEnabled` | `bool` |  |
| `previewNotificationsEnabled` | `bool` |  |
| `notificationsToSend` | `NotificationsToSend` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-owner-notification-settings)

## retrieveServiceNotificationOverrides

**Retrieve notification override**

Retrieve the notification override for the service with the provided ID.

Note that you provide a service ID to this endpoint, not the ID for a particular override.


```dart
Future<RetrieveServiceNotificationOverridesResponse> retrieveServiceNotificationOverrides({required String serviceId})
```

`GET /notification-settings/overrides/services/{serviceId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `serviceId` | `String` | path | yes |  |

Returns `RetrieveServiceNotificationOverridesResponse`.

| Field | Type | |
| --- | --- | --- |
| `serviceId` | `String` |  |
| `previewNotificationsEnabled` | `PreviewNotificationsEnabled` |  |
| `notificationsToSend` | `PatchServiceNotificationOverridesNotificationsToSend` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-service-notification-overrides)

