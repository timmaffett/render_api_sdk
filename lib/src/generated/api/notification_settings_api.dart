// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/notification-settings` endpoints.
class NotificationSettingsEndpoints {
  const NotificationSettingsEndpoints(this._client);

  final RenderApiClient _client;

  /// Retrieve notification settings
  ///
  /// Retrieve notification settings for the owner with the provided ID.
  ///
  /// Note that you provide an owner ID to this endpoint, not the ID for a particular resource.
  Future<RetrieveOwnerNotificationSettingsResponse>
  retrieveOwnerNotificationSettings({required String ownerId}) async {
    final json = await _client.sendObject(
      'GET',
      '/notification-settings/owners/$ownerId',
    );
    return RetrieveOwnerNotificationSettingsResponse.fromJson(json);
  }

  /// Update notification settings
  ///
  /// Update notification settings for the owner with the provided ID.
  Future<PatchOwnerNotificationSettingsResponse>
  patchOwnerNotificationSettings({
    required String ownerId,
    required PatchOwnerNotificationSettingsRequest body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/notification-settings/owners/$ownerId',
      body: body.toJson(),
    );
    return PatchOwnerNotificationSettingsResponse.fromJson(json);
  }

  /// List notification overrides
  ///
  /// List notification overrides matching the provided filters. If no filters are provided, returns all notification overrides for all workspaces the user belongs to.
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [serviceId] Filter for resources by service ID
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<NotificationOverrideWithCursor>> listNotificationOverrides({
    List<String>? ownerId,
    List<String>? serviceId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/notification-settings/overrides',
      query: {
        'ownerId': ownerId,
        'serviceId': serviceId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json
        .whereType<Map<String, Object?>>()
        .map(NotificationOverrideWithCursor.fromJson)
        .toList();
  }

  /// Retrieve notification override
  ///
  /// Retrieve the notification override for the service with the provided ID.
  ///
  /// Note that you provide a service ID to this endpoint, not the ID for a particular override.
  Future<RetrieveServiceNotificationOverridesResponse>
  retrieveServiceNotificationOverrides({required String serviceId}) async {
    final json = await _client.sendObject(
      'GET',
      '/notification-settings/overrides/services/$serviceId',
    );
    return RetrieveServiceNotificationOverridesResponse.fromJson(json);
  }

  /// Update notification override
  ///
  /// Update the notification override for the service with the provided ID.
  Future<PatchServiceNotificationOverridesResponse>
  patchServiceNotificationOverrides({
    required String serviceId,
    required PatchServiceNotificationOverridesRequest body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/notification-settings/overrides/services/$serviceId',
      body: body.toJson(),
    );
    return PatchServiceNotificationOverridesResponse.fromJson(json);
  }
}
