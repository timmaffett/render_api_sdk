// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/owners` endpoints.
class OwnersEndpoints {
  const OwnersEndpoints(this._client);

  final RenderApiClient _client;

  /// Update workspace member role
  ///
  /// Update the role of an existing workspace member.
  Future<TeamMember> updateWorkspaceMember(String ownerId, String userId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/owners/$ownerId/members/$userId',
      body: body,
    );
    return TeamMember.fromJson(json);
  }


  /// Remove workspace member
  ///
  /// Remove a user from the specified workspace.
  Future<void> removeWorkspaceMember(String ownerId, String userId) async {
    await _client.send(
      'DELETE',
      '/owners/$ownerId/members/$userId',
    );
  }


  /// List workspaces
  ///
  /// List the workspaces that your API key has access to, optionally filtered by name or owner email address.
  Future<List<OwnerWithCursor>> listOwners({Object? name, Object? email, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/owners',
      query: {
        'name': name,
        'email': email,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(OwnerWithCursor.fromJson).toList();
  }


  /// Retrieve workspace
  ///
  /// Retrieve the workspace with the provided ID.
  ///
  /// Workspace IDs start with `tea-`. If you provide a user ID (starts with `own-`), this endpoint returns the user's default workspace.
  Future<Owner> retrieveOwner(String ownerId) async {
    final json = await _client.sendObject(
      'GET',
      '/owners/$ownerId',
    );
    return Owner.fromJson(json);
  }


  /// List workspace members
  ///
  /// Retrieves the list of users belonging to the workspace with the provided ID.
  Future<List<TeamMember>> retrieveOwnerMembers(String ownerId) async {
    final json = await _client.sendList(
      'GET',
      '/owners/$ownerId/members',
    );
    return json.whereType<Map<String, Object?>>().map(TeamMember.fromJson).toList();
  }


  /// List workspace audit logs
  ///
  /// Retrieve audit logs for a specific workspace with optional filtering and pagination.
  Future<List<AuditLogWithCursor>> listOwnerAuditLogs(String ownerId, {Object? startTime, Object? endTime, Object? direction, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/owners/$ownerId/audit-logs',
      query: {
        'startTime': startTime,
        'endTime': endTime,
        'direction': direction,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(AuditLogWithCursor.fromJson).toList();
  }


}
