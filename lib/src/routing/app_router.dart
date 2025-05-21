import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/src/core/config/app_settings_controller.dart';
import 'package:ongi/src/features/home/presentation/main_screen.dart';
import 'package:ongi/src/features/infomation/app_information_screen.dart';
import 'package:ongi/src/features/infomation/app_privacy_screen.dart';
import 'package:ongi/src/features/infomation/app_terms_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_router.g.dart';

class ScreenPaths {
  // sliver applied
  static String home = '/';
  static String appInfo = '/appInfo';
  static String appPrivacy = '/privacy';
  static String appTerms = '/terms';
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => MainScreen()),
      GoRoute(
        path: '/privacy',
        pageBuilder: (context, state) {
          final appSettings = ref.watch(appSettingsControllerProvider);
          return _buildPage(
            child: AppPrivacyScreen(
              languageCode:
                  appSettings.appLocale?.languageCode ??
                  PlatformDispatcher.instance.locale.languageCode,
            ),
          );
        },
      ),
      GoRoute(
        path: '/terms',
        pageBuilder: (context, state) {
          final appSettings = ref.watch(appSettingsControllerProvider);
          return _buildPage(
            child: AppTermsScreen(
              languageCode:
                  appSettings.appLocale?.languageCode ??
                  PlatformDispatcher.instance.locale.languageCode,
            ),
          );
        },
      ),
      GoRoute(
        path: '/appInfo',
        pageBuilder: (context, state) {
          return _buildPage(child: AppInformationScreen());
        },
      ),
    ],
    /*
    errorPageBuilder:
        (context, state) => MaterialPage(
          child: ErrorScaffold(
            errorMessage: context.loc.pageNotFound,
            isHome: true,
          ),
        ),
        */
  );
}

// Screen transitions branch depending on the target platform
// 타겟플램폼에 따라 스크린 트랜지션 분기
Page<dynamic> _buildPage({required Widget child, bool isFullScreen = false}) {
  // Extra page shown when swiping back in Safari on iOS
  // To temporarily resolve this issue,
  // use NoTransitionPage on the web on apple devices.
  // If it is resolved in flutter, we will change.

  // final isIosWeb = kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  /*
  final isApple = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
  */
  final isAppleWeb =
      kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
  final isAppleNative =
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
  /*
  final isAndOrWin = defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.windows;
  */

  if (isAppleWeb) {
    return NoTransitionPage(child: child);
  }
  if (isAppleNative) {
    return CupertinoPage(child: child);
  }
  /*
  if (isAndOrWin) {
    return CustomTransitionPage(
      fullscreenDialog: isFullScreen,
      transitionsBuilder: isFullScreen
          ? buildVerticalSlideTransitiron
          : buildHorizontalSlideTransitiron,
      child: child,
    );
  }
  */
  return MaterialPage(child: child, fullscreenDialog: isFullScreen);
}
