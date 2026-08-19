// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/postgres` endpoints.
class PostgresEndpoints {
  const PostgresEndpoints(this._client);

  final RenderApiClient _client;

  /// List Postgres instances
  ///
  /// List Postgres instances matching the provided filters. If no filters are provided, all Postgres instances are returned.
  Future<List<PostgresWithCursor>> listPostgres({Object? name, Object? region, Object? suspended, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? environmentId, Object? includeReplicas, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/postgres',
      query: {
        'name': name,
        'region': region,
        'suspended': suspended,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'ownerId': ownerId,
        'environmentId': environmentId,
        'includeReplicas': includeReplicas,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(PostgresWithCursor.fromJson).toList();
  }


  /// Create Postgres instance
  ///
  /// Create a new Postgres instance.
  Future<PostgresDetail> createPostgres({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/postgres',
      body: body,
    );
    return PostgresDetail.fromJson(json);
  }


  /// Retrieve Postgres instance
  ///
  /// Retrieve a Postgres instance by ID.
  Future<PostgresDetail> retrievePostgres(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId',
    );
    return PostgresDetail.fromJson(json);
  }


  /// Update Postgres instance
  ///
  /// Update a Postgres instance by ID.
  Future<PostgresDetail> updatePostgres(String postgresId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/postgres/$postgresId',
      body: body,
    );
    return PostgresDetail.fromJson(json);
  }


  /// Delete Postgres instance
  ///
  /// Delete a Postgres instance by ID. This operation is irreversible, and
  /// all data will be lost.
  Future<void> deletePostgres(String postgresId) async {
    await _client.send(
      'DELETE',
      '/postgres/$postgresId',
    );
  }


  /// Retrieve Postgres connection info
  ///
  /// Retrieve connection info for a Postgres instance by ID. Connection info includes sensitive information.
  Future<PostgresConnectionInfo> retrievePostgresConnectionInfo(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/connection-info',
    );
    return PostgresConnectionInfo.fromJson(json);
  }


  /// Retrieve point-in-time recovery status
  ///
  /// Retrieve information on the availability of Postgres point-in-time recovery for a Postgres instance by ID.
  Future<Map<String, Object?>> retrievePostgresRecoveryInfo(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/recovery',
    );
    return json;
  }


  /// Trigger point-in-time recovery
  ///
  /// Trigger [point-in-time recovery](https://render.com/docs/postgresql-backups) on the Postgres instance with the provided ID.
  Future<PostgresDetail> recoverPostgres(String postgresId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/postgres/$postgresId/recovery',
      body: body,
    );
    return PostgresDetail.fromJson(json);
  }


  /// Suspend Postgres instance
  ///
  /// Suspend a Postgres instance by ID.
  Future<void> suspendPostgres(String postgresId) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/suspend',
    );
  }


  /// Resume Postgres instance
  ///
  /// Resume a Postgres instance by ID.
  Future<void> resumePostgres(String postgresId) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/resume',
    );
  }


  /// Restart Postgres instance
  ///
  /// Restart a Postgres instance by ID.
  Future<void> restartPostgres(String postgresId) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/restart',
    );
  }


  /// Failover Postgres instance
  ///
  /// Failover a [highly available Postgres](https://render.com/docs/postgresql-high-availability) instance.
  Future<void> failoverPostgres(String postgresId) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/failover',
    );
  }


  /// List Postgres exports
  ///
  /// List [exports](https://render.com/docs/postgresql-backups#logical-backups) for a Postgres instance by ID. Returns a URL to download the export.
  Future<List<Object?>> listPostgresExport(String postgresId) async {
    final json = await _client.sendList(
      'GET',
      '/postgres/$postgresId/export',
    );
    return json;
  }


  /// Create Postgres export
  ///
  /// Create an [export](https://render.com/docs/postgresql-backups#logical-backups) of a Postgres instance by ID.
  Future<void> createPostgresExport(String postgresId) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/export',
    );
  }


  /// List PostgreSQL Users
  ///
  /// List PostgreSQL users for the Render Postgres instance with the provided ID.
  Future<List<Object?>> listPostgresUsers(String postgresId) async {
    final json = await _client.sendList(
      'GET',
      '/postgres/$postgresId/credentials',
    );
    return json;
  }


  /// Create PostgreSQL User
  ///
  /// Create a new PostgreSQL user for the Render Postgres instance with the provided ID. This becomes the database's new "default" user.
  Future<void> createPostgresUser(String postgresId, {required Map<String, Object?> body}) async {
    await _client.send(
      'POST',
      '/postgres/$postgresId/credentials',
      body: body,
    );
  }


  /// Delete PostgreSQL User
  ///
  /// Delete a PostgreSQL user from the Render Postgres instance with the provided ID.
  Future<void> deletePostgresUser(String postgresId, String username) async {
    await _client.send(
      'DELETE',
      '/postgres/$postgresId/credentials/$username',
    );
  }


  /// List live queries
  ///
  /// List currently running queries (from `pg_stat_activity`) on a Postgres instance by ID.
  Future<Map<String, Object?>> listPostgresProcesses(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/query/processes',
    );
    return json;
  }


  /// List top queries
  ///
  /// List the top 50 queries by total execution time (from `pg_stat_statements`) on a Postgres instance by ID.
  Future<Map<String, Object?>> listPostgresTopQueries(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/query/top-queries',
    );
    return json;
  }


  /// List database, table, and index sizes
  ///
  /// List the sizes of databases, tables, and indexes on a Postgres instance by ID.
  Future<Map<String, Object?>> listPostgresSizes(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/query/sizes',
    );
    return json;
  }


  /// List table scans
  ///
  /// List the number of sequential scans performed against each table on a Postgres instance by ID.
  Future<Map<String, Object?>> listPostgresTableScans(String postgresId) async {
    final json = await _client.sendObject(
      'GET',
      '/postgres/$postgresId/query/table-scans',
    );
    return json;
  }


}
