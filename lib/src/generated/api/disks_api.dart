// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/disks` endpoints.
class DisksEndpoints {
  const DisksEndpoints(this._client);

  final RenderApiClient _client;

  /// List disks
  ///
  /// List persistent disks matching the provided filters. If no filters are provided, returns all disks you have permissions to view.
  Future<List<DiskWithCursor>> listDisks({Object? ownerId, Object? diskId, Object? name, Object? createdBefore, Object? createdAfter, Object? updatedBefore, Object? updatedAfter, Object? serviceId, Object? cursor, Object? limit}) async {
    final json = await _client.sendList(
      'GET',
      '/disks',
      query: {
        'ownerId': ownerId,
        'diskId': diskId,
        'name': name,
        'createdBefore': createdBefore,
        'createdAfter': createdAfter,
        'updatedBefore': updatedBefore,
        'updatedAfter': updatedAfter,
        'serviceId': serviceId,
        'cursor': cursor,
        'limit': limit,
      },
    );
    return json.whereType<Map<String, Object?>>().map(DiskWithCursor.fromJson).toList();
  }


  /// Add disk
  ///
  /// Attach a persistent disk to a web service, private service, or background worker.
  ///
  /// The service must be redeployed for the disk to be attached.
  Future<Map<String, Object?>> addDisk({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/disks',
      body: body,
    );
    return json;
  }


  /// Retrieve disk
  ///
  /// Retrieve the persistent disk with the provided ID.
  Future<Map<String, Object?>> retrieveDisk(String diskId) async {
    final json = await _client.sendObject(
      'GET',
      '/disks/$diskId',
    );
    return json;
  }


  /// Update disk
  ///
  /// Update the persistent disk with the provided ID.
  ///
  /// The disk's associated service must be deployed and active for updates to take effect.
  ///
  /// When resizing a disk, the new size must be greater than the current size.
  Future<Map<String, Object?>> updateDisk(String diskId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/disks/$diskId',
      body: body,
    );
    return json;
  }


  /// Delete disk
  ///
  /// Delete a persistent disk attached to a service.
  ///
  /// **All data on the disk will be lost.** The disk's associated service will immediately lose access to it.
  Future<void> deleteDisk(String diskId) async {
    await _client.send(
      'DELETE',
      '/disks/$diskId',
    );
  }


  /// List snapshots
  ///
  /// List snapshots for the persistent disk with the provided ID. Each snapshot is a point-in-time copy of the disk's data.
  Future<List<DiskSnapshot>> listSnapshots(String diskId) async {
    final json = await _client.sendList(
      'GET',
      '/disks/$diskId/snapshots',
    );
    return json.whereType<Map<String, Object?>>().map(DiskSnapshot.fromJson).toList();
  }


  /// Restore snapshot
  ///
  /// Restore a persistent disk to an available snapshot.
  ///
  /// **This operation is irreversible.** It will overwrite the current disk data. It might also trigger a service deploy.
  ///
  /// Snapshot keys returned from the [List snapshots](https://api-docs.render.com/reference/list-snapshots) endpoint expire after 24 hours. If a snapshot key has expired, query the endpoint again for a new key.
  Future<Map<String, Object?>> restoreSnapshot(String diskId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/disks/$diskId/snapshots/restore',
      body: body,
    );
    return json;
  }


}
