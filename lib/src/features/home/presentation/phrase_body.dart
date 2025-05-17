// lib/src/features/home/presentation/phrase_body.dart

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ongi_app/src/constants/comfort_phrases.dart';
import 'package:ongi_app/src/features/home/presentation/animated_color_box.dart';

class PhraseBody extends StatefulWidget {
  const PhraseBody({
    super.key,
    this.selectedCategory = EmotionCategory.general,
  });

  final EmotionCategory selectedCategory;

  @override
  State<PhraseBody> createState() => _PhraseBodyState();
}

class _PhraseBodyState extends State<PhraseBody>
    with SingleTickerProviderStateMixin {
  String _currentPhrase = "";

  Timer? _timer;
  final Random _random = Random();

  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  String _nextPhrase = "";

  // 애니메이션 및 타이머 관련 상수 값들 (선택적 개선 사항)
  static const Duration _animationDuration = Duration(milliseconds: 1500);
  static const Duration _timerInterval = Duration(
    seconds: 7,
  ); // 사라짐(1.5s) + 나타남(1.5s) + 대기(4s)

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: _animationDuration, // 상수 사용
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    _prepareNextContent(widget.selectedCategory);
    _currentPhrase = _nextPhrase; // 초기 문구 설정

    // 첫 화면이 즉시 보이도록 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController?.value = 1.0;
      }
    });

    _startTimer();
  }

  // 위젯의 프로퍼티가 변경될 때 호출됨 (부모로부터 새로운 selectedCategory를 받을 때)
  @override
  void didUpdateWidget(covariant PhraseBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      // 카테고리가 변경되면 문구를 즉시 업데이트 (애니메이션과 함께)
      // 기존 타이머에 의한 업데이트와 겹치지 않도록 처리하거나,
      // 타이머를 잠시 멈추고 업데이트 후 재시작하는 것을 고려할 수 있음.
      // 여기서는 즉시 _updateContent를 호출하여 새 카테고리의 문구를 반영.
      // _updateContent 내에서 _prepareNextContent가 새 카테고리를 사용하도록 수정 필요.
      _updateContent(category: widget.selectedCategory);
    }
  }

  void _prepareNextContent(EmotionCategory category) {
    // _currentCategory가 nullable이 아니므로 ! 제거 가능
    List<String> phrasesForCategory = ComfortPhrases.getPhrasesForCategory(
      category,
    );
    if (phrasesForCategory.isNotEmpty) {
      _nextPhrase =
          phrasesForCategory[_random.nextInt(phrasesForCategory.length)];
    } else {
      // 이 경우는 거의 발생하지 않겠지만, 안전장치
      _nextPhrase = "오늘도 좋은 하루 보내세요.";
    }
  }

  Future<void> _updateContent({EmotionCategory? category}) async {
    if (!mounted ||
        _animationController == null ||
        _animationController!.isAnimating) {
      return;
    }

    final categoryToUse = category ?? widget.selectedCategory;
    _prepareNextContent(categoryToUse);

    await _animationController!.reverse(); // 현재 내용 사라짐

    if (mounted) {
      setState(() {
        _currentPhrase = _nextPhrase; // 내용 교체
      });
    }

    await _animationController!.forward(); // 새 내용 나타남
  }

  void _startTimer() {
    _timer = Timer.periodic(_timerInterval, (timer) {
      // 상수 사용
      _updateContent();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController == null || _fadeAnimation == null) {
      // 이 부분은 initState에서 _animationController와 _fadeAnimation이
      // null이 아닌 값으로 초기화되므로, 이론적으로는 거의 도달하지 않습니다.
      // 하지만 안전을 위해 남겨두는 것은 좋습니다.
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 텍스트 스타일 상수화 (선택적 개선 사항)
    const TextStyle phraseTextStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(
        255,
        255,
        255,
        0.95,
      ), // Colors.white.withOpacity(0.95) 와 동일
      shadows: [
        Shadow(
          blurRadius: 12.0,
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.7,
          ), // Colors.black.withOpacity(0.7) 와 동일
          offset: Offset(2.5, 2.5),
        ),
      ],
    );

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        final double contentOpacity = _fadeAnimation!.value;

        return AnimatedColorBox(
          child: Center(
            child: Opacity(
              opacity: contentOpacity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _currentPhrase,
                  textAlign: TextAlign.center,
                  style: phraseTextStyle, // 상수화된 스타일 사용
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
