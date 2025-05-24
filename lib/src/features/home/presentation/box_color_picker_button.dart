import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ongi/src/core/config/app_settings_controller.dart';
import 'package:ongi/src/core/constants/app_colors.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi/src/shared/utils/show_color_picker.dart';

class BoxColorPickerButton extends ConsumerWidget {
  const BoxColorPickerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(Icons.palette_outlined),
      title: Text(context.loc.selectColor),
      trailing: Consumer(
        builder: (context, ref, child) {
          final currentColorsIndex =
              ref.watch(appSettingsControllerProvider).appGradientColorsIndex;
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors:
                    currentColorsIndex == null ||
                            currentColorsIndex >
                                BoxGradientColors.gradientPalettes.length - 1
                        ? AppBasicColors.rainbowColors
                        : BoxGradientColors
                            .gradientPalettes[currentColorsIndex],
              ),
            ),
          );
        },
      ),

      onTap: () => showColorPicker(context: context),
    );
  }
}
