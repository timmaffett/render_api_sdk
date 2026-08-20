// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../../client.dart';
import '../models.dart';

/// Generated bindings for the `/cron-jobs` endpoints.
class CronJobsEndpoints {
  const CronJobsEndpoints(this._client);

  final RenderApiClient _client;

  /// Trigger cron job run
  ///
  /// Trigger a run for a cron job and cancel any active runs.
  Future<CronJobRun> runCronJob({required String cronJobId}) async {
    final json = await _client.sendObject('POST', '/cron-jobs/$cronJobId/runs');
    return CronJobRun.fromJson(json);
  }

  /// Cancel running cron job
  ///
  /// Cancel a currently running cron job.
  Future<void> cancelCronJobRun({required String cronJobId}) async {
    await _client.send('DELETE', '/cron-jobs/$cronJobId/runs');
  }
}
