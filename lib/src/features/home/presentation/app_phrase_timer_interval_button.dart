import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/src/core/config/app_settings_controller.dart';
import 'package:ongi/src/core/constants/app_constants.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';

class AppPhraseTimerIntervalButton extends ConsumerWidget {
  const AppPhraseTimerIntervalButton({super.key});

  void _pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }

  static const List<int> _timeIntervals = [
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    20,
    25,
    30,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appPhraseTimerInterval =
        ref.watch(appSettingsControllerProvider).appPhraseTimerInterval;
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
            leading: const Icon(Icons.timer_outlined),
            title: Text(context.loc.phraseChangeInterval),
            trailing: Text(
              appPhraseTimerInterval == null
                  ? '${context.loc.defaultValue} ($defaultAppPhraseTimerInterval${context.loc.seconds})'
                  : '$appPhraseTimerInterval${context.loc.seconds}',
            ),

            leadingAndTrailingTextStyle: Theme.of(context).textTheme.labelLarge,
          ),
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            ref
                .read(appSettingsControllerProvider.notifier)
                .removeAppPhraseTimerInterval();
            _pop(context);
          },
          child: Text(
            '${context.loc.defaultValue} ($defaultAppPhraseTimerInterval${context.loc.seconds})',
          ),
        ),
        ..._timeIntervals.map(
          (interval) => MenuItemButton(
            onPressed: () {
              ref
                  .read(appSettingsControllerProvider.notifier)
                  .setAppPhraseTimerInterval(interval);
              _pop(context);
            },
            child: Text('$interval${context.loc.seconds}'),
          ),
        ),
      ],
    );
  }
}
