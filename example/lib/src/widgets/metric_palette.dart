import 'package:flutter/material.dart';

import '../design/adaptive_scheme.dart';

/// The metrics a resource reports, each with a colour it keeps everywhere.
///
/// The colour is the identity. On the overview chart it is the only way to tell
/// four overlaid lines apart, and carrying the same colour onto each detail
/// chart means the reader does not have to re-learn the mapping one screen
/// later.
///
/// Colours come from [AdaptiveScheme] rather than being hardcoded, so they
/// follow the accent, the light/dark setting, and now the design system too —
/// gold under Auris, whatever Fluent's accent is under Fluent.
enum MetricKind {
  cpu('CPU'),
  memory('MEMORY'),
  disk('DISK'),
  connections('CONNECTIONS');

  const MetricKind(this.label);

  final String label;

  Color color(AdaptiveScheme scheme) => switch (this) {
    MetricKind.cpu => scheme.accent,
    MetricKind.memory => scheme.secondary,
    MetricKind.disk => scheme.success,
    MetricKind.connections => scheme.dangerStrong,
  };

  /// Whether Render reports a ceiling for this metric.
  ///
  /// Connections has none — Postgres has a hard limit but the API does not
  /// report it — so it cannot be a share of anything, which is what keeps it
  /// off the shared percentage axis unless deliberately rescaled.
  bool get hasLimit => this != MetricKind.connections;
}

/// The colour every scrub dot uses, whatever line it lands on.
///
/// A dot that matches its line is hard to find — it is the same colour as the
/// thing it is marking. One contrasting colour across every chart means the eye
/// looks for one thing, and position is read from where the dot sits rather
/// than from its hue, which the line already carries.
///
/// Red, except on a line that is already red — connections — where it would be
/// invisible. That is the only collision, because red is the one line colour
/// this borrows.
Color scrubDotColor(AdaptiveScheme scheme, Color lineColor) =>
    lineColor == scheme.dangerStrong ? scheme.textBright : scheme.dangerStrong;
