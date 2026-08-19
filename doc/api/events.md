# Events

`render.raw.events` — 1 operation on `/events`.

| Method | | |
| --- | --- | --- |
| [`retrieveEvent`](#retrieveevent) | `GET /events/{eventId}` | Retrieve event |

---

## retrieveEvent

**Retrieve event**

Retrieve the details of a particular event


```dart
Future<RetrieveEventResponse> retrieveEvent({required String eventId})
```

`GET /events/{eventId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `eventId` | `String` | path | yes |  |

Returns `RetrieveEventResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `timestamp` | `DateTime` |  |
| `serviceId` | `String` |  |
| `type` | `RetrieveEventType` |  |
| `details` | `Object?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-event)

