import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:behnam_portfolio/generated/l10n.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  static const _key = 'locale';

  Future<void> setLocale(Locale locale) async {
    if (!S.delegate.supportedLocales.contains(locale)) return;

    if (state == locale) return;

    emit(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);

    if (code != null) {
      final locale = Locale(code);

      if (S.delegate.supportedLocales.contains(locale)) {
        emit(locale);
        return;
      }
    }

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    final matched = S.delegate.supportedLocales.firstWhere(
      (l) => l.languageCode == systemLocale.languageCode,
      orElse: () => const Locale('en'),
    );

    emit(matched);
  }
}
