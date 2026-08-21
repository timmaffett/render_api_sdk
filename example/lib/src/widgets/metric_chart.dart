import 'package:auris/auris_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/render_client.dart';

/// How a metric's values are labelled.
enum MetricScale {
  /// A share of the instance's ceiling, 0–100%.
  percent,

  /// The raw reading — cores for CPU, MB for memory.
  total,
}

/// A metric plotted against the instance's ceiling, with a scrub readout.
///
/// The axis runs 0 to the limit rather than to the data's own range, which is
/// what Render's dashboard does and is the more honest picture: a service using
/// a twentieth of its CPU should look like a service using a twentieth of its
/// CPU, not like a noisy full-height waveform. Without a limit — some plans do
/// not report one — it falls back to the data's range.
///
/// The toggle only changes the labels. Both scales draw the same line, because
/// 5% of 0.1 cores and 0.005 cores are the same reading.
class MetricChart extends StatefulWidget {
  const MetricChart({
    super.key,
    required this.title,
    required this.data,
    this.height = 190,
  });

  final String title;
  final MetricChartData data;
  final double height;

  @override
  State<MetricChart> createState() => _MetricChartState();
}

class _MetricChartState extends State<MetricChart> {
  MetricScale _scale = MetricScale.percent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final text = Theme.of(context).textTheme;
    final data = widget.data;
    final limit = data.limit;

    // Percent is meaningless without a ceiling to be a percentage of.
    final scale = limit == null ? MetricScale.total : _scale;

    final series = data.series.where((s) => !s.isEmpty).toList();
    if (series.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Center(
          child: Text(
            'No data for this window.',
            style: text.bodySmall?.copyWith(color: scheme.textDim),
          ),
        ),
      );
    }

    final maxValue = series.map((s) => s.max).reduce((a, b) => a > b ? a : b);
    final ceiling = limit ?? (maxValue <= 0 ? 1.0 : maxValue * 1.15);

    // One x unit per minute since the first reading, so lines from series with
    // different sample counts still line up in time.
    final origin = series
        .map((s) => s.points.first.at)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    double x(DateTime at) => at.difference(origin).inSeconds / 60;

    final palette = <Color>[
      scheme.primaryActive,
      scheme.secondary,
      scheme.success,
      scheme.dangerBright,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                limit == null
                    ? widget.title
                    : '${widget.title}   limit ${_format(ceiling, data.unit, MetricScale.total)}',
                style: text.labelSmall,
              ),
            ),
            if (limit != null)
              _ScaleToggle(
                scale: scale,
                onChanged: (value) => setState(() => _scale = value),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.height,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: scale == MetricScale.percent ? 100 : ceiling,
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval:
                    (scale == MetricScale.percent ? 100 : ceiling) / 4,
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
                    reservedSize: 56,
                    interval:
                        (scale == MetricScale.percent ? 100 : ceiling) / 4,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(
                        _axisLabel(value, ceiling, data.unit, scale),
                        style: text.labelSmall?.copyWith(color: scheme.textDim),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => scheme.surfaceInset,
                  tooltipBorder: BorderSide(color: scheme.primaryDim),
                  maxContentWidth: 260,
                  getTooltipItems: (spots) => [
                    for (final spot in spots)
                      LineTooltipItem(
                        // The series name only earns its place when there is
                        // more than one line; with a single line it is the
                        // tail of a resource id and says nothing.
                        '${series.length > 1 ? '${_shortLabel(series[spot.barIndex].label)}  ' : ''}'
                        '${_reading(spot.y, ceiling, data.unit, scale)}'
                        '\n${_clock(origin.add(Duration(seconds: (spot.x * 60).round())))}',
                        text.bodySmall!.copyWith(
                          color: palette[spot.barIndex % palette.length],
                        ),
                      ),
                  ],
                ),
                getTouchedSpotIndicator: (bar, indexes) => [
                  for (final _ in indexes)
                    TouchedSpotIndicatorData(
                      FlLine(color: scheme.textDim, strokeWidth: 1),
                      FlDotData(
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 3.5,
                              color: bar.color ?? scheme.primaryActive,
                              strokeWidth: 0,
                            ),
                      ),
                    ),
                ],
              ),
              lineBarsData: [
                for (var i = 0; i < series.length; i++)
                  LineChartBarData(
                    color: palette[i % palette.length],
                    barWidth: 1.4,
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: series.length == 1,
                      color: palette[i % palette.length].withValues(
                        alpha: 0.14,
                      ),
                    ),
                    spots: [
                      for (final point in series[i].points)
                        FlSpot(
                          x(point.at),
                          scale == MetricScale.percent
                              ? (point.value / ceiling * 100).clamp(0, 100)
                              : point.value,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (series.length > 1) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 4,
            children: [
              for (var i = 0; i < series.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 2,
                      color: palette[i % palette.length],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _shortLabel(series[i].label),
                      style: text.labelSmall?.copyWith(color: scheme.textMid),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ],
    );
  }

  /// A plotted y, spelled the way the current scale reads it.
  ///
  /// In percent mode the y *is* the percentage, so formatting it through the
  /// unit — which turned 4.9% into "4.9m" — was reading the wrong axis.
  static String _reading(
    double y,
    double ceiling,
    String? unit,
    MetricScale scale,
  ) => scale == MetricScale.percent
      ? '${y.toStringAsFixed(1)}%'
      : _format(y, unit, scale);

  static String _axisLabel(
    double value,
    double ceiling,
    String? unit,
    MetricScale scale,
  ) => scale == MetricScale.percent
      ? '${value.round()}%'
      : _format(value, unit, scale);

  static String _format(double value, String? unit, MetricScale scale) =>
      switch (unit) {
        'bytes' =>
          value >= 1e9
              ? '${(value / 1e9).toStringAsFixed(2)} GB'
              : '${(value / 1e6).toStringAsFixed(0)} MB',
        'cpu' =>
          value < 0.01 && value > 0
              ? '${(value * 1000).toStringAsFixed(1)}m'
              : value.toStringAsFixed(2),
        _ => value.toStringAsFixed(1),
      };

  /// Instance ids are long and all share the service id as a prefix, so the
  /// suffix is the part that tells two instances apart.
  static String _shortLabel(String label) {
    final dash = label.lastIndexOf('-');
    return dash > 0 && dash < label.length - 1
        ? label.substring(dash + 1)
        : label;
  }

  static String _clock(DateTime at) {
    final local = at.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ScaleToggle extends StatelessWidget {
  const _ScaleToggle({required this.scale, required this.onChanged});

  final MetricScale scale;
  final ValueChanged<MetricScale> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    final text = Theme.of(context).textTheme;

    Widget option(MetricScale value, String label) {
      final selected = value == scale;
      return GestureDetector(
        onTap: () => onChanged(value),
        child: AurisContainer(
          cut: 4,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          fill: selected ? scheme.primaryDim.withValues(alpha: 0.3) : null,
          borderColor: selected ? scheme.primaryActive : scheme.borderResting,
          child: Text(
            label,
            style: text.labelSmall?.copyWith(
              color: selected ? scheme.textBright : scheme.textDim,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        option(MetricScale.percent, '%'),
        const SizedBox(width: 6),
        option(MetricScale.total, 'TOTAL'),
      ],
    );
  }
}
