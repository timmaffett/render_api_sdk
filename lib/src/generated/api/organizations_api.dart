// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/organizations` endpoints.
class OrganizationsEndpoints {
  const OrganizationsEndpoints(this._client);

  final RenderApiClient _client;

  /// List organization audit logs
  ///
  /// Retrieve audit logs for a specific organization with optional filtering and pagination.
  Future<List<AuditLogWithCursor>> listOrganizationAuditLogs(String orgId, {Object? startTime, Object? endTime, Object? direction, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/organizations/$orgId/audit-logs',
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
