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
  Future<List<ProjectWithCursor>> listProjects({Object? name, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? ownerId, Object? cursor, Object? limit}) async {
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
    return json.whereType<Map<String, Object?>>().map(ProjectWithCursor.fromJson).toList();
  }


  /// Create project
  ///
  /// Create a new project.
  Future<Project> createProject({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/projects',
      body: body,
    );
    return Project.fromJson(json);
  }


  /// Retrieve Project
  ///
  /// Retrieve the project with the provided ID.
  Future<Project> retrieveProject(String projectId) async {
    final json = await _client.sendObject(
      'GET',
      '/projects/$projectId',
    );
    return Project.fromJson(json);
  }


  /// Update project
  ///
  /// Update the details of a project.
  ///
  /// To update the details of a particular _environment_ in the project, instead use the [Update environment](https://api-docs.render.com/reference/update-environment) endpoint.
  Future<Project> updateProject(String projectId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/projects/$projectId',
      body: body,
    );
    return Project.fromJson(json);
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
  Future<void> deleteProject(String projectId) async {
    await _client.send(
      'DELETE',
      '/projects/$projectId',
    );
  }


}
