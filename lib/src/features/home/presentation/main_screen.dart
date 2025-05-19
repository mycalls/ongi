import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ongi_app/src/core/config/app_settings_controller.dart';
import 'package:ongi_app/src/features/home/presentation/app_drawer.dart';
import 'package:ongi_app/src/features/home/presentation/phrase_body.dart';
import 'package:ongi_app/src/features/home/providers/main_category_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white, // 배경색 투명 또는 테마 색상
        elevation: 0, // 그림자 제거
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true, // AppBar 뒤로 Body가 확장되도록
      body: Consumer(
        builder: (context, ref, child) {
          final selectedCategory = ref.watch(mainCategoryProvider);
          final appSettings = ref.watch(appSettingsControllerProvider);
          return PhraseBody(
            selectedCategory: selectedCategory,
            languageCode:
                appSettings.appLocale?.languageCode ??
                PlatformDispatcher.instance.locale.languageCode,
            // 선택된 카테고리 전달
          );
        },
      ),
    );
  }
}
