// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/projects` endpoints.
class ProjectsEndpoints {
  const ProjectsEndpoints(this._client);

  final RenderApiClient _client;

  /// List projects
  ///
  /// List projects matching the provided filters. If no filters are provided, all projects are returned.
  ///
  /// [name] Filter by name
  ///
  /// [createdBefore] Filter for resources created before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [createdAfter] Filter for resources created after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedBefore] Filter for resources updated before a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [updatedAfter] Filter for resources updated after a certain time (specified as an ISO 8601 timestamp)
  ///
  /// [ownerId] The ID of the workspaces to return resources for
  ///
  /// [cursor] The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  ///
  /// [limit] The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination).
  Future<List<ProjectWithCursor>> listProjects({
    List<String>? name,
    String? createdBefore,
    String? createdAfter,
    String? updatedBefore,
    String? updatedAfter,
    List<String>? ownerId,
    String? cursor,
    int? limit,
  }) async {
    final json = await _client.sendList(
      'GET',
      '/projects',
      query: {
        'name': name,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'ownerId': ownerId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return _client.decode(
      'GET',
      '/projects',
      json,
      () => json
          .whereType<Map<String, Object?>>()
          .map(ProjectWithCursor.fromJson)
          .toList(),
    );
  }

  /// Create project
  ///
  /// Create a new project.
  Future<Project> createProject({required ProjectPostinput body}) async {
    final json = await _client.sendObject(
      'POST',
      '/projects',
      body: body.toJson(),
    );
    return _client.decode(
      'POST',
      '/projects',
      json,
      () => Project.fromJson(json),
    );
  }

  /// Retrieve Project
  ///
  /// Retrieve the project with the provided ID.
  Future<Project> retrieveProject({required String projectId}) async {
    final json = await _client.sendObject('GET', '/projects/$projectId');
    return _client.decode(
      'GET',
      '/projects/$projectId',
      json,
      () => Project.fromJson(json),
    );
  }

  /// Update project
  ///
  /// Update the details of a project.
  ///
  /// To update the details of a particular _environment_ in the project, instead use the [Update environment](https://api-docs.render.com/reference/update-environment) endpoint.
  Future<Project> updateProject({
    required String projectId,
    required ProjectPatchinput body,
  }) async {
    final json = await _client.sendObject(
      'PATCH',
      '/projects/$projectId',
      body: body.toJson(),
    );
    return _client.decode(
      'PATCH',
      '/projects/$projectId',
      json,
      () => Project.fromJson(json),
    );
  }

  /// Delete project
  ///
  /// Delete the project with the provided ID.
  ///
  /// Requires _all_ of the project's environments to be empty (i.e., they must contain no services or other resources). Otherwise, deletion fails with a `409` response.
  ///
  /// To delete a non-empty project, do one of the following:
  /// - First move or delete all contained services and other resources.
  /// - Delete the project in the [Render Dashboard](https://dashboard.render.com).
  Future<void> deleteProject({required String projectId}) async {
    await _client.send('DELETE', '/projects/$projectId');
  }
}
