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
  Future<List<AuditLogWithCursor>> listOrganizationAuditLogs({required String orgId, String? startTime, String? endTime, String? direction, String? cursor, int? limit}) async {
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
