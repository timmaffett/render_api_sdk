// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/events` endpoints.
class EventsEndpoints {
  const EventsEndpoints(this._client);

  final RenderApiClient _client;

  /// Retrieve event
  ///
  /// Retrieve the details of a particular event
  Future<RetrieveEventResponse> retrieveEvent({required String eventId}) async {
    final json = await _client.sendObject('GET', '/events/$eventId');
    return _client.decode(
      'GET',
      '/events/$eventId',
      json,
      () => RetrieveEventResponse.fromJson(json),
    );
  }
}
