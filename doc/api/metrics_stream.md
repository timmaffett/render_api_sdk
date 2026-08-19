# MetricsStream

`render.raw.metricsStream` — 3 operations on `/metrics-stream`.

| Method | | |
| --- | --- | --- |
| [`deleteOwnerMetricsStream`](#deleteownermetricsstream) | `DELETE /metrics-stream/{ownerId}` | Delete metrics stream |
| [`getOwnerMetricsStream`](#getownermetricsstream) | `GET /metrics-stream/{ownerId}` | Retrieve metrics stream |
| [`upsertOwnerMetricsStream`](#upsertownermetricsstream) | `PUT /metrics-stream/{ownerId}` | Create or update metrics stream |

---

## deleteOwnerMetricsStream

**Delete metrics stream**

Deletes the metrics stream for the specified workspace.

```dart
Future<void> deleteOwnerMetricsStream({required String ownerId})
```

`DELETE /metrics-stream/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/deleteOwnerMetricsStream)

## getOwnerMetricsStream

**Retrieve metrics stream**

Returns metrics stream information for the specified workspace.

```dart
Future<GetOwnerMetricsStreamResponse> getOwnerMetricsStream({required String ownerId})
```

`GET /metrics-stream/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |

Returns `GetOwnerMetricsStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String` | The ID of the owner |
| `provider` | `Provider` | Provider to send metrics to |
| `url` | `String` | The endpoint URL to stream metrics to |

[Render documentation](https://api-docs.render.com/reference/getOwnerMetricsStream)

## upsertOwnerMetricsStream

**Create or update metrics stream**

Creates or updates the metrics stream for the specified workspace.

```dart
Future<UpsertOwnerMetricsStreamResponse> upsertOwnerMetricsStream({required String ownerId, required UpsertOwnerMetricsStreamRequest body})
```

`PUT /metrics-stream/{ownerId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `ownerId` | `String` | path | yes |  |
| `body` | `UpsertOwnerMetricsStreamRequest` | body | yes |  |

Returns `UpsertOwnerMetricsStreamResponse`.

| Field | Type | |
| --- | --- | --- |
| `ownerId` | `String` | The ID of the owner |
| `provider` | `Provider` | Provider to send metrics to |
| `url` | `String` | The endpoint URL to stream metrics to |

[Render documentation](https://api-docs.render.com/reference/upsertOwnerMetricsStream)

