// Unprefixed here, and prefixed everywhere Flutter is also in scope. This
// file imports no Flutter, so nothing collides; see the note on `api` in the
// README for why the pages spell it `render.Service` instead.
import 'package:render_api/render_api.dart';

/// One [RenderApi] for the whole app, plus a loader per view.
///
/// Two things about the package shape are worth seeing here, because every
/// caller meets them:
///
/// * **List endpoints return `<Thing>WithCursor`**, not `<Thing>` — the cursor
///   rides along for pagination. These loaders unwrap to the thing, since the
///   dashboard's page sizes are well under one page.
/// * **Errors are typed.** [RenderAuthException] means the token is wrong or
///   revoked and the app should sign out; [RenderApiException] may carry a
///   [RenderApiException.hint], which is worth showing verbatim — Render
///   answers 500 for cases that are not server faults, and 400 for metrics
///   that a plan simply does not include.
class RenderClient {
  RenderClient(String token) : _api = RenderApi(token: token);

  /// Wraps an API built elsewhere.
  ///
  /// `RenderApi.fromClient` takes any `http.Client`, which is how the widget
  /// tests drive these pages against canned responses without a token or a
  /// network — see `test/dashboard_test.dart`.
  RenderClient.fromApi(this._api);

  final RenderApi _api;

  void close() => _api.close();

  // --- The hierarchy: workspace -> project -> environment -> resource -------

  Future<List<Owner>> owners() async {
    final page = await _api.listOwners(limit: 50);
    return [
      for (final entry in page)
        if (entry.owner != null) entry.owner!,
    ];
  }

  Future<List<Project>> projects({String? ownerId}) async {
    final page = await _api.listProjects(
      ownerId: ownerId == null ? null : [ownerId],
      limit: 50,
    );
    return [for (final entry in page) entry.project];
  }

  Future<List<Environment>> environments(String projectId) async {
    final page = await _api.listEnvironments(projectId: [projectId], limit: 50);
    return [for (final entry in page) entry.environment];
  }

  // --- Services ------------------------------------------------------------

  /// Every service in the workspace.
  ///
  /// Note this does **not** include workflow services: `GET /services` and
  /// `GET /workflows` are disjoint sets, which looks like a missing service
  /// until you know it. See [workflows].
  Future<List<Service>> services({String? environmentId}) async {
    final page = await _api.listServices(
      environmentId: environmentId == null ? null : [environmentId],
      limit: 100,
    );
    return [for (final entry in page) entry.service];
  }

  Future<Service> service(String id) => _api.retrieveService(serviceId: id);

  Future<List<Deploy>> deploys(String serviceId) async {
    final page = await _api.listDeploys(serviceId: serviceId, limit: 20);
    return [
      for (final entry in page)
        if (entry.deploy != null) entry.deploy!,
    ];
  }

  Future<List<ServiceEventWithCursorEvent>> events(String serviceId) async {
    final page = await _api.listEvents(serviceId: serviceId, limit: 30);
    return [for (final entry in page) entry.event];
  }

  Future<List<EnvVar>> envVars(String serviceId) async {
    final page = await _api.getEnvVarsForService(
      serviceId: serviceId,
      limit: 50,
    );
    return [for (final entry in page) entry.envVar];
  }

  // --- Databases -----------------------------------------------------------

  Future<List<Postgres>> postgres() async {
    final page = await _api.listPostgres(limit: 50);
    return [for (final entry in page) entry.postgres];
  }

  Future<List<KeyValue>> keyValue() async {
    final page = await _api.listKeyValue(limit: 50);
    return [for (final entry in page) entry.keyValue];
  }

  // --- Workflows -----------------------------------------------------------
  //
  // The item types here are named <Wrapper><Field> — WorkflowWithCursorWorkflow
  // and friends — because Render's spec declares them inline inside the list
  // response rather than as named schemas, and the generator takes its names
  // from the spec. Ugly, and faithful: renaming them would break the one
  // property this package promises, that every name matches the spec.

  Future<List<WorkflowWithCursorWorkflow>> workflows() async {
    final page = await _api.listWorkflows(limit: 50);
    return [for (final entry in page) entry.workflow];
  }

  Future<List<TaskWithCursorTask>> tasks(String workflowId) async {
    final page = await _api.listTasks(workflowId: [workflowId], limit: 100);
    return [for (final entry in page) entry.task];
  }

  Future<List<TaskRunWithCursorTaskRun>> taskRuns({
    String? workflowId,
    int limit = 100,
  }) async {
    final page = await _api.listTaskRuns(
      workflowId: workflowId == null ? null : [workflowId],
      limit: limit,
    );
    return [for (final entry in page) entry.taskRun];
  }

  // --- Metrics -------------------------------------------------------------

  /// A metric, reduced to what a chart needs.
  ///
  /// Every metrics operation returns the same shape by a different name, so
  /// the pages take [MetricSeries] and do not care which call produced it.
  Future<List<MetricSeries>> cpu(
    String resourceId, {
    Duration window = _day,
  }) async {
    final raw = await _api.getCpu(
      resource: resourceId,
      startTime: _since(window),
    );
    return [for (final s in raw) MetricSeries.from(s.labels, s.values, s.unit)];
  }

  Future<List<MetricSeries>> memory(
    String resourceId, {
    Duration window = _day,
  }) async {
    final raw = await _api.getMemory(
      resource: resourceId,
      startTime: _since(window),
    );
    return [for (final s in raw) MetricSeries.from(s.labels, s.values, s.unit)];
  }

  Future<List<MetricSeries>> bandwidth(
    String resourceId, {
    Duration window = _day,
  }) async {
    final raw = await _api.getBandwidth(
      resource: resourceId,
      startTime: _since(window),
    );
    return [for (final s in raw) MetricSeries.from(s.labels, s.values, s.unit)];
  }

  /// HTTP request counts — **empty on the free plan**.
  ///
  /// Render returns 200 with no series rather than an error, so an empty chart
  /// here means "your plan does not include this", not "no traffic". Its
  /// sibling `getHttpLatency` is more honest and answers 400.
  Future<List<MetricSeries>> httpRequests(
    String resourceId, {
    Duration window = _day,
  }) async {
    final raw = await _api.getHttpRequests(
      resource: resourceId,
      startTime: _since(window),
    );
    return [for (final s in raw) MetricSeries.from(s.labels, s.values, s.unit)];
  }

  /// A metric with the instance limit it should be read against.
  ///
  /// Render's own dashboard plots CPU and memory against the plan's ceiling
  /// rather than against the data's own range, which is why an idle service
  /// there reads as a low line on a full axis instead of noise filling the
  /// frame. `getCpuLimit` and `getMemoryLimit` are what make that possible;
  /// they are separate operations, and easy to miss.
  Future<MetricChartData> cpuChart(
    String resourceId, {
    Duration window = _day,
  }) => _chart(
    series: cpu(resourceId, window: window),
    limit: _latestOf(
      () => _api.getCpuLimit(resource: resourceId, startTime: _since(window)),
    ),
  );

  Future<MetricChartData> memoryChart(
    String resourceId, {
    Duration window = _day,
  }) => _chart(
    series: memory(resourceId, window: window),
    limit: _latestOf(
      () =>
          _api.getMemoryLimit(resource: resourceId, startTime: _since(window)),
    ),
  );

  /// Bandwidth and HTTP requests have no ceiling to plot against, so their
  /// charts scale to their own data.
  Future<MetricChartData> bandwidthChart(String id, {Duration window = _day}) =>
      _chart(
        series: bandwidth(id, window: window),
        limit: Future.value(null),
      );

  Future<MetricChartData> httpRequestsChart(
    String id, {
    Duration window = _day,
  }) => _chart(
    series: httpRequests(id, window: window),
    limit: Future.value(null),
  );

  static Future<MetricChartData> _chart({
    required Future<List<MetricSeries>> series,
    required Future<double?> limit,
  }) async {
    final resolved = await series;
    return MetricChartData(
      series: resolved.where((s) => !s.isEmpty).toList(),
      limit: await limit,
      unit: resolved.isEmpty ? null : resolved.first.unit,
    );
  }

  /// The most recent value of a limit series, or null if the plan does not
  /// report one. A limit is flat, so the last point is the whole story.
  static Future<double?> _latestOf(
    Future<List<dynamic>> Function() call,
  ) async {
    try {
      for (final series in await call()) {
        final values = (series.values as List?) ?? const [];
        if (values.isNotEmpty) {
          return ((values.last as dynamic).value as num?)?.toDouble();
        }
      }
    } on RenderApiException {
      // Limits are plan-gated in the same way the HTTP metrics are; a chart
      // without one still draws, scaled to its own data.
    }
    return null;
  }

  static const _day = Duration(hours: 24);

  static String _since(Duration window) =>
      DateTime.now().toUtc().subtract(window).toIso8601String();
}

/// Everything one chart needs: its lines, and the ceiling to draw them against.
class MetricChartData {
  const MetricChartData({required this.series, this.limit, this.unit});

  final List<MetricSeries> series;

  /// The instance's ceiling — cores for CPU, bytes for memory. Null when the
  /// plan does not report one, in which case the chart scales to its own data.
  final double? limit;

  final String? unit;

  bool get isEmpty => series.every((s) => s.isEmpty);
}

/// One line on a chart.
class MetricSeries {
  const MetricSeries({required this.label, required this.points, this.unit});

  factory MetricSeries.from(
    List<Object?>? labels,
    List<Object?>? values,
    String? unit,
  ) {
    // Labels are {field, value} pairs, and Render repeats the resource id
    // across several of them — service, resource and instance all carry it,
    // with the instance value having the service id as its prefix. Joining
    // them raw gave "srv-abc-drv8w · srv-abc · srv-abc" on every chart.
    // Keeping the longest distinct value leaves the one that actually
    // identifies this series, which for a multi-instance service is the
    // instance.
    final labelValues =
        {
            for (final label in labels ?? const [])
              (label as dynamic).value?.toString() ?? '',
          }.where((value) => value.isNotEmpty).toList()
          ..sort((a, b) => b.length.compareTo(a.length));

    return MetricSeries(
      label: labelValues.isEmpty ? 'value' : labelValues.first,
      unit: unit,
      points: _withoutLeadingSpike([
        for (final v in values ?? const [])
          if ((v as dynamic).timestamp != null)
            MetricPoint(
              (v as dynamic).timestamp as DateTime,
              ((v as dynamic).value as num?)?.toDouble() ?? 0,
            ),
      ]),
    );
  }

  /// Drops a leading sample that is an artifact rather than a reading.
  ///
  /// CPU is a rate, and the first sample of a series has nothing before it to
  /// compute that rate against, so it comes back inflated. Measured on a live
  /// Postgres instance: the first point was 3.08e-2 against a median of
  /// 5.12e-3 and a maximum across the *other 1095 points* of 7.52e-3 — four
  /// times the highest real reading. Scaled to it, every real value sat in the
  /// bottom eighth of the chart and the line looked flat.
  ///
  /// Confirmed to be an artifact rather than a real event two ways: it is a
  /// single isolated sample where real work shows as sustained elevation
  /// across many, and it stays pinned to the first sample of available history
  /// no matter what `startTime` is asked for.
  ///
  /// Deliberately not "drop the first N points". It removes at most two, only
  /// from the front, and only while a point towers over the rest — so a
  /// genuine opening spike is kept on a short series, and a gauge like memory,
  /// which has no such artifact, is never touched.
  static List<MetricPoint> _withoutLeadingSpike(List<MetricPoint> points) {
    const minimumLength = 10;
    const outlierFactor = 2.0;
    const maximumDropped = 2;

    var result = points;
    for (var dropped = 0; dropped < maximumDropped; dropped++) {
      if (result.length < minimumLength) break;
      final rest = result.skip(1).map((point) => point.value).toList()..sort();
      final p99 = rest[(rest.length * 0.99).floor().clamp(0, rest.length - 1)];
      if (p99 <= 0 || result.first.value <= p99 * outlierFactor) break;
      result = result.sublist(1);
    }
    return result;
  }

  final String label;
  final String? unit;
  final List<MetricPoint> points;

  bool get isEmpty => points.isEmpty;

  double get max => points.isEmpty
      ? 0
      : points.map((p) => p.value).reduce((a, b) => a > b ? a : b);

  double get latest => points.isEmpty ? 0 : points.last.value;

  double get min => points.isEmpty
      ? 0
      : points.map((p) => p.value).reduce((a, b) => a < b ? a : b);

  /// The latest reading, scaled to a unit a person can read.
  ///
  /// Render reports memory in bytes and CPU in cores, so the raw numbers are
  /// "60145664.0 bytes" and "0.0 cpu" — one unreadable, the other rounded away
  /// entirely, since a mostly-idle service uses a few thousandths of a core.
  String get formattedLatest => switch (unit) {
    'bytes' => _bytes(latest),
    // Render reports CPU in cores, and an idle free instance sits in the
    // thousandths — "0.000 cores" at three decimals, which reads as broken.
    // Millicores keep it legible without inventing precision.
    'cpu' =>
      latest < 0.1
          ? '${(latest * 1000).toStringAsFixed(1)} mCPU'
          : '${latest.toStringAsFixed(2)} cores',
    'mb' => '${latest.toStringAsFixed(1)} MB',
    final other =>
      '${latest.toStringAsFixed(1)}${other == null ? '' : ' $other'}',
  };

  static String _bytes(double value) {
    if (value >= 1e9) return '${(value / 1e9).toStringAsFixed(2)} GB';
    if (value >= 1e6) return '${(value / 1e6).toStringAsFixed(1)} MB';
    if (value >= 1e3) return '${(value / 1e3).toStringAsFixed(1)} kB';
    return '${value.toStringAsFixed(0)} B';
  }
}

class MetricPoint {
  const MetricPoint(this.at, this.value);

  final DateTime at;
  final double value;
}
