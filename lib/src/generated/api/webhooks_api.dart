// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/webhooks` endpoints.
class WebhooksEndpoints {
  const WebhooksEndpoints(this._client);

  final RenderApiClient _client;

  /// List webhooks
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  Future<List<WebhookWithCursor>> listWebhooks({String? cursor, int? limit, List<String>? ownerId}) async {
    final json = await _client.sendList(
      'GET',
      '/webhooks',
      query: {
        'cursor': cursor,
        'limit': limit,
        'ownerId': ownerId,
      },
    );
    return json.whereType<Map<String, Object?>>().map(WebhookWithCursor.fromJson).toList();
  }


  /// Create a webhook
  ///
  /// Create a new webhook.
  Future<CreateWebhookResponse> createWebhook({required CreateWebhookRequest body}) async {
    final json = await _client.sendObject(
      'POST',
      '/webhooks',
      body: body.toJson(),
    );
    return CreateWebhookResponse.fromJson(json);
  }


  /// Retrieve a webhook
  ///
  /// Retrieve the webhook with the provided ID
  Future<RetrieveWebhookResponse> retrieveWebhook({required String webhookId}) async {
    final json = await _client.sendObject(
      'GET',
      '/webhooks/$webhookId',
    );
    return RetrieveWebhookResponse.fromJson(json);
  }


  /// Update a webhook
  ///
  /// Update the webhook with the provided ID.
  Future<UpdateWebhookResponse> updateWebhook({required String webhookId, required UpdateWebhookRequest body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/webhooks/$webhookId',
      body: body.toJson(),
    );
    return UpdateWebhookResponse.fromJson(json);
  }


  /// Delete a webhook
  ///
  /// Delete the webhook with the provided ID.
  Future<void> deleteWebhook({required String webhookId}) async {
    await _client.send(
      'DELETE',
      '/webhooks/$webhookId',
    );
  }


  /// List webhook events
  ///
  /// Retrieve a list of events that have been sent to this webhook, with optional filtering by timestamp.
  ///
  /// [sentBefore] Filter events sent before this time (specified as an ISO 8601 timestamp)
  ///
  /// [sentAfter] Filter for resources sent after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<WebhookEventWithCursor>> listWebhookEvents({required String webhookId, String? sentBefore, String? sentAfter, int? limit, String? cursor}) async {
    final json = await _client.sendList(
      'GET',
      '/webhooks/$webhookId/events',
      query: {
        'sentBefore': sentBefore,
        'sentAfter': sentAfter,
        'limit': limit,
        'cursor': cursor,
      },
    );
    return json.whereType<Map<String, Object?>>().map(WebhookEventWithCursor.fromJson).toList();
  }


}
