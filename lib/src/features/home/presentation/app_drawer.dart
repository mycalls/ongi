import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi_app/src/core/constants/app_colors.dart';
import 'package:ongi_app/src/core/constants/dividers.dart';
import 'package:ongi_app/src/core/constants/emotion_category.dart';
import 'package:ongi_app/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi_app/src/features/home/presentation/app_locale_button.dart';
import 'package:ongi_app/src/features/home/providers/main_category_provider.dart';
import 'package:ongi_app/src/routing/app_router.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  // Drawer에서 항목 선택 시 호출될 콜백 함수
  void _onCategorySelected(
    BuildContext context,
    WidgetRef ref,
    EmotionCategory category,
  ) {
    ref.read(mainCategoryProvider.notifier).set(category);
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }

  void _pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }

  // EmotionCategory를 한국어 문자열로 변환하는 헬퍼 함수 (선택적)
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
      // ignore: unreachable_switch_default
      default:
        return context.loc.whenGeneral;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(mainCategoryProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 16),
          /*
            DrawerHeader(
              decoration: BoxDecoration(color: AppBasicColors.colors[0]),
              child: const Text(
                '감정 선택하기',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            */
          ...EmotionCategory.values.map((e) {
            return ListTile(
              leading: Icon(
                Icons.label_outline,
                color: AppBasicColors.colors[e.index % 10],
              ),
              title: Text(_getCategoryDisplayName(context, e)),
              onTap: () => _onCategorySelected(context, ref, e),
              selected: selectedCategory == e,
              selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
            );
          }),
          Dividers.divider16,
          const AppLocaleButton(),
          Dividers.divider16,
          // terms button
          ListTile(
            leading: const Icon(Icons.handshake_outlined),
            title: Text(context.loc.termsOfService),
            onTap: () {
              if (context.canPop()) {
                context.pop();
              }
              context.push(ScreenPaths.appTerms);
            },
          ),
          // privacy button
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(context.loc.privacyPolicy),
            onTap: () {
              _pop(context);
              context.push(ScreenPaths.appPrivacy);
            },
          ),
          // app info button
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
    );
  }
}
