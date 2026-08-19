# CronJobs

`render.raw.cronJobs` — 2 operations on `/cron-jobs`.

| Method | | |
| --- | --- | --- |
| [`cancelCronJobRun`](#cancelcronjobrun) | `DELETE /cron-jobs/{cronJobId}/runs` | Cancel running cron job |
| [`runCronJob`](#runcronjob) | `POST /cron-jobs/{cronJobId}/runs` | Trigger cron job run |

---

## cancelCronJobRun

**Cancel running cron job**

Cancel a currently running cron job.

```dart
Future<void> cancelCronJobRun({required String cronJobId})
```

`DELETE /cron-jobs/{cronJobId}/runs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `cronJobId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/cancel-cron-job-run)

## runCronJob

**Trigger cron job run**

Trigger a run for a cron job and cancel any active runs.

```dart
Future<CronJobRun> runCronJob({required String cronJobId})
```

`POST /cron-jobs/{cronJobId}/runs`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `cronJobId` | `String` | path | yes |  |

Returns `CronJobRun`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the run |
| `status` | `CronJobRunStatus` |  |
| `startedAt` | `DateTime?` |  |
| `finishedAt` | `DateTime?` |  |
| `triggeredBy` | `String?` | user who triggered the cron job run |
| `canceledBy` | `String?` | user who cancelled the cron job run |

[Render documentation](https://api-docs.render.com/reference/run-cron-job)

