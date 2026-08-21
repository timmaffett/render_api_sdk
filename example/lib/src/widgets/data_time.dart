import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_settings.dart';

/// Makes the settings readable anywhere, so a panel buried in a pushed route
/// can format a time without one being threaded down to it.
class SettingsScope extends InheritedNotifier<AppSettings> {
  const SettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsScope>()?.notifier;
}

/// When some data was read, written the way the user asked for.
///
/// In clock mode this is a plain label. In age mode it ticks: "14 seconds ago"
/// has to keep counting or it is worse than a clock, because a stopped
/// relative time reads as current when it is not.
///
/// The timer only exists in age mode, and only while the widget is mounted —
/// a rebuild into clock mode cancels it.
class DataTime extends StatefulWidget {
  const DataTime({super.key, required this.at, this.prefix, this.style});

  final DateTime at;

  /// Written before the time: `read`, or `cached`.
  final String? prefix;

  final TextStyle? style;

  @override
  State<DataTime> createState() => _DataTimeState();
}

class _DataTimeState extends State<DataTime> {
  Timer? _tick;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(DataTime old) {
    super.didUpdateWidget(old);
    _sync();
  }

  /// Runs a ticker only when something on screen actually changes every second.
  void _sync() {
    final wantsTicker =
        SettingsScope.maybeOf(context)?.metricTime == MetricTimeDisplay.age;
    if (wantsTicker && _tick == null) {
      _tick = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!wantsTicker) {
      _tick?.cancel();
      _tick = null;
    }
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.maybeOf(context);
    final text = settings?.metricTime == MetricTimeDisplay.clock
        ? settings!.formatClock(widget.at)
        : _age(DateTime.now().difference(widget.at));

    return Text(
      widget.prefix == null ? text : '${widget.prefix} $text',
      style: widget.style,
    );
  }
}

/// "14 seconds ago", and coarser as it gets older.
///
/// Singular is spelled out rather than left as "1 seconds", and anything in
/// the future — a clock that stepped back — reads as "just now" rather than a
/// negative count.
String _age(Duration since) {
  if (since.isNegative || since.inSeconds < 1) return 'just now';
  if (since.inSeconds < 60) return '${_plural(since.inSeconds, 'second')} ago';
  if (since.inMinutes < 60) return '${_plural(since.inMinutes, 'minute')} ago';
  if (since.inHours < 24) return '${_plural(since.inHours, 'hour')} ago';
  return '${_plural(since.inDays, 'day')} ago';
}

String _plural(int count, String unit) =>
    count == 1 ? '1 $unit' : '$count ${unit}s';
