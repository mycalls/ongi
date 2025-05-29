// lib/src/features/home/presentation/phrase_body.dart

// 이 파일은 홈 화면의 주요 컨텐츠인 문구를 표시하고 애니메이션하는 `PhraseBody` 위젯을 정의합니다.
// This file defines the `PhraseBody` widget, which displays and animates phrases, the main content of the home screen.

import 'dart:developer' as dev;
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_colors.dart';
import 'package:ongi/src/core/constants/app_constants.dart';
import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/core/extensions/app_loacalizations_context.dart';
import 'package:ongi/src/features/home/presentation/animated_color_box.dart';
import 'package:ongi/src/features/home/services/english_phrase_service.dart';
import 'package:ongi/src/features/home/services/japanese_phrase_service.dart';
import 'package:ongi/src/features/home/services/korean_phrase_service.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';
import 'package:ongi/src/features/home/services/simplified_chinese_phrase_service.dart';
import 'package:ongi/src/features/home/services/spanish_phrase_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// 시간 경과에 따라 다양한 문구를 애니메이션으로 표시하고 화면 켜짐을 관리하는 상태 저장 위젯입니다.
// A stateful widget that displays various phrases with animation over time and manages screen wake lock.
class PhraseBody extends StatefulWidget {
  const PhraseBody({
    super.key,
    required this.phraseTimerInterval,
    required this.languageCode,
    this.selectedCategory = EmotionCategory.general,
    this.selectedGradientColorsIndex,
  });

  final int phraseTimerInterval;

  // 표시될 문구의 언어 코드입니다 (예: 'ko', 'en').
  // The language code for the phrases to be displayed (e.g., 'ko', 'en').
  final String languageCode;

  // 표시될 문구의 감정 카테고리입니다. 기본값은 '일반'입니다.
  // The emotion category for the phrases to be displayed. Defaults to 'general'.
  final EmotionCategory selectedCategory;

  final int? selectedGradientColorsIndex;

  @override
  State<PhraseBody> createState() => _PhraseBodyState();
}

class _PhraseBodyState extends State<PhraseBody>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // 현재 화면에 표시되는 문구입니다.
  // The phrase currently displayed on the screen.
  String _currentPhrase = "";

  int _currentPaletteIndex = 0;

  int? _fixedGradientColorsIndex;

  // 다음 문구로 업데이트하기 위한 타이머입니다.
  // Timer for updating to the next phrase.
  Timer? _phraseTimer;
  // 화면 켜짐 상태를 유지하는 시간을 제어하는 타이머입니다 (기본 30분).
  // Timer to control how long the screen stays awake (default 30 minutes).
  Timer? _wakelockTimer;

  final Random _randomForPhrase = Random();

  final Random _randomForColor = Random();

  // 문구의 페이드 인/아웃 애니메이션을 제어합니다.
  // Controls the fade-in/out animation of the phrase.
  AnimationController? _animationController;
  // `_animationController`에 의해 구동되는 페이드 애니메이션의 현재 값입니다.
  // The current value of the fade animation, driven by `_animationController`.
  Animation<double>? _fadeAnimation;

  // 다음에 표시될 문구입니다. 애니메이션 전환 전에 미리 준비됩니다.
  // The next phrase to be displayed. Prepared before the animation transition.
  String _nextPhrase = "";

  int _nextPaletteIndex = 0;

  // 애니메이션 및 타이머 관련 상수 값들입니다.
  // Constant values related to animations and timers.
  // 문구 페이드 인/아웃 애니메이션 지속 시간입니다.
  // Duration of the phrase fade-in/out animation.
  static const Duration _animationDuration = Duration(
    milliseconds: defaultFadeDuration,
  );
  // 문구 변경 간격입니다. (사라짐(1s) + 나타남(1s) + 대기(10s))
  // Interval for changing phrases. (Fade out (1s) + Fade in (1s) + Wait (10s))
  // static const Duration _phraseTimerInterval = Duration(seconds: 12);
  // Wakelock 관련 상수입니다.
  // Constants related to wakelock.
  // 화면 켜짐 유지 시간입니다.
  // Duration to keep the screen awake.
  static const Duration _wakelockDuration = Duration(
    minutes: defaultWakeLockDuration,
  );

  @override
  void initState() {
    super.initState();

    // 앱의 생명주기 변경 사항(예: 백그라운드 전환)을 감지하기 위해 옵저버를 등록합니다.
    // Register an observer to detect app lifecycle changes (e.g., going to background).
    WidgetsBinding.instance.addObserver(this);
    // 디버깅 로그: 앱 생명주기 옵저버 추가됨
    // Debug log: App lifecycle observer added
    dev.log('App lifecycle observer added');

    _animationController = AnimationController(
      duration: _animationDuration, // 상수 사용
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    _prepareNextContent(widget.selectedCategory);
    _changeColors();
    // 초기 문구를 설정합니다.
    // Set the initial phrase.
    _currentPhrase = _nextPhrase;
    _currentPaletteIndex = _nextPaletteIndex;

    _fixedGradientColorsIndex = widget.selectedGradientColorsIndex;

    // 첫 프레임이 렌더링된 후 애니메이션 컨트롤러 값을 설정하여 문구가 즉시 보이도록 합니다.
    // After the first frame is rendered, set the animation controller's value so the phrase is immediately visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController?.value = 1.0;
      }
    });

    // 문구 자동 변경 타이머를 시작합니다.
    // Start the phrase auto-change timer.
    _startPhraseTimer();

    // 화면 켜짐 유지 타이머를 시작하고 화면 켜짐을 활성화합니다.
    // Start the wakelock timer and enable screen wakefulness.
    _startWakelockTimer();
    WakelockPlus.enable();
    // 디버깅 로그: Wakelock 활성화됨 (initState)
    // Debug log: Wakelock enabled (initState)
    dev.log('Wakelock enabled (initState)');
  }

  // 앱 생명주기 상태가 변경될 때 호출됩니다.
  // Called when the app lifecycle state changes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 디버깅 로그: 앱 생명주기 상태 변경됨: $state
    // Debug log: AppLifecycleState changed: $state
    dev.log('AppLifecycleState changed: $state');

    if (state == AppLifecycleState.resumed) {
      // 앱이 다시 활성화될 때 (예: 백그라운드에서 포그라운드로 돌아올 때).
      // When the app is resumed (e.g., returning from background to foreground).
      // 디버깅 로그: 앱 재개됨 - Wakelock 타이머 재시작 및 Wakelock 활성화
      // Debug log: App resumed - Restarting wakelock timer and enabling wakelock
      dev.log('App resumed - Restarting wakelock timer and enabling wakelock');
      // 화면 켜짐을 다시 활성화하고 Wakelock 타이머를 재시작합니다.
      // Re-enable screen wakefulness and restart the wakelock timer.
      // 만약을 대비해 화면 켜짐을 다시 요청합니다.
      // Request screen wakefulness again, just in case.
      WakelockPlus.enable();
      // 30분 타이머를 재시작합니다.
      // Restart the 30-minute timer.
      _startWakelockTimer();
    } else if (state == AppLifecycleState.paused) {
      // 앱이 비활성화될 때 (예: 백그라운드로 전환될 때).
      // When the app is paused (e.g., going to background).
      // OS가 자동으로 화면 켜짐을 해제할 수 있으므로, 타이머는 취소합니다.
      // 명시적인 disable()은 resumed에서 다시 enable() 하므로 필수는 아니지만, 자원 관점에서 취소하는 것이 좋습니다.
      // The OS might automatically disable screen wakefulness, so cancel the timer.
      // Explicitly calling disable() isn't strictly necessary as enable() is called in resumed,
      // but cancelling is good for resource management.
      // 디버깅 로그: 앱 일시정지됨 - Wakelock 타이머 취소 중
      // Debug log: App paused - Cancelling wakelock timer
      dev.log('App paused - Cancelling wakelock timer');
      _wakelockTimer?.cancel();
      // 이 시점에서는 필수는 아닙니다 (resumed 시 enable됨).
      // Not strictly necessary at this point (enabled on resumed).
      // WakelockPlus.disable();
    }
    // 필요하다면 `inactive` 또는 `detached` 상태에 대한 처리를 여기에 추가합니다.
    // Add handling for `inactive` or `detached` states here if needed.
  }

  // 위젯의 설정(props)이 변경될 때 호출됩니다. (예: 부모 위젯에서 새로운 `selectedCategory` 또는 `languageCode`를 전달받을 때).
  // Called when the widget's configuration (props) changes (e.g., when new `selectedCategory` or `languageCode` is passed from the parent).
  @override
  void didUpdateWidget(covariant PhraseBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory ||
        oldWidget.languageCode != widget.languageCode) {
      // 선택된 카테고리나 언어가 변경되면, 문구를 즉시 새 설정에 맞게 업데이트합니다.
      // If the selected category or language changes, update the phrase immediately to reflect the new settings.
      // 기존 타이머에 의한 업데이트와 겹치지 않도록 하거나, 타이머를 잠시 멈추고 업데이트 후 재시작하는 것을 고려할 수 있습니다.
      // Consider handling potential overlap with timer-based updates, or pause and restart the timer.
      // 여기서는 `_updateContent`를 즉시 호출하여 새 카테고리의 문구를 반영합니다.
      // Here, `_updateContent` is called immediately to reflect the phrase for the new category.
      _updateContent(category: widget.selectedCategory);
    }
    if (oldWidget.phraseTimerInterval != widget.phraseTimerInterval) {
      // Interval 변경 시 타이머 재시작
      // restart timer when interval changes
      _startPhraseTimer();
    }
    if (oldWidget.selectedGradientColorsIndex !=
        widget.selectedGradientColorsIndex) {
      _changeFixedColors(widget.selectedGradientColorsIndex);
    }
  }

  // 주어진 `languageCode`에 따라 적절한 `PhraseService` 구현을 반환합니다.
  // Returns the appropriate `PhraseService` implementation based on the given `languageCode`.
  // 새로운 로케일을 추가하는 경우, 여기에 해당 서비스 구현을 추가해야 합니다.
  // If you add a new locale, you must add its service implementation here.
  PhraseService _getLocalePhrases(String languageCode) {
    switch (languageCode) {
      case 'en':
        return EnglishPhraseService();
      case 'ko':
        return KoreanPhraseService();
      case 'es':
        return SpanishPhraseService();
      case 'ja':
        return JapanesePhraseService();
      case 'zh':
        return SimplifiedChinesePhraseService();
      default:
        return EnglishPhraseService();
    }
  }

  // 다음에 표시할 문구를 준비합니다. 현재 문구와 중복되지 않도록 선택합니다.
  // Prepares the next phrase to be displayed, ensuring it's different from the current one.
  void _prepareNextContent(EmotionCategory category) {
    List<String> phrasesForCategory = _getLocalePhrases(
      widget.languageCode,
    ).getPhrasesForCategory(category);
    if (phrasesForCategory.isNotEmpty) {
      if (phrasesForCategory.length == 1 &&
          phrasesForCategory[0] == _currentPhrase) {
        // 문구가 하나뿐이고 현재 문구와 같다면, 같은 문구를 유지합니다.
        // If there's only one phrase and it's the same as the current one, keep the same phrase.
        _nextPhrase = _currentPhrase;
      } else {
        do {
          _nextPhrase =
              phrasesForCategory[_randomForPhrase.nextInt(
                phrasesForCategory.length,
              )];
        } while (_nextPhrase == _currentPhrase &&
            phrasesForCategory.length >
                1); // 문구가 여러 개 있을 때만 중복 방지 Prevent duplicates only if there are multiple phrases
      }
    } else {
      // 선택된 카테고리에 대한 문구가 없는 경우를 대비한 기본 문구입니다. (이론상 발생하기 어려움)
      // Fallback phrase in case there are no phrases for the selected category (theoretically unlikely).
      _nextPhrase = context.loc.defaultPhrase; // 기본 문구 Default phrase
    }
  }

  // 현재 문구를 페이드 아웃시킨 후, 새로운 문구로 교체하고 페이드 인 애니메이션을 실행합니다.
  // Fades out the current phrase, replaces it with a new one, and runs the fade-in animation.
  Future<void> _updateContent({EmotionCategory? category}) async {
    // 위젯이 마운트되지 않았거나 애니메이션 컨트롤러가 준비되지 않았거나 이미 애니메이션 중이면 아무것도 하지 않습니다.
    // If the widget is not mounted, or the animation controller is not ready, or an animation is already in progress, do nothing.
    if (!mounted ||
        _animationController == null ||
        _animationController!.isAnimating) {
      return;
    }

    final categoryToUse = category ?? widget.selectedCategory;
    _prepareNextContent(categoryToUse);
    _changeColors();
    // 현재 문구를 사라지게 합니다.
    // Fade out the current content.
    await _animationController!.reverse();

    if (mounted) {
      setState(() {
        // 문구 내용을 교체합니다.
        // Replace the content with the new phrase.
        _currentPhrase = _nextPhrase;
        _currentPaletteIndex = _nextPaletteIndex;
      });
    }

    // 새로운 문구를 나타나게 합니다.
    // Fade in the new content.
    await _animationController!.forward();
  }

  // 주기적으로 문구를 업데이트하는 타이머를 시작합니다.
  // Starts a periodic timer to update the phrase.
  void _startPhraseTimer() {
    // 이전에 실행 중이던 문구 타이머가 있다면 취소합니다.
    // Cancel any existing phrase timer before starting a new one.
    _phraseTimer?.cancel();
    _phraseTimer = Timer.periodic(
      Duration(seconds: widget.phraseTimerInterval),
      (timer) {
        // 디버깅 로그: 문구 타이머 이벤트 발생 - 내용 업데이트
        // Debug log: Phrase timer ticked - updating content
        dev.log('Phrase timer ticked - updating content');
        _updateContent();
      },
    );
    // 디버깅 로그: 문구 타이머 시작됨, 간격: $_phraseTimerInterval
    // Debug log: Phrase timer started with interval: $_phraseTimerInterval
    dev.log(
      'Phrase timer started with interval: ${widget.phraseTimerInterval}',
    );
  }

  // 화면 켜짐 유지를 위한 타이머를 시작하거나 재시작합니다.
  // Starts or restarts the timer for keeping the screen awake.
  void _startWakelockTimer() {
    // 이전에 실행 중이던 Wakelock 타이머가 있다면 취소합니다.
    // Cancel any existing wakelock timer.
    _wakelockTimer?.cancel();
    _wakelockTimer = Timer(_wakelockDuration, () {
      // 설정된 시간(`_wakelockDuration`) 후 Wakelock을 해제합니다.
      // After the set duration (`_wakelockDuration`), disable the wakelock.
      // 디버깅 로그: Wakelock 타이머 완료됨 (`_wakelockDuration` 후) - Wakelock 비활성화 중
      // Debug log: Wakelock timer finished after $_wakelockDuration - Disabling wakelock
      dev.log(
        'Wakelock timer finished after $_wakelockDuration - Disabling wakelock',
      );
      WakelockPlus.disable(); // 화면 켜짐을 해제합니다. Disable screen wakefulness.
      // 이 타이머는 일회성이므로 만료 후 자동으로 중지됩니다. 추가적인 `cancel()` 호출은 필요 없습니다.
      // This timer is one-shot, so it stops automatically after expiring. No need for an additional `cancel()` call.
    });
    // 디버깅 로그: Wakelock 타이머 시작됨, 지속 시간: $_wakelockDuration
    // Debug log: Wakelock timer started for $_wakelockDuration
    dev.log('Wakelock timer started for $_wakelockDuration');
  }

  // 화면 탭 시 호출될 함수
  Future<void> _handleTapToChangePhrase() async {
    dev.log('Tap detected by PhraseBody, attempting to change phrase.');
    // 이미 애니메이션 중이면 무시
    if (_animationController != null && _animationController!.isAnimating) {
      dev.log('Phrase change on tap skipped: animation already in progress.');
      return;
    }
    await _updateContent(); // 문구 업데이트
    _startPhraseTimer(); // 문구 변경 타이머 재시작 (탭 이후 간격 유지)
  }

  void _changeColors() {
    if (_fixedGradientColorsIndex != null) {
      dev.log('_fixedGradientColorsIndex: $_fixedGradientColorsIndex');
      return;
    }
    if (BoxGradientColors.gradientPalettes.isEmpty) {
      // 팔레트가 비어있으면 기본값 또는 에러 처리
      dev.log(
        'Error: gradientPalettes is empty. Cannot change colors.',
        error: 'No palettes',
      );
      _nextPaletteIndex = -1; // 또는 -1 등으로 설정 후 다른 곳에서 처리
      return;
    }
    if (BoxGradientColors.gradientPalettes.length == 1) {
      _nextPaletteIndex = 0;
      return;
    }
    do {
      _nextPaletteIndex = _randomForColor.nextInt(
        BoxGradientColors.gradientPalettes.length,
      );
    } while (_nextPaletteIndex == _currentPaletteIndex);
  }

  void _changeFixedColors(int? index) {
    if (index != null) {
      if (index >= BoxGradientColors.gradientPalettes.length) return;
      if (index == _fixedGradientColorsIndex) return;
    }
    if (mounted) {
      setState(() {
        _fixedGradientColorsIndex = index;
      });
    }
  }

  @override
  void dispose() {
    // 앱 생명주기 옵저버를 해제합니다.
    // Remove the app lifecycle observer.
    WidgetsBinding.instance.removeObserver(this);
    // 디버깅 로그: 앱 생명주기 옵저버 제거됨
    // Debug log: App lifecycle observer removed
    dev.log('App lifecycle observer removed');

    // 모든 활성 타이머를 취소합니다.
    // Cancel all active timers.
    _phraseTimer?.cancel();
    // 디버깅 로그: 문구 타이머 취소됨 (dispose)
    // Debug log: Phrase timer cancelled (dispose)
    dev.log('Phrase timer cancelled (dispose)');
    _wakelockTimer?.cancel();
    // 디버깅 로그: Wakelock 타이머 취소됨 (dispose)
    // Debug log: Wakelock timer cancelled (dispose)
    dev.log('Wakelock timer cancelled (dispose)');

    // 애니메이션 컨트롤러를 해제하여 리소스를 반환합니다.
    // Dispose of the animation controller to release its resources.
    _animationController?.dispose();

    // 위젯이 화면에서 사라질 때 화면 켜짐 상태를 해제합니다.
    // Disable screen wakefulness when the widget is disposed.
    WakelockPlus.disable();
    // 디버깅 로그: Wakelock 비활성화됨 (dispose)
    // Debug log: Wakelock disabled (dispose)
    dev.log('Wakelock disabled (dispose)');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // `initState`에서 `_animationController`와 `_fadeAnimation`이 초기화되므로, 이 조건은 이론적으로 거의 발생하지 않습니다. 안전을 위한 방어 코드입니다.
    // Since `_animationController` and `_fadeAnimation` are initialized in `initState`, this condition should theoretically rarely be met. This is a defensive check for safety.
    if (_animationController == null || _fadeAnimation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // PhraseText 위젯 내부에서 Theme.of(context).textTheme을 사용하여 시스템 글꼴 크기 설정을 존중합니다.
    // 스타일을 여기에서 상수로 정의하면 사용자 설정에 대응할 수 없으므로 PhraseText 위젯 내에서 처리하는 것이 바람직합니다.
    // The PhraseText widget uses Theme.of(context).textTheme internally to respect system font size settings.
    // Defining styles as constants here would prevent responsiveness to user settings, so handling it within the PhraseText widget is preferred.

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, _) {
        final double contentOpacity = _fadeAnimation!.value;
        final phraseTextChild = Center(
          child: PhraseText(currentPhrase: _currentPhrase),
        );

        return InkWell(
          onTap: _handleTapToChangePhrase,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [appMainColor, appSecondColor],
              ),
            ),
            child:
                _fixedGradientColorsIndex != null &&
                        _fixedGradientColorsIndex! <
                            BoxGradientColors.gradientPalettes.length
                    ? AnimatedColorBox(
                      colorIndex: _fixedGradientColorsIndex!,
                      child: Opacity(
                        opacity: contentOpacity,
                        child: phraseTextChild,
                      ),
                    )
                    : Opacity(
                      opacity: contentOpacity,
                      child:
                          _currentPaletteIndex == -1
                              ? phraseTextChild
                              : AnimatedColorBox(
                                colorIndex: _currentPaletteIndex,
                                child: phraseTextChild,
                              ),
                    ),
          ),
        );
      },
    );
  }
}

// 문구를 특정 스타일로 표시하는 간단한 상태 없는 위젯입니다.
// A simple stateless widget to display the phrase text with specific styling.
class PhraseText extends StatelessWidget {
  const PhraseText({super.key, required this.currentPhrase});

  final String currentPhrase;

  @override
  Widget build(BuildContext context) {
    // Theme.of(context).textTheme을 사용하여 현재 테마의 텍스트 스타일을 가져오고,
    // 이를 기반으로 스타일을 커스터마이징합니다. 이렇게 하면 사용자의 시스템 글꼴 크기 설정을 존중할 수 있습니다.
    // Uses Theme.of(context).textTheme to get the current theme's text style
    // and customizes it. This approach respects the user's system font size settings.
    final TextStyle? phraseTextStyle = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

    // 아래와 같이 TextStyle을 상수로 정의하면 앱 전체에서 일관된 스타일을 적용할 수 있지만,
    // 사용자의 시스템 글꼴 크기 설정을 반영하지 못하는 단점이 있습니다.
    // 따라서 접근성을 고려할 때 Theme.of(context)를 사용하는 것이 권장됩니다.
    // Defining TextStyle as a constant like below can provide consistent styling across the app,
    // but it has the disadvantage of not reflecting the user's system font size settings.
    // Therefore, using Theme.of(context) is recommended for accessibility.
    /*
    const TextStyle phraseTextStyle = TextStyle(
      fontSize: 28, // 고정된 글꼴 크기 Fixed font size
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(
        255,
        255,
        255,
        0.95,
      ),
      shadows: [
        Shadow(
          blurRadius: 12.0,
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.7,
          ),
          offset: Offset(2.5, 2.5),
        ),
      ],
    );
    */
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          currentPhrase,
          textAlign: TextAlign.center,
          style:
              phraseTextStyle, // 동적으로 생성된 스타일 사용 Use dynamically generated style
        ),
      ),
    );
  }
}
