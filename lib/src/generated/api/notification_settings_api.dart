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
  Future<Map<String, Object?>> retrieveOwnerNotificationSettings(String ownerId) async {
    final json = await _client.sendObject(
      'GET',
      '/notification-settings/owners/$ownerId',
    );
    return json;
  }


  /// Update notification settings
  ///
  /// Update notification settings for the owner with the provided ID.
  Future<Map<String, Object?>> patchOwnerNotificationSettings(String ownerId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/notification-settings/owners/$ownerId',
      body: body,
    );
    return json;
  }


  /// List notification overrides
  ///
  /// List notification overrides matching the provided filters. If no filters are provided, returns all notification overrides for all workspaces the user belongs to.
  Future<List<NotificationOverrideWithCursor>> listNotificationOverrides({Object? ownerId, Object? serviceId, Object? cursor, Object? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(NotificationOverrideWithCursor.fromJson).toList();
  }


  /// Retrieve notification override
  ///
  /// Retrieve the notification override for the service with the provided ID.
  ///
  /// Note that you provide a service ID to this endpoint, not the ID for a particular override.
  Future<Map<String, Object?>> retrieveServiceNotificationOverrides(String serviceId) async {
    final json = await _client.sendObject(
      'GET',
      '/notification-settings/overrides/services/$serviceId',
    );
    return json;
  }


  /// Update notification override
  ///
  /// Update the notification override for the service with the provided ID.
  Future<Map<String, Object?>> patchServiceNotificationOverrides(String serviceId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/notification-settings/overrides/services/$serviceId',
      body: body,
    );
    return json;
  }


}
