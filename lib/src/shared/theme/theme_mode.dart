import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class CWMThemeMode extends ChangeNotifier {
  final SharedPreferences pref;
  static const _themeModeKey = 'theme_mode';
  CWMThemeMode(this.pref) {
    final mode = (pref.getString(_themeModeKey) ?? '').mode;
    setThemeMode(mode);
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(AppThemeModeEnum mode) async {
    switch (mode) {
      case AppThemeModeEnum.dark:
        _themeMode = ThemeMode.dark;
        break;
      case AppThemeModeEnum.light:
        _themeMode = ThemeMode.light;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }

    await updateThemeMode(mode);
    notifyListeners();
  }

  Future<void> updateThemeMode(AppThemeModeEnum mode) async {
    await pref.setString(_themeModeKey, mode.json);
  }

  bool get isDark => (_themeMode == ThemeMode.dark) || _themeMode == ThemeMode.system &&  WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  bool get isLight => _themeMode == ThemeMode.light || _themeMode == ThemeMode.system &&  WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light;
}

final appThemeModeNotifier = CWMThemeMode(PrefsService.instance);
