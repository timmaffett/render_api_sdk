# Webhooks

`render.raw.webhooks` — 6 operations on `/webhooks`.

| Method | | |
| --- | --- | --- |
| [`createWebhook`](#createwebhook) | `POST /webhooks` | Create a webhook |
| [`deleteWebhook`](#deletewebhook) | `DELETE /webhooks/{webhookId}` | Delete a webhook |
| [`listWebhookEvents`](#listwebhookevents) | `GET /webhooks/{webhookId}/events` | List webhook events |
| [`listWebhooks`](#listwebhooks) | `GET /webhooks` | List webhooks |
| [`retrieveWebhook`](#retrievewebhook) | `GET /webhooks/{webhookId}` | Retrieve a webhook |
| [`updateWebhook`](#updatewebhook) | `PATCH /webhooks/{webhookId}` | Update a webhook |

---

## createWebhook

**Create a webhook**

Create a new webhook.


```dart
Future<CreateWebhookResponse> createWebhook({required CreateWebhookRequest body})
```

`POST /webhooks`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `CreateWebhookRequest` | body | yes |  |

Returns `CreateWebhookResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `url` | `String` |  |
| `name` | `String` |  |
| `secret` | `String` |  |
| `enabled` | `bool` |  |
| `eventFilter` | `List<RetrieveEventType>` | The event types that will trigger the webhook. An empty list means all event types will trigger the webhook. |

[Render documentation](https://api-docs.render.com/reference/create-webhook)

## deleteWebhook

**Delete a webhook**

Delete the webhook with the provided ID.


```dart
Future<void> deleteWebhook({required String webhookId})
```

`DELETE /webhooks/{webhookId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `webhookId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-webhook)

## listWebhookEvents

**List webhook events**

Retrieve a list of events that have been sent to this webhook, with optional filtering by timestamp.


```dart
Future<List<WebhookEventWithCursor>> listWebhookEvents({required String webhookId, String? sentBefore, String? sentAfter, int? limit, String? cursor})
```

`GET /webhooks/{webhookId}/events`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `webhookId` | `String` | path | yes |  |
| `sentBefore` | `String` | query | no | Filter events sent before this time (specified as an ISO 8601 timestamp) |
| `sentAfter` | `String` | query | no | Filter for resources sent after a certain time (specified as an ISO 8601 timestamp) |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<WebhookEventWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `webhookEvent` | `WebhookEventWithCursorWebhookEvent` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-webhook-events)

## listWebhooks

**List webhooks**

```dart
Future<List<WebhookWithCursor>> listWebhooks({String? cursor, int? limit, List<String>? ownerId})
```

`GET /webhooks`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |

Returns `List<WebhookWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `webhook` | `WebhookWithCursorWebhook` |  |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-webhooks)

## retrieveWebhook

**Retrieve a webhook**

Retrieve the webhook with the provided ID

```dart
Future<RetrieveWebhookResponse> retrieveWebhook({required String webhookId})
```

`GET /webhooks/{webhookId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `webhookId` | `String` | path | yes |  |

Returns `RetrieveWebhookResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `url` | `String` |  |
| `name` | `String` |  |
| `secret` | `String` |  |
| `enabled` | `bool` |  |
| `eventFilter` | `List<RetrieveEventType>` | The event types that will trigger the webhook. An empty list means all event types will trigger the webhook. |

[Render documentation](https://api-docs.render.com/reference/retrieve-webhook)

## updateWebhook

**Update a webhook**

Update the webhook with the provided ID.


```dart
Future<UpdateWebhookResponse> updateWebhook({required String webhookId, required UpdateWebhookRequest body})
```

`PATCH /webhooks/{webhookId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `webhookId` | `String` | path | yes |  |
| `body` | `UpdateWebhookRequest` | body | yes |  |

Returns `UpdateWebhookResponse`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` |  |
| `url` | `String` |  |
| `name` | `String` |  |
| `secret` | `String` |  |
| `enabled` | `bool` |  |
| `eventFilter` | `List<RetrieveEventType>` | The event types that will trigger the webhook. An empty list means all event types will trigger the webhook. |

[Render documentation](https://api-docs.render.com/reference/update-webhook)

