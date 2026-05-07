import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark) {
    _loadTheme();
  }

  static const _key = 'theme_mode';

  void toggleTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    if (state != newTheme) {
      emit(newTheme);
      _saveTheme(newTheme);
    }
  }

  void setTheme(ThemeMode mode) {
    if (state != mode) {
      emit(mode);
      _saveTheme(mode);
    }
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_key);

    ThemeMode loadedTheme;

    switch (value) {
      case 'dark':
        loadedTheme = ThemeMode.dark;
        break;

      case 'light':
        loadedTheme = ThemeMode.light;
        break;

      default:
        loadedTheme = ThemeMode.dark;
    }

    if (state != loadedTheme) {
      emit(loadedTheme);
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'dark',
    };

    await prefs.setString(_key, value);
  }
}
