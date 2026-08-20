import 'package:auris/auris.dart';
import 'package:flutter/material.dart';

import '../data/render_client.dart';

/// A small metric chart, painted rather than plotted.
///
/// The metrics operations already return chart-shaped data — a list of
/// (timestamp, value) with a unit — so a sparkline needs no charting library,
/// and painting it here means it takes its colours from the auris scheme
/// instead of fighting one. `fl_chart` handles the full-size charts, where
/// axes and tooltips are worth the dependency.
class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.series,
    this.height = 48,
    this.danger = false,
  });

  final MetricSeries series;
  final double height;

  /// Paints in the danger colour — for a series that has crossed a threshold.
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).extension<AurisScheme>()!;
    if (series.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'no data',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.textDim),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(
          series: series,
          line: danger ? scheme.dangerBright : scheme.primaryActive,
          fill: (danger ? scheme.danger : scheme.primaryDim).withValues(
            alpha: 0.18,
          ),
          frame: scheme.borderResting,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.series,
    required this.line,
    required this.fill,
    required this.frame,
  });

  final MetricSeries series;
  final Color line;
  final Color fill;
  final Color frame;

  @override
  void paint(Canvas canvas, Size size) {
    final points = series.points;
    if (points.isEmpty) return;

    // A flat series would divide by zero; give it a baseline instead so it
    // draws along the bottom rather than vanishing.
    final maxValue = series.max == 0 ? 1.0 : series.max;
    const inset = 3.0;
    final width = size.width - inset * 2;
    final usable = size.height - inset * 2;

    Offset at(int i) {
      final x = points.length == 1
          ? inset + width / 2
          : inset + width * (i / (points.length - 1));
      final y = inset + usable * (1 - points[i].value / maxValue);
      return Offset(x, y);
    }

    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < points.length; i++) {
      final p = at(i);
      path.lineTo(p.dx, p.dy);
    }

    final area = Path.from(path)
      ..lineTo(at(points.length - 1).dx, size.height - inset)
      ..lineTo(at(0).dx, size.height - inset)
      ..close();

    canvas
      ..drawPath(area, Paint()..color = fill)
      ..drawPath(
        path,
        Paint()
          ..color = line
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..strokeJoin = StrokeJoin.round,
      );

    // A chamfered frame, matching the corner treatment auris uses everywhere.
    const cut = 6.0;
    final border = Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - cut)
      ..lineTo(size.width - cut, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, cut)
      ..close();
    canvas.drawPath(
      border,
      Paint()
        ..color = frame
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.series != series || old.line != line;
}
