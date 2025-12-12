import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const String _fontSizeKey = 'fontSize';
  static const String _themeKey = 'isDarkTheme';
  static const String _defaultFontSize = '16';
  static const bool _defaultDarkTheme = false;

  double _fontSize = 16.0;
  bool _isDarkTheme = false;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  double get fontSize => _fontSize;
  bool get isDarkTheme => _isDarkTheme;
  bool get isInitialized => _isInitialized;

  /// Initialize SharedPreferences and load saved settings
  Future<void> init() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    
    // Load saved values or use defaults
    final fontSizeStr = _prefs.getString(_fontSizeKey) ?? _defaultFontSize;
    _fontSize = double.tryParse(fontSizeStr) ?? 16.0;
    
    _isDarkTheme = _prefs.getBool(_themeKey) ?? _defaultDarkTheme;
    
    _isInitialized = true;
    notifyListeners();
  }

  /// Set the font size and save to SharedPreferences
  Future<void> setFontSize(double size) async {
    if (_fontSize == size) return;
    
    _fontSize = size;
    await _prefs.setString(_fontSizeKey, size.toString());
    notifyListeners();
  }

  /// Toggle dark theme and save to SharedPreferences
  Future<void> toggleDarkTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _prefs.setBool(_themeKey, _isDarkTheme);
    notifyListeners();
  }

  /// Set dark theme explicitly and save to SharedPreferences
  Future<void> setDarkTheme(bool isDark) async {
    if (_isDarkTheme == isDark) return;
    
    _isDarkTheme = isDark;
    await _prefs.setBool(_themeKey, isDark);
    notifyListeners();
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    _fontSize = 16.0;
    _isDarkTheme = false;
    await _prefs.remove(_fontSizeKey);
    await _prefs.remove(_themeKey);
    notifyListeners();
  }
}
