import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit({required ThemeMode initialTheme})
    : super(ChangeThemeDone(theme: initialTheme));
  Future<void> changeTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", newTheme.toString().split('.').last);
    emit(ChangeThemeDone(theme: newTheme));
  }

  Future<ThemeMode> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString("theme") ?? "system";
    ThemeMode themeMode = getThemeModeFromString(savedTheme);
    return themeMode;
  }

  ThemeMode getThemeModeFromString(String theme) {
    switch (theme) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
    }
  }
}
