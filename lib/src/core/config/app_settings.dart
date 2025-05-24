import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.appPhraseTimerInterval,
    this.appLocale,
    this.appGradientColorsIndex,
  });

  final int? appPhraseTimerInterval;
  final Locale? appLocale;
  final int? appGradientColorsIndex;
}
