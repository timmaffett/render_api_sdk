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
  Future<TeamMember> updateWorkspaceMember({required String ownerId, required String userId, required UpdateWorkspaceMemberRequest body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/owners/$ownerId/members/$userId',
      body: body.toJson(),
    );
    return TeamMember.fromJson(json);
  }


  /// Remove workspace member
  ///
  /// Remove a user from the specified workspace.
  Future<void> removeWorkspaceMember({required String ownerId, required String userId}) async {
    await _client.send(
      'DELETE',
      '/owners/$ownerId/members/$userId',
    );
  }


  /// List workspaces
  ///
  /// List the workspaces that your API key has access to, optionally filtered by name or owner email address.
  ///
  /// [name] Only return workspaces with one of the provided names. Only exact matches are returned.
  ///
  /// [email] Only return workspaces owned by one of the provided email addresses.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<OwnerWithCursor>> listOwners({List<String>? name, List<String>? email, String? cursor, int? limit}) async {
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
  Future<Owner> retrieveOwner({required String ownerId}) async {
    final json = await _client.sendObject(
      'GET',
      '/owners/$ownerId',
    );
    return Owner.fromJson(json);
  }


  /// List workspace members
  ///
  /// Retrieves the list of users belonging to the workspace with the provided ID.
  Future<List<TeamMember>> retrieveOwnerMembers({required String ownerId}) async {
    final json = await _client.sendList(
      'GET',
      '/owners/$ownerId/members',
    );
    return json.whereType<Map<String, Object?>>().map(TeamMember.fromJson).toList();
  }


  /// List workspace audit logs
  ///
  /// Retrieve audit logs for a specific workspace with optional filtering and pagination.
  ///
  /// [startTime] Start time for filtering audit logs (ISO 8601 format)
  ///
  /// [endTime] End time for filtering audit logs (ISO 8601 format)
  ///
  /// [direction] The direction to query logs for. Backward will return most recent logs first.
  /// Forward will start with the oldest logs in the time range.
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of audit log items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<AuditLogWithCursor>> listOwnerAuditLogs({required String ownerId, String? startTime, String? endTime, String? direction, String? cursor, int? limit}) async {
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
