// lib/src/features/home/presentation/animated_color_box.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_colors.dart';

class AnimatedColorBox extends StatefulWidget {
  const AnimatedColorBox({
    super.key,
    this.milliseconds = 3000,
    this.isRepeat = true,
    this.child,
  });

  // Duration of one cycle of the color transition animation.
  // 색상 전환 애니메이션 한 사이클의 지속 시간입니다.
  final int milliseconds;

  // Whether the animation should repeat. If true, colors will continuously transition back and forth.
  // 애니메이션을 반복할지 여부입니다. true이면 색상이 계속해서 앞뒤로 전환됩니다.
  final bool isRepeat;

  // The child widget to be rendered móvil the animated background.
  // 애니메이션 배경 위에 렌더링될 자식 위젯입니다.
  final Widget? child;

  @override
  State<AnimatedColorBox> createState() => _AnimatedColorBoxState();
}

class _AnimatedColorBoxState extends State<AnimatedColorBox>
    with SingleTickerProviderStateMixin {
  // Index of the currently selected color palette from AppColors.gradientPalettes.
  // AppColors.gradientPalettes에서 현재 선택된 색상 팔레트의 인덱스입니다.
  int _selectedPaletteIndex = 0;

  AnimationController? _controller;
  // Animation object for the first color in the gradient.
  // 그라데이션의 첫 번째 색상에 대한 애니메이션 객체입니다.
  Animation<Color?>? _currentAnimationOne;
  // Animation object for the second color in the gradient.
  // 그라데이션의 두 번째 색상에 대한 애니메이션 객체입니다.
  Animation<Color?>? _currentAnimationTwo;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    );

    // Initialize with a random palette index.
    // 랜덤 팔레트 인덱스로 초기화합니다.
    if (BoxGradientColors.gradientPalettes.isNotEmpty) {
      _selectedPaletteIndex = Random().nextInt(
        BoxGradientColors.gradientPalettes.length,
      );
    }

    _updateColorsAndAnimation();

    if (widget.isRepeat) {
      _controller?.repeat(reverse: true);
    } else {
      _controller?.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Called when the widget is tapped. Changes the color palette and restarts the animation.
  // 위젯을 탭했을 때 호출됩니다. 색상 팔레트를 변경하고 애니메이션을 다시 시작합니다.
  void _handleTap() {
    // 1. Select a new palette (different from the previous one).
    // 1. 새 팔레트 선택 (이전과 다른 팔레트).
    int newPaletteIndex = _selectedPaletteIndex;
    if (BoxGradientColors.gradientPalettes.length > 1) {
      while (newPaletteIndex == _selectedPaletteIndex) {
        newPaletteIndex = Random().nextInt(
          BoxGradientColors.gradientPalettes.length,
        );
      }
    }
    _selectedPaletteIndex = newPaletteIndex;

    // If the controller is available, update and restart the animation.
    // 컨트롤러가 사용 가능하면 애니메이션을 업데이트하고 다시 시작합니다.
    if (_controller != null) {
      _updateColorsAndAnimation(); // Update animation with the new palette. / 새 팔레트로 애니메이션을 업데이트합니다.

      _controller!.reset(); // Reset animation to 0.0. / 애니메이션을 0.0으로 리셋합니다.
      if (widget.isRepeat) {
        _controller!.repeat(reverse: true);
      } else {
        _controller!.forward();
      }
    }

    // Notify Flutter that the state has changed, so it rebuilds the widget.
    // Flutter에 상태가 변경되었음을 알려 위젯을 다시 빌드하도록 합니다.
    setState(() {});
  }

  // Updates the color animations based on the currently selected palette.
  // 현재 선택된 팔레트를 기반으로 색상 애니메이션을 업데이트합니다.
  void _updateColorsAndAnimation() {
    if (_controller == null || BoxGradientColors.gradientPalettes.isEmpty) {
      return;
    }
    // Ensure _selectedPaletteIndex is within bounds.
    // _selectedPaletteIndex가 범위 내에 있는지 확인합니다.
    if (_selectedPaletteIndex >= BoxGradientColors.gradientPalettes.length) {
      _selectedPaletteIndex =
          0; // Fallback to the first palette. / 첫 번째 팔레트로 대체합니다.
    }

    final selectedPalette =
        BoxGradientColors.gradientPalettes[_selectedPaletteIndex];
    final firstColor = selectedPalette[0];
    final secondColor = selectedPalette[1];

    _currentAnimationOne = ColorTween(
      begin: firstColor,
      end: secondColor,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOutSine));
    _currentAnimationTwo = ColorTween(
      begin: secondColor,
      end: firstColor,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOutSine));
  }

  @override
  Widget build(BuildContext context) {
    // Fallback UI if controller or animations are not yet initialized.
    // 컨트롤러나 애니메이션이 아직 초기화되지 않은 경우의 대체 UI입니다.
    if (_controller == null ||
        _currentAnimationOne == null ||
        _currentAnimationTwo == null) {
      return Container(
        color:
            Theme.of(
              context,
            ).colorScheme.primary, // Default background. / 기본 배경색입니다.
        child: widget.child,
      );
    }

    return InkWell(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, _) {
          // The child from AnimatedBuilder is not used here. / AnimatedBuilder의 child는 여기서 사용되지 않습니다.
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _currentAnimationOne!.value ??
                      BoxGradientColors
                          .gradientPalettes[_selectedPaletteIndex][0],
                  _currentAnimationTwo!.value ??
                      BoxGradientColors
                          .gradientPalettes[_selectedPaletteIndex][1],
                ],
              ),
            ),
            child:
                widget
                    .child, // Use the child passed to AnimatedColorBox. / AnimatedColorBox에 전달된 child를 사용합니다.
          );
        },
      ),
    );
  }
}
