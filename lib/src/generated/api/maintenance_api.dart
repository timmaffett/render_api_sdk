// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/maintenance` endpoints.
class MaintenanceEndpoints {
  const MaintenanceEndpoints(this._client);

  final RenderApiClient _client;

  /// List maintenance runs
  ///
  /// List scheduled and/or recent maintenance runs for specified resources.
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  Future<List<ListMaintenanceResponse>> listMaintenance({
    List<String>? resourceId,
    List<String>? ownerId,
    List<String>? state,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/maintenance',
      query: {'resourceId': resourceId, 'ownerId': ownerId, 'state': state},
    );
    return json
        .whereType<Map<String, Object?>>()
        .map(ListMaintenanceResponse.fromJson)
        .toList();
  }

  /// Retrieve maintenance run
  ///
  /// Retrieve the maintenance run with the provided ID.
  Future<RetrieveMaintenanceResponse> retrieveMaintenance({
    required String maintenanceRunId,
  }) async {
    final json = await _client.sendObject(
      'GET',
      '/maintenance/$maintenanceRunId',
    );
    return RetrieveMaintenanceResponse.fromJson(json);
  }

  /// Update maintenance run
  ///
  /// Update the maintenance run with the provided ID.
  ///
  /// Updates from this endpoint are asynchronous. To check your update's status, use the [Retrieve maintenance run](https://api-docs.render.com/reference/retrieve-maintenance) endpoint.
  Future<void> updateMaintenance({
    required String maintenanceRunId,
    required UpdateMaintenanceRequest body,
  }) async {
    await _client.send(
      'PATCH',
      '/maintenance/$maintenanceRunId',
      body: body.toJson(),
    );
  }

  /// Trigger maintenance run
  ///
  /// Trigger the scheduled maintenance run with the provided ID.
  ///
  /// Triggering maintenance is asynchronous. To check whether maintenance has started, use the [Retrieve maintenance run](https://api-docs.render.com/reference/retrieve-maintenance) endpoint.
  ///
  /// As maintenance progresses, the run's `state` will change from `scheduled` to other values, such as `in_progress` and `succeeded`.
  Future<void> triggerMaintenance({required String maintenanceRunId}) async {
    await _client.send('POST', '/maintenance/$maintenanceRunId/trigger');
  }
}
