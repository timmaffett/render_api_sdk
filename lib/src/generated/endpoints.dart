// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json

import '../client.dart';
import 'api/blueprints_api.dart';
import 'api/cron_jobs_api.dart';
import 'api/dedicated_ips_api.dart';
import 'api/disks_api.dart';
import 'api/env_groups_api.dart';
import 'api/environments_api.dart';
import 'api/events_api.dart';
import 'api/key_value_api.dart';
import 'api/logs_api.dart';
import 'api/maintenance_api.dart';
import 'api/metrics_api.dart';
import 'api/metrics_stream_api.dart';
import 'api/notification_settings_api.dart';
import 'api/organizations_api.dart';
import 'api/owners_api.dart';
import 'api/postgres_api.dart';
import 'api/projects_api.dart';
import 'api/redis_api.dart';
import 'api/registrycredentials_api.dart';
import 'api/services_api.dart';
import 'api/task_runs_api.dart';
import 'api/tasks_api.dart';
import 'api/users_api.dart';
import 'api/webhooks_api.dart';
import 'api/workflows_api.dart';
import 'api/workflowversions_api.dart';

/// Every endpoint in the Render API, generated from the spec.
///
/// Complete but literal. Where this package offers a
/// hand-written facade — `RenderApi.workflows` and friends —
/// prefer it: those add pagination as a Stream, local
/// validation, and errors that explain themselves.
class RenderEndpoints {
  RenderEndpoints(RenderApiClient client)
    : blueprints = BlueprintsEndpoints(client),
      cronJobs = CronJobsEndpoints(client),
      dedicatedIps = DedicatedIpsEndpoints(client),
      disks = DisksEndpoints(client),
      envGroups = EnvGroupsEndpoints(client),
      environments = EnvironmentsEndpoints(client),
      events = EventsEndpoints(client),
      keyValue = KeyValueEndpoints(client),
      logs = LogsEndpoints(client),
      maintenance = MaintenanceEndpoints(client),
      metrics = MetricsEndpoints(client),
      metricsStream = MetricsStreamEndpoints(client),
      notificationSettings = NotificationSettingsEndpoints(client),
      organizations = OrganizationsEndpoints(client),
      owners = OwnersEndpoints(client),
      postgres = PostgresEndpoints(client),
      projects = ProjectsEndpoints(client),
      redis = RedisEndpoints(client),
      registrycredentials = RegistrycredentialsEndpoints(client),
      services = ServicesEndpoints(client),
      taskRuns = TaskRunsEndpoints(client),
      tasks = TasksEndpoints(client),
      users = UsersEndpoints(client),
      webhooks = WebhooksEndpoints(client),
      workflows = WorkflowsEndpoints(client),
      workflowversions = WorkflowversionsEndpoints(client);

  /// `/blueprints` endpoints.
  final BlueprintsEndpoints blueprints;

  /// `/cron-jobs` endpoints.
  final CronJobsEndpoints cronJobs;

  /// `/dedicated-ips` endpoints.
  final DedicatedIpsEndpoints dedicatedIps;

  /// `/disks` endpoints.
  final DisksEndpoints disks;

  /// `/env-groups` endpoints.
  final EnvGroupsEndpoints envGroups;

  /// `/environments` endpoints.
  final EnvironmentsEndpoints environments;

  /// `/events` endpoints.
  final EventsEndpoints events;

  /// `/key-value` endpoints.
  final KeyValueEndpoints keyValue;

  /// `/logs` endpoints.
  final LogsEndpoints logs;

  /// `/maintenance` endpoints.
  final MaintenanceEndpoints maintenance;

  /// `/metrics` endpoints.
  final MetricsEndpoints metrics;

  /// `/metrics-stream` endpoints.
  final MetricsStreamEndpoints metricsStream;

  /// `/notification-settings` endpoints.
  final NotificationSettingsEndpoints notificationSettings;

  /// `/organizations` endpoints.
  final OrganizationsEndpoints organizations;

  /// `/owners` endpoints.
  final OwnersEndpoints owners;

  /// `/postgres` endpoints.
  final PostgresEndpoints postgres;

  /// `/projects` endpoints.
  final ProjectsEndpoints projects;

  /// `/redis` endpoints.
  final RedisEndpoints redis;

  /// `/registrycredentials` endpoints.
  final RegistrycredentialsEndpoints registrycredentials;

  /// `/services` endpoints.
  final ServicesEndpoints services;

  /// `/task-runs` endpoints.
  final TaskRunsEndpoints taskRuns;

  /// `/tasks` endpoints.
  final TasksEndpoints tasks;

  /// `/users` endpoints.
  final UsersEndpoints users;

  /// `/webhooks` endpoints.
  final WebhooksEndpoints webhooks;

  /// `/workflows` endpoints.
  final WorkflowsEndpoints workflows;

  /// `/workflowversions` endpoints.
  final WorkflowversionsEndpoints workflowversions;
}
