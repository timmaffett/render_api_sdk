// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/dedicated-ips` endpoints.
class DedicatedIpsEndpoints {
  const DedicatedIpsEndpoints(this._client);

  final RenderApiClient _client;

  /// List dedicated IPs
  ///
  /// List dedicated IP sets for a workspace.
  Future<List<DedicatedIp>> listDedicatedIps({required Object? ownerId, Object? environmentId}) async {
    final json = await _client.sendList(
      'GET',
      '/dedicated-ips',
      query: {
        'ownerId': ownerId,
        'environmentId': environmentId,
      },
    );
    return json.whereType<Map<String, Object?>>().map(DedicatedIp.fromJson).toList();
  }


  /// Create dedicated IP set
  ///
  /// Create a dedicated IP set. Provisioning an IP set is asynchronous. The response returns immediately with `status: CREATING` and `ips: []`. When provisioning completes, status changes to `RUNNING` and `ips` contains your assigned addresses.
  ///
  /// If `environmentIds` is omitted or empty, this IP set applies to all services in the workspace in the selected region. Otherwise, it applies only to services in the listed environments in that region.
  Future<DedicatedIp> createDedicatedIp({required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'POST',
      '/dedicated-ips',
      body: body,
    );
    return DedicatedIp.fromJson(json);
  }


  /// Retrieve dedicated IP set
  ///
  /// Retrieve the dedicated IP set with the provided ID.
  Future<DedicatedIp> retrieveDedicatedIp(String dedicatedIpId) async {
    final json = await _client.sendObject(
      'GET',
      '/dedicated-ips/$dedicatedIpId',
    );
    return DedicatedIp.fromJson(json);
  }


  /// Update dedicated IP set
  ///
  /// Update the dedicated IP set with the provided ID. All fields are optional. Omitted fields are left unchanged. To switch from environment-scoped to workspace-scoped, provide `environmentIds: []`.
  Future<DedicatedIp> updateDedicatedIp(String dedicatedIpId, {required Map<String, Object?> body}) async {
    final json = await _client.sendObject(
      'PATCH',
      '/dedicated-ips/$dedicatedIpId',
      body: body,
    );
    return DedicatedIp.fromJson(json);
  }


  /// Delete dedicated IP set
  ///
  /// Delete the dedicated IP set with the provided ID.
  Future<void> deleteDedicatedIp(String dedicatedIpId) async {
    await _client.send(
      'DELETE',
      '/dedicated-ips/$dedicatedIpId',
    );
  }


}
