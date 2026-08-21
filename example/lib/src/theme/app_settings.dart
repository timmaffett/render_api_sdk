import 'package:auris/auris.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// How a timestamp is written.
enum ClockFormat {
  /// 2:47 pm — the default, because most people read it faster.
  twelveHour,

  /// 14:47.
  twentyFourHour,
}

/// What a metrics panel puts in its header.
enum MetricTimeDisplay {
  /// How long ago the data was read — "14 seconds ago". Ticks every second.
  age,

  /// The wall-clock time it was read.
  clock,
}

/// Everything the user can set: the three values [AurisTheme] is built from,
/// plus how times are written.
///
/// Kept in one [ChangeNotifier] rather than a state-management package: an
/// example for an API client should be about the API client. Persisted in
/// `shared_preferences` — unlike the token, none of this is secret.
class AppSettings extends ChangeNotifier {
  AppSettings(this._prefs) {
    _dark = _prefs.getBool(_kDark) ?? true;
    _bevelScale = _prefs.getDouble(_kBevel) ?? 1.0;
    _glowScale = _prefs.getDouble(_kGlow) ?? 1.0;
    final accent = _prefs.getInt(_kAccent);
    _accent = accent == null ? null : Color(accent);
    _clock = ClockFormat.values[_prefs.getInt(_kClock) ?? 0];
    _metricTime = MetricTimeDisplay.values[_prefs.getInt(_kMetricTime) ?? 0];
  }

  static const _kDark = 'theme.dark';
  static const _kBevel = 'theme.bevelScale';
  static const _kGlow = 'theme.glowScale';
  static const _kAccent = 'theme.accent';
  static const _kClock = 'display.clock';
  static const _kMetricTime = 'display.metricTime';

  /// The swatches the settings page offers. Null is auris's own gold.
  static const accents = <(String, Color?)>[
    ('GOLD', null),
    ('CYAN', Color(0xFF4DD0E1)),
    ('VIOLET', Color(0xFF9B7BEA)),
    ('LIME', Color(0xFFA6E22E)),
    ('CORAL', Color(0xFFFF7A6B)),
  ];

  final SharedPreferences _prefs;

  late ClockFormat _clock;
  late MetricTimeDisplay _metricTime;
  late bool _dark;
  late double _bevelScale;
  late double _glowScale;
  late Color? _accent;

  ClockFormat get clock => _clock;
  MetricTimeDisplay get metricTime => _metricTime;
  bool get dark => _dark;
  double get bevelScale => _bevelScale;
  double get glowScale => _glowScale;
  Color? get accent => _accent;

  /// Rebuilt on every change, which is what makes the settings page live.
  ThemeData get theme => _dark
      ? AurisTheme.dark(
          accent: _accent,
          bevelScale: _bevelScale,
          glowScale: _glowScale,
        )
      : AurisTheme.light(
          accent: _accent,
          bevelScale: _bevelScale,
          glowScale: _glowScale,
        );

  set clock(ClockFormat value) {
    _clock = value;
    _prefs.setInt(_kClock, value.index);
    notifyListeners();
  }

  set metricTime(MetricTimeDisplay value) {
    _metricTime = value;
    _prefs.setInt(_kMetricTime, value.index);
    notifyListeners();
  }

  /// A wall-clock time, written the way the user asked for.
  String formatClock(DateTime at) {
    final local = at.toLocal();
    if (_clock == ClockFormat.twentyFourHour) {
      return '${local.hour.toString().padLeft(2, '0')}:'
          '${local.minute.toString().padLeft(2, '0')}';
    }
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final suffix = local.hour < 12 ? 'am' : 'pm';
    return '$hour:${local.minute.toString().padLeft(2, '0')}$suffix';
  }

  set dark(bool value) {
    _dark = value;
    _prefs.setBool(_kDark, value);
    notifyListeners();
  }

  set bevelScale(double value) {
    _bevelScale = value;
    _prefs.setDouble(_kBevel, value);
    notifyListeners();
  }

  set glowScale(double value) {
    _glowScale = value;
    _prefs.setDouble(_kGlow, value);
    notifyListeners();
  }

  set accent(Color? value) {
    _accent = value;
    if (value == null) {
      _prefs.remove(_kAccent);
    } else {
      // toARGB32 rather than the deprecated .value, which Flutter 3.27 replaced
      // when Color moved to wide-gamut floating point channels.
      _prefs.setInt(_kAccent, value.toARGB32());
    }
    notifyListeners();
  }

  void reset() {
    _clock = ClockFormat.twelveHour;
    _metricTime = MetricTimeDisplay.age;
    _dark = true;
    _bevelScale = 1.0;
    _glowScale = 1.0;
    _accent = null;
    _prefs
      ..remove(_kClock)
      ..remove(_kMetricTime)
      ..remove(_kDark)
      ..remove(_kBevel)
      ..remove(_kGlow)
      ..remove(_kAccent);
    notifyListeners();
  }
}
