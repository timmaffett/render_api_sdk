// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/users` endpoints.
class UsersEndpoints {
  const UsersEndpoints(this._client);

  final RenderApiClient _client;

  /// Get the authenticated user
  ///
  /// Retrieve the user associated with the provided API key.
  Future<User> getUser() async {
    final json = await _client.sendObject('GET', '/users');
    return User.fromJson(json);
  }
}
