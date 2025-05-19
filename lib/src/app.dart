import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ongi_app/l10n/app_localizations.dart';
import 'package:ongi_app/src/core/config/app_settings_controller.dart';
import 'package:ongi_app/src/core/theme/app_theme_data.dart';
import 'package:ongi_app/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final appSettings = ref.watch(appSettingsControllerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ongi',
      routerConfig: goRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appSettings.appLocale,
      theme: AppThemeData.themeData(brightness: Brightness.light),
      darkTheme: AppThemeData.themeData(brightness: Brightness.dark),
    );
  }
}
