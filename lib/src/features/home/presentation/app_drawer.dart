// lib/src/features/home/presentation/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/src/core/constants/app_colors.dart';
import 'package:ongi/src/core/constants/app_constants.dart';
import 'package:ongi/src/core/constants/dividers.dart';
import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi/src/features/home/presentation/app_locale_button.dart';
import 'package:ongi/src/features/home/presentation/app_phrase_timer_interval_button.dart';
import 'package:ongi/src/features/home/presentation/box_color_picker_button.dart';
import 'package:ongi/src/features/home/providers/main_category_provider.dart';
import 'package:ongi/src/routing/app_router.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  // English: Callback function invoked when an emotion category is selected from the drawer.
  // Korean: 드로어에서 감정 카테고리 선택 시 호출되는 콜백 함수입니다.
  void _onCategorySelected(
    BuildContext context,
    WidgetRef ref,
    EmotionCategory category,
  ) {
    ref.read(mainCategoryProvider.notifier).set(category);
    if (context.mounted && context.canPop()) {
      // English: Close the drawer after selection.
      // Korean: 선택 후 드로어를 닫습니다.
      context.pop();
    }
  }

  // English: Helper method to safely pop the current route (close the drawer).
  // Korean: 현재 라우트를 안전하게 pop하는 (드로어를 닫는) 헬퍼 메소드입니다.
  void _pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }

  // English: Helper function to get the localized display name for an EmotionCategory.
  // Korean: EmotionCategory에 대한 지역화된 표시 이름을 가져오는 헬퍼 함수입니다.
  String _getCategoryDisplayName(
    BuildContext context,
    EmotionCategory category,
  ) {
    switch (category) {
      case EmotionCategory.anger:
        return context.loc.whenAnger;
      case EmotionCategory.sad:
        return context.loc.whenSad;
      case EmotionCategory.afraid:
        return context.loc.whenAfraid;
      case EmotionCategory.general:
        return context.loc.whenGeneral;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // English: Watch the currently selected emotion category from the provider.
    // Korean: 프로바이더로부터 현재 선택된 감정 카테고리를 감시합니다.
    final selectedCategory = ref.watch(mainCategoryProvider);

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: <Widget>[
            // English: App title ListTile.
            // Korean: 앱 제목 ListTile.
            ListTile(
              leading: Icon(Icons.favorite_outline, color: appMainColor),
              title: Text(context.loc.appName),
            ),
            Dividers.divider16,
            /*
            DrawerHeader(
              decoration: BoxDecoration(color: AppBasicColors.colors[0]),
              child: const Text(
                '감정 선택하기',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            */
            // english
            // To use categories, please update the following files:
            // In lib/src/core/constants/app_constants.dart, set the value of useCategory to true
            // If needed, update app_drawer.dart and emotion_category.dart
            // Add the necessary labels/phrases in the respective files
            // lib/src/features/home/services/english_phrase_service.dart
            // lib/src/features/home/services/korean_phrase_service.dart
            // lib/src/features/home/services/spanish_phrase_service.dart
            // lib/src/features/home/services/japanese_phrase_service.dart
            // lib/src/features/home/services/simplified_chinese_phrase_service.dart
            // korean
            // 카테고리를 사용하기 위해서 다음 파일들을 변경해 주세요.
            // lib/src/core/constants/app_constants.dart 파일에서 useCategory 값을 true로 변경
            // 필요시 현재 app_drawer.dart, emotion_category.dart
            // 다음 파일에 사용할 문구 추가
            // lib/src/features/home/services/english_phrase_service.dart
            // lib/src/features/home/services/korean_phrase_service.dart
            // lib/src/features/home/services/spanish_phrase_service.dart
            // lib/src/features/home/services/japanese_phrase_service.dart
            // lib/src/features/home/services/simplified_chinese_phrase_service.dart
            // English: Dynamically create ListTiles for each EmotionCategory.
            // Korean: 각 EmotionCategory에 대해 ListTile을 동적으로 생성합니다.
            if (useCategory) ...[
              ...EmotionCategory.values.map((e) {
                return ListTile(
                  leading: Icon(
                    Icons.label_outline,
                    color:
                        AppBasicColors.colors[e.index %
                            AppBasicColors.colors.length],
                  ),
                  title: Text(_getCategoryDisplayName(context, e)),
                  onTap: () => _onCategorySelected(context, ref, e),
                  // English: Highlight the selected category.
                  // Korean: 선택된 카테고리를 강조 표시합니다.
                  selected: selectedCategory == e,
                  selectedTileColor:
                      Theme.of(context).colorScheme.primaryContainer,
                );
              }),
              Dividers.divider16,
            ],
            // English: Buttons for app settings like locale, timer interval, and color picker.
            // Korean: 로케일, 타이머 간격, 색상 선택기와 같은 앱 설정을 위한 버튼들입니다.
            const AppLocaleButton(),
            const AppPhraseTimerIntervalButton(),
            const BoxColorPickerButton(),
            Dividers.divider16,
            // English: ListTile for navigating to the Terms of Service screen.
            // Korean: 서비스 이용 약관 화면으로 이동하기 위한 ListTile입니다.
            ListTile(
              leading: const Icon(Icons.handshake_outlined),
              title: Text(context.loc.termsOfService),
              onTap: () {
                // English: Close the drawer if it can be popped, then navigate.
                // Korean: 드로어를 닫을 수 있다면 닫은 후, 화면을 이동합니다.
                if (context.canPop()) {
                  context.pop();
                }
                context.push(ScreenPaths.appTerms);
              },
            ),
            // English: ListTile for navigating to the Privacy Policy screen.
            // Korean: 개인정보 처리방침 화면으로 이동하기 위한 ListTile입니다.
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(context.loc.privacyPolicy),
              onTap: () {
                _pop(context);
                context.push(ScreenPaths.appPrivacy);
              },
            ),
            // English: ListTile for navigating to the App Info screen.
            // Korean: 앱 정보 화면으로 이동하기 위한 ListTile입니다.
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(context.loc.appInfo),
              onTap: () {
                _pop(context);
                context.push(ScreenPaths.appInfo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
