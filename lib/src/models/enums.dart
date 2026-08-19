/// Enumerations mirroring the Render API spec.
///
/// Every enum here decodes unknown values rather than throwing. Render
/// documents Workflows as beta with breaking changes expected, so a value the
/// spec doesn't list yet must not crash a client that is otherwise fine.
library;

/// Lifecycle of a task run.
///
/// Note that the API defines *both* `completed` and `succeeded`. Rather than
/// guess which one a given endpoint returns, treat terminality as data — see
/// [isTerminal].
enum TaskRunStatus {
  pending('pending'),
  running('running'),
  completed('completed'),
  succeeded('succeeded'),
  failed('failed'),
  canceled('canceled'),
  paused('paused'),

  /// A status this package does not recognise. Check [TaskRunStatus.raw] via
  /// the originating model's `rawStatus` if you need the literal value.
  unknown('');

  const TaskRunStatus(this.wireValue);

  final String wireValue;

  /// Whether the run has finished and will not change again.
  bool get isTerminal => switch (this) {
        completed || succeeded || failed || canceled => true,
        pending || running || paused || unknown => false,
      };

  /// Whether the run finished without error.
  bool get isSuccess => this == completed || this == succeeded;

  static TaskRunStatus fromWire(String? value) => values.firstWhere(
        (s) => s.wireValue == value,
        orElse: () => unknown,
      );
}

/// Language runtime a workflow builds and runs under.
///
/// Render has no Dart runtime; Dart workflows deploy as [node] with the Dart
/// compiled to JavaScript. Docker-based workflows exist but cannot be created
/// through the API or CLI, so no value is defined for them here.
enum WorkflowRuntime {
  elixir('elixir'),
  go('go'),
  node('node'),
  python('python'),
  ruby('ruby'),
  unknown('');

  const WorkflowRuntime(this.wireValue);

  final String wireValue;

  static WorkflowRuntime fromWire(String? value) => values.firstWhere(
        (r) => r.wireValue == value,
        orElse: () => unknown,
      );
}

/// Region a workflow's task runs execute in. Determines which of your other
/// Render services they can reach over the private network.
enum Region {
  frankfurt('frankfurt'),
  ohio('ohio'),
  oregon('oregon'),
  singapore('singapore'),
  virginia('virginia'),
  unknown('');

  const Region(this.wireValue);

  final String wireValue;

  static Region fromWire(String? value) => values.firstWhere(
        (r) => r.wireValue == value,
        orElse: () => unknown,
      );
}

/// When Render should automatically deploy a new workflow version.
enum AutoDeployTrigger {
  commit('commit'),
  checksPass('checksPass'),
  off('off'),
  unknown('');

  const AutoDeployTrigger(this.wireValue);

  final String wireValue;

  static AutoDeployTrigger fromWire(String? value) => values.firstWhere(
        (t) => t.wireValue == value,
        orElse: () => unknown,
      );
}

/// Build and registration lifecycle of a workflow version.
enum WorkflowVersionStatus {
  created('created'),
  building('building'),
  registering('registering'),
  buildFailed('build_failed'),
  registrationFailed('registration_failed'),
  ready('ready'),
  unknown('');

  const WorkflowVersionStatus(this.wireValue);

  final String wireValue;

  bool get isTerminal => switch (this) {
        ready || buildFailed || registrationFailed => true,
        created || building || registering || unknown => false,
      };

  bool get isSuccess => this == ready;

  static WorkflowVersionStatus fromWire(String? value) => values.firstWhere(
        (s) => s.wireValue == value,
        orElse: () => unknown,
      );
}

/// Instance size a task run executes on.
///
/// `proPlus`, `proMax` and `proUltra` require requesting access for your
/// workspace before they can be used.
enum TaskPlan {
  starter('starter'),
  standard('standard'),
  pro('pro'),
  proPlus('pro_plus'),
  proMax('pro_max'),
  proUltra('pro_ultra');

  const TaskPlan(this.wireValue);

  final String wireValue;
}
