import 'package:flutter/material.dart';
import 'package:ongi_app/src/core/config/app_settings.dart';
import 'package:ongi_app/src/core/providers/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_controller.g.dart';

@riverpod
class AppSettingsController extends _$AppSettingsController {
  AppSettingsController();

  @override
  AppSettings build() {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    final appLocaleString = sharedPreferences.getString('appLocale');
    final appLocale = appLocaleString == null ? null : Locale(appLocaleString);

    return AppSettings(appLocale: appLocale);
  }

  Future<void> setAppLocale(String languageCode) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setString('appLocale', languageCode);
    final appLocaleString = sharedPreferences.getString('appLocale');
    final appLocale = appLocaleString == null ? null : Locale(appLocaleString);
    state = AppSettings(appLocale: appLocale);
  }

  Future<void> removeAppLocale() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove('appLocale');
    state = AppSettings(appLocale: null);
  }
}
