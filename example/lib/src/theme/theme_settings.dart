import 'package:auris/auris.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The three values [AurisTheme] is built from, plus brightness.
///
/// Kept in one [ChangeNotifier] rather than a state-management package: an
/// example for an API client should be about the API client. Persisted in
/// `shared_preferences` — unlike the token, none of this is secret.
class ThemeSettings extends ChangeNotifier {
  ThemeSettings(this._prefs) {
    _dark = _prefs.getBool(_kDark) ?? true;
    _bevelScale = _prefs.getDouble(_kBevel) ?? 1.0;
    _glowScale = _prefs.getDouble(_kGlow) ?? 1.0;
    final accent = _prefs.getInt(_kAccent);
    _accent = accent == null ? null : Color(accent);
  }

  static const _kDark = 'theme.dark';
  static const _kBevel = 'theme.bevelScale';
  static const _kGlow = 'theme.glowScale';
  static const _kAccent = 'theme.accent';

  /// The swatches the settings page offers. Null is auris's own gold.
  static const accents = <(String, Color?)>[
    ('GOLD', null),
    ('CYAN', Color(0xFF4DD0E1)),
    ('VIOLET', Color(0xFF9B7BEA)),
    ('LIME', Color(0xFFA6E22E)),
    ('CORAL', Color(0xFFFF7A6B)),
  ];

  final SharedPreferences _prefs;

  late bool _dark;
  late double _bevelScale;
  late double _glowScale;
  late Color? _accent;

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
    _dark = true;
    _bevelScale = 1.0;
    _glowScale = 1.0;
    _accent = null;
    _prefs
      ..remove(_kDark)
      ..remove(_kBevel)
      ..remove(_kGlow)
      ..remove(_kAccent);
    notifyListeners();
  }
}
