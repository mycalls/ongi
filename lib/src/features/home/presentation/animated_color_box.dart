// lib/src/features/home/presentation/animated_color_box.dart

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_colors.dart';
import 'package:ongi/src/core/constants/app_constants.dart';

class AnimatedColorBox extends StatefulWidget {
  const AnimatedColorBox({super.key, required this.colorIndex, this.child});

  final int colorIndex;

  // The child widget to be rendered móvil the animated background.
  // 애니메이션 배경 위에 렌더링될 자식 위젯입니다.
  final Widget? child;

  @override
  State<AnimatedColorBox> createState() => _AnimatedColorBoxState();
}

class _AnimatedColorBoxState extends State<AnimatedColorBox>
    with SingleTickerProviderStateMixin {
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
      duration: Duration(milliseconds: defaultGradientChangeCycle),
      vsync: this,
    );

    // Initialize with a random palette index.
    // 랜덤 팔레트 인덱스로 초기화합니다.

    _updateColorsAndAnimation();

    _controller?.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant AnimatedColorBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colorIndex != widget.colorIndex) {
      _updateColorsAndAnimation();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Updates the color animations based on the currently selected palette.
  // 현재 선택된 팔레트를 기반으로 색상 애니메이션을 업데이트합니다.
  void _updateColorsAndAnimation() {
    if (_controller == null ||
        BoxGradientColors.gradientPalettes.isEmpty ||
        widget.colorIndex < 0 ||
        widget.colorIndex >= BoxGradientColors.gradientPalettes.length) {
      dev.log('Invalid colorIndex or empty palettes in AnimatedColorBox.');
      return;
    }

    final selectedPalette =
        BoxGradientColors.gradientPalettes[widget.colorIndex];
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

    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, _) {
        // The child from AnimatedBuilder is not used here. / AnimatedBuilder의 child는 여기서 사용되지 않습니다.
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _currentAnimationOne?.value ?? appMainColor,
                _currentAnimationTwo?.value ?? appSecondColor,
              ],
            ),
          ),
          child:
              widget
                  .child, // Use the child passed to AnimatedColorBox. / AnimatedColorBox에 전달된 child를 사용합니다.
        );
      },
    );
  }
}
