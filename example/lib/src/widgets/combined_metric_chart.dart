import 'package:auris/auris_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/render_client.dart';
import 'metric_palette.dart';

/// Every metric on one axis, each line keeping the colour it uses everywhere.
///
/// Most of these are already drawn as a share of their own ceiling, so they
/// belong on a single 0–100% axis without any further violence: 20% of memory
/// and 5% of CPU are directly comparable statements about how close a resource
/// is to its limit.
///
/// Metrics with no ceiling are left off, and connections is the only one.
/// Scaling it against its own peak was tried and is worse than useless: a
/// database holding one or two connections becomes a line swinging between 50%
/// and 100%, the loudest thing on the chart and the least meaningful, while
/// CPU at 5% and disk at 6% are squashed into the baseline. A percentage needs
/// a real denominator; its own maximum is not one.
///
/// It keeps its colour and its own chart on the detail page, where a count is
/// plotted as a count.
class CombinedMetricChart extends StatelessWidget {
  const CombinedMetricChart({
    super.key,
    required this.metrics,
    this.height = 170,
  });

  final Map<MetricKind, MetricChartData> metrics;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final text = Theme.of(context).textTheme;

    // One line per metric: the first series it has, which for a single-instance
    // resource is the only one.
    final lines = <_Line>[];
    final excluded = <MetricKind>[];
    final offAxis = <MetricKind, MetricSeries>{};
    for (final entry in metrics.entries) {
      final series = entry.value.series.where((s) => !s.isEmpty).toList();
      if (series.isEmpty) continue;
      if (!entry.key.hasLimit || entry.value.limit == null) {
        excluded.add(entry.key);
        // Kept even though it is not drawn: it still has a value at whatever
        // moment is being scrubbed, and that is worth reading even when it
        // cannot be a percentage.
        offAxis[entry.key] = series.first;
        continue;
      }
      lines.add(
        _Line(kind: entry.key, series: series.first, data: entry.value),
      );
    }
    if (lines.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No metrics for this window.',
            style: text.bodySmall?.copyWith(color: scheme.textDim),
          ),
        ),
      );
    }

    final origin = lines
        .map((l) => l.series.points.first.at)
        .reduce((a, b) => a.isBefore(b) ? a : b);

    // A fixed 0–100% axis wastes most of its height: an idle database runs at
    // 5% CPU and 20% memory, so three lines pile into the bottom quarter and
    // disk at 6% disappears under CPU at 5%. The axis fits the data with a
    // little headroom instead — still a percentage of each metric's real
    // ceiling, so nothing is distorted, only zoomed.
    final busiest = lines
        .map((l) => l.percent(l.series.max))
        .reduce((a, b) => a > b ? a : b);
    final ceiling = (busiest * 1.35).clamp(10.0, 100.0);
    final step = ceiling / 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: ceiling,
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: step,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: scheme.borderResting, strokeWidth: 1),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: scheme.borderResting),
                  bottom: BorderSide(color: scheme.borderResting),
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                bottomTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 44,
                    interval: step,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        ceiling <= 20
                            ? '${value.toStringAsFixed(1)}%'
                            : '${value.round()}%',
                        style: text.labelSmall?.copyWith(color: scheme.textDim),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                getTouchedSpotIndicator: (bar, indexes) => [
                  for (final _ in indexes)
                    TouchedSpotIndicatorData(
                      FlLine(color: scheme.textDim, strokeWidth: 1),
                      // Small, because on a line of a thousand points a fat
                      // dot covers the shape being read — but not so small it
                      // cannot be found. 1 was invisible.
                      FlDotData(
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 2,
                              color: scrubDotColor(
                                scheme,
                                bar.color ?? scheme.primaryActive,
                              ),
                              strokeWidth: 0,
                            ),
                      ),
                    ),
                ],
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => scheme.surfaceInset,
                  tooltipBorder: BorderSide(color: scheme.primaryDim),
                  maxContentWidth: 260,
                  getTooltipItems: (spots) => [
                    for (final (index, spot) in spots.indexed)
                      LineTooltipItem(
                        lines[spot.barIndex].readout(spot.y),
                        text.bodySmall!.copyWith(
                          color: lines[spot.barIndex].kind.color(scheme),
                        ),
                        // The metrics with no ceiling ride along on the last
                        // line, so a scrub still answers "and how many
                        // connections was that?".
                        children: index != spots.length - 1
                            ? null
                            : [
                                for (final entry in offAxis.entries)
                                  TextSpan(
                                    text:
                                        '\n${_at(entry.value, origin, spot.x, entry.key)}',
                                    style: text.labelSmall?.copyWith(
                                      color: entry.key.color(scheme),
                                    ),
                                  ),
                              ],
                      ),
                  ],
                ),
              ),
              lineBarsData: [
                for (final line in lines)
                  LineChartBarData(
                    color: line.kind.color(scheme),
                    barWidth: 1.4,
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    spots: [
                      for (final point in line.series.points)
                        FlSpot(
                          point.at.difference(origin).inSeconds / 60,
                          line.percent(point.value),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 14,
          runSpacing: 4,
          children: [
            for (final line in lines)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 2,
                    color: line.kind.color(scheme),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    line.kind.label,
                    style: text.labelSmall?.copyWith(color: scheme.textMid),
                  ),
                ],
              ),
          ],
        ),
        if (excluded.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${excluded.map((k) => k.label.toLowerCase()).join(', ')} '
            '${excluded.length == 1 ? 'has' : 'have'} no limit to be a '
            'percentage of — see the detail page',
            style: text.labelSmall?.copyWith(color: scheme.textDim),
          ),
        ],
      ],
    );
  }
}

/// The reading nearest a scrubbed position, for a series that is not drawn.
///
/// The x axis is minutes since [origin], so the moment is recoverable and the
/// nearest sample can be found even though this series has no line to hit.
String _at(MetricSeries series, DateTime origin, double x, MetricKind kind) {
  final at = origin.add(Duration(seconds: (x * 60).round()));
  var nearest = series.points.first;
  var best = Duration(days: 4000);
  for (final point in series.points) {
    final gap = point.at.difference(at).abs();
    if (gap < best) {
      best = gap;
      nearest = point;
    }
  }
  // Parenthesised, because it is an aside: this metric has no line on the
  // chart, so the number answers a question the axis cannot.
  final count = nearest.value.round();
  final noun = kind == MetricKind.connections
      ? (count == 1 ? 'connection' : 'connections')
      : kind.label.toLowerCase();
  return '($count $noun)';
}

/// One metric's line, and how to read a point on it.
class _Line {
  _Line({required this.kind, required this.series, required this.data})
    : _ceiling = data.limit ?? (series.max == 0 ? 1 : series.max);

  final MetricKind kind;
  final MetricSeries series;
  final MetricChartData data;

  /// The limit where there is one; the observed peak where there is not.
  final double _ceiling;

  double percent(double value) => (value / _ceiling * 100).clamp(0, 100);

  /// What the hover says.
  ///
  /// The axis is a percentage, so the raw reading is what a reader cannot
  /// recover by looking — a connection count especially, which was only ever
  /// scaled to get it onto this axis at all.
  String readout(double percent) =>
      '${kind.label}  '
      '${percent.toStringAsFixed(1)}%  ·  '
      '${_units(percent / 100 * _ceiling, series.unit)}';

  static String _units(double value, String? unit) => switch (unit) {
    'bytes' =>
      value >= 1e9
          ? '${(value / 1e9).toStringAsFixed(2)} GB'
          : '${(value / 1e6).toStringAsFixed(0)} MB',
    'cpu' =>
      value < 0.01
          ? '${(value * 1000).toStringAsFixed(1)} mCPU'
          : '${value.toStringAsFixed(2)} cores',
    _ => value.toStringAsFixed(1),
  };
}
