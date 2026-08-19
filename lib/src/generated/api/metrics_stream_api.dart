// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/metrics-stream` endpoints.
class MetricsStreamEndpoints {
  const MetricsStreamEndpoints(this._client);

  final RenderApiClient _client;

  /// Retrieve metrics stream
  ///
  /// Returns metrics stream information for the specified workspace.
  Future<GetOwnerMetricsStreamResponse> getOwnerMetricsStream({required String ownerId}) async {
    final json = await _client.sendObject(
      'GET',
      '/metrics-stream/$ownerId',
    );
    return GetOwnerMetricsStreamResponse.fromJson(json);
  }


  /// Create or update metrics stream
  ///
  /// Creates or updates the metrics stream for the specified workspace.
  Future<UpsertOwnerMetricsStreamResponse> upsertOwnerMetricsStream({required String ownerId, required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PUT',
      '/metrics-stream/$ownerId',
      body: body,
    );
    return UpsertOwnerMetricsStreamResponse.fromJson(json);
  }


  /// Delete metrics stream
  ///
  /// Deletes the metrics stream for the specified workspace.
  Future<void> deleteOwnerMetricsStream({required String ownerId}) async {
    await _client.send(
      'DELETE',
      '/metrics-stream/$ownerId',
    );
  }


}
