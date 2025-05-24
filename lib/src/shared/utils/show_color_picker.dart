// lib/src/shared/utils/show_color_picker.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/src/core/config/app_settings_controller.dart';
import 'package:ongi/src/core/constants/app_colors.dart';
import 'package:ongi/src/core/constants/app_constants.dart';

Future<void> showColorPicker({required BuildContext context}) async {
  return showDialog(
    context: context,
    builder: (context) => Dialog(child: CustomColorPicker()),
  );
}

class CustomColorPicker extends ConsumerWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentColorIndex =
        ref.watch(appSettingsControllerProvider).appGradientColorsIndex;
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: BoxGradientColors.gradientPalettes.length + 1,
      itemBuilder: (context, index) {
        // 기본값으로 sharedPreference에 저장된 값이 없으며, 랜덤으로 선택된 컬러 적용
        if (index == 0) {
          return InkWell(
            onTap: () {
              if (currentColorIndex != null) {
                ref
                    .read(appSettingsControllerProvider.notifier)
                    .removeAppGradientColorsIndex();
              }
              if (context.canPop()) {
                context.pop();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppBasicColors.rainbowColors),
              ),
              child:
                  currentColorIndex == null
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
            ),
          );
        }

        // 랜덤컬러를 0번으로 지정했기 때문에 index - 1을 해줘야 컬러 팔레트에서 0번부터 선택 가능
        final colorIndexInPalette = index - 1;
        final currentGradientColors =
            BoxGradientColors.gradientPalettes[colorIndexInPalette];
        return InkWell(
          onTap: () {
            if (currentColorIndex != colorIndexInPalette) {
              ref
                  .read(appSettingsControllerProvider.notifier)
                  .setAppGradientColorsIndex(colorIndexInPalette);
            }
            if (context.canPop()) {
              context.pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors:
                    currentGradientColors.length >= 2
                        ? [currentGradientColors[0], currentGradientColors[1]]
                        : [appMainColor, appSecondColor],
              ),
            ),
            child:
                currentColorIndex == colorIndexInPalette
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
          ),
        );
      },
    );
  }
}
