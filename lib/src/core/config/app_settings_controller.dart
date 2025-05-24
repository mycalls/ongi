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
    final appGradientColorsIndex = sharedPreferences.getInt(
      prefAppGradientColorsIndex,
    );
    dev.log(
      'AppSettings build: appPhraseTimerInterval($appPhraseTimerIntervalInt), appLocale($appLocale), appGradientColorsIndex($appGradientColorsIndex)',
    );

    return AppSettings(
      appPhraseTimerInterval: appPhraseTimerIntervalInt,
      appLocale: appLocale,
      appGradientColorsIndex: appGradientColorsIndex,
    );
  }

  Future<void> setAppPhraseTimerInterval(int interval) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setInt(prefAppPhraseTimerInterval, interval);
    final appPhraseTimerIntervalInt = sharedPreferences.getInt(
      prefAppPhraseTimerInterval,
    );
    dev.log(
      'setAppPhraseTimerInterval: appPhraseTimerInterval($appPhraseTimerIntervalInt), appLocale(${state.appLocale}), appGradientColorsIndex(${state.appGradientColorsIndex})',
    );
    state = AppSettings(
      appPhraseTimerInterval: appPhraseTimerIntervalInt,
      appLocale: state.appLocale,
      appGradientColorsIndex: state.appGradientColorsIndex,
    );
  }

  Future<void> removeAppPhraseTimerInterval() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove(prefAppPhraseTimerInterval);
    dev.log(
      'removeAppLocale: appPhraseTimerInterval(null), appLocale(${state.appLocale}), appGradientColorsIndex(${state.appGradientColorsIndex})',
    );
    state = AppSettings(
      appPhraseTimerInterval: null,
      appLocale: state.appLocale,
      appGradientColorsIndex: state.appGradientColorsIndex,
    );
  }

  Future<void> setAppLocale(String languageCode) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setString(prefAppLocale, languageCode);
    final appLocaleString = sharedPreferences.getString(prefAppLocale);
    final appLocale = appLocaleString == null ? null : Locale(appLocaleString);
    dev.log(
      'setAppLocale: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale($appLocale), appGradientColorsIndex(${state.appGradientColorsIndex})',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: appLocale,
      appGradientColorsIndex: state.appGradientColorsIndex,
    );
  }

  Future<void> removeAppLocale() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove(prefAppLocale);
    dev.log(
      'removeAppLocale: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale(null), appGradientColorsIndex(${state.appGradientColorsIndex})',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: null,
      appGradientColorsIndex: state.appGradientColorsIndex,
    );
  }

  Future<void> setAppGradientColorsIndex(int index) async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.setInt(prefAppGradientColorsIndex, index);
    final appGradientColorsIndexInt = sharedPreferences.getInt(
      prefAppGradientColorsIndex,
    );
    dev.log(
      'setAppPhraseTimerInterval: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale(${state.appLocale}), appGradientColorsIndex($appGradientColorsIndexInt)',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: state.appLocale,
      appGradientColorsIndex: appGradientColorsIndexInt,
    );
  }

  Future<void> removeAppGradientColorsIndex() async {
    final sharedPreferences = ref.read(prefsWithCacheProvider).requireValue;
    await sharedPreferences.remove(prefAppGradientColorsIndex);
    dev.log(
      'removeAppLocale: appPhraseTimerInterval(${state.appPhraseTimerInterval}), appLocale(${state.appLocale}), appGradientColorsIndex(null)',
    );
    state = AppSettings(
      appPhraseTimerInterval: state.appPhraseTimerInterval,
      appLocale: state.appLocale,
      appGradientColorsIndex: null,
    );
  }
}
