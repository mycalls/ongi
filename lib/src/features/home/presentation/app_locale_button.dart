import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/l10n/app_localizations.dart';
import 'package:ongi/src/core/config/app_settings_controller.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';

class AppLocaleButton extends ConsumerWidget {
  const AppLocaleButton({super.key});

  void _pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const locales = AppLocalizations.supportedLocales;
    final languageCode =
        ref.watch(appSettingsControllerProvider).appLocale?.languageCode;
    return MenuAnchor(
      style: const MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24)),
      ),
      builder:
          (context, controller, child) => ListTile(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                FocusScope.of(context).unfocus();
                controller.open();
              }
            },
            leading: const Icon(Icons.language),
            title: Text(context.loc.appLanguage),
            trailing:
                languageCode == null
                    ? Text(context.loc.systemLanguage)
                    : selectedLanguage(languageCode),
            leadingAndTrailingTextStyle: Theme.of(context).textTheme.labelLarge,
          ),
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            ref.read(appSettingsControllerProvider.notifier).removeAppLocale();
            _pop(context);
          },
          child: Text(context.loc.systemLanguage),
        ),
        ...locales.map(
          (locale) => MenuItemButton(
            onPressed: () {
              ref
                  .read(appSettingsControllerProvider.notifier)
                  .setAppLocale(locale.languageCode);
              _pop(context);
            },
            child: selectedLanguage(locale.languageCode),
          ),
        ),
      ],
    );
  }

  // if you add a new locale, add it here
  Widget selectedLanguage(String langugaeCode) {
    switch (langugaeCode) {
      case 'en':
        return const Text('English');
      case 'ko':
        return const Text('한국어');
      case 'es':
        return const Text('Español');
      case 'ja':
        return const Text('日本語');
      case 'zh':
        return const Text('中文简体');
      default:
        return const Text('English');
    }
  }
}
