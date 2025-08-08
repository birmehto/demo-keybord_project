import 'dart:ui';

import 'package:demo_project/utility/constants.dart';
import 'package:demo_project/utility/preference_utils.dart';
import 'package:flutter/material.dart';

enum AppThemeMode { light, system, dark }

class AppThemeController extends ChangeNotifier {
  AppThemeMode _appThemeMode = AppThemeMode.system;

  AppThemeMode get appThemeMode => _appThemeMode;

  ThemeMode get themeMode {
    switch (_appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      //final brightness = SchedulerBinding.instance.window.platformBrightness;
        final brightness = PlatformDispatcher.instance.platformBrightness;
        return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  AppThemeController() {
    _loadThemeMode();
  }

  void setThemeMode(AppThemeMode mode) {
    _appThemeMode = mode;
    PreferenceUtils.setString(Constants.isThemePref, mode.name);
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    final hasPref = PreferenceUtils.containsKey(Constants.isThemePref);
    if (hasPref) {
      final mode = PreferenceUtils.getString(Constants.isThemePref);
      _appThemeMode = AppThemeMode.values.firstWhere(
            (e) => e.name == mode,
        orElse: () => AppThemeMode.system,
      );
    } else {
      _appThemeMode = AppThemeMode.system;
    }
    notifyListeners();
  }
}
