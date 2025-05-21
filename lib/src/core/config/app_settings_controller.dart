import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:ongi/src/core/config/app_settings.dart';
import 'package:ongi/src/core/constants/app_constants.dart';
import 'package:ongi/src/core/providers/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_controller.g.dart';

@riverpod
class AppSettingsController extends _$AppSettingsController {
  AppSettingsController();

  @override
  AppSettings build() {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;

    final appPhraseTimerIntervalInt = sharedPreferences.getInt(
      prefAppPhraseTimerInterval,
    );
    final appLocaleString = sharedPreferences.getString(prefAppLocale);
    final appLocale = appLocaleString == null ? null : Locale(appLocaleString);
    dev.log(
      'AppSettings build: appPhraseTimerInterval($appPhraseTimerIntervalInt), appLocale($appLocale)',
    );

    return AppSettings(
      appPhraseTimerInterval: appPhraseTimerIntervalInt,
      appLocale: appLocale,
    );
  }

  Future<void> setAppPhraseTimerInterval(int interval) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setInt(prefAppPhraseTimerInterval, interval);
    final appPhraseTimerIntervalInt = sharedPreferences.getInt(
      prefAppPhraseTimerInterval,
    );
    dev.log(
      'setAppPhraseTimerInterval: appPhraseTimerInterval($appPhraseTimerIntervalInt), appLocale(${state.appLocale})',
    );
    state = AppSettings(
      appPhraseTimerInterval: appPhraseTimerIntervalInt,
      appLocale: state.appLocale,
    );
  }

  Future<void> removeAppPhraseTimerInterval() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove(prefAppPhraseTimerInterval);
    dev.log(
      'removeAppLocale: appPhraseTimerInterval(null), appLocale(${state.appLocale})',
    );
    state = AppSettings(
      appPhraseTimerInterval: null,
      appLocale: state.appLocale,
    );
  }

  Future<void> setAppLocale(String languageCode) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setString(prefAppLocale, languageCode);
    final appLocaleString = sharedPreferences.getString(prefAppLocale);
    final appLocale = appLocaleString == null ? null : Locale(appLocaleString);
    dev.log(
      'setAppLocale: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale($appLocale)',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: appLocale,
    );
  }

  Future<void> removeAppLocale() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove(prefAppLocale);
    dev.log(
      'removeAppLocale: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale(null)',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: null,
    );
  }
}
