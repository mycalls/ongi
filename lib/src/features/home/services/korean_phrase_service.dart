// lib/src/features/home/services/korean_phrase_service.dart
import 'dart:math';

import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';

class KoreanPhraseService implements PhraseService {
  final Random _random = Random();

  static const Map<EmotionCategory, List<String>> _phrases = {
    EmotionCategory.general: [
      "괜찮아. 괜찮아.",
      "늦었다고 생각할 때가 가장 빠른 때입니다.",
      "지금 이 시간도 분명히 지나갈 거예요.",
      "지금 당장은 버거워도, 당신은 그동안 많은 어려움을 견뎌낸 사람이에요.",
      "누구나 실수할 수 있어요.",
      "지금은 상상하기 어려워도, 이 어둠이 조금씩 걷히는 날이 올 수 있어요.",
      "당신을 진심으로 아끼는 사람은 분명히 있어요. 다른 사람의 평가보다, 당신 스스로의 마음이 더 중요해요.",
      "감정을 온전히 통제하긴 어렵지만, 천천히 숨을 쉬며 지금 이 순간을 받아들이는 연습을 해봐요.",
      "아직 늦지 않았어요.",
      "미래는 지금부터 조금씩 만들어가는 거예요. 당신의 선택이 그 미래를 바꿀 수 있어요.",
      "혼자 있지 않아도 돼요. 누군가와 함께해요.",
      "당신을 도울 수 있는 가까운 사람에게 전화하세요. 그리고 말하세요.",
      "지금보다 더 나은 방법이 분명히 있을 거예요.",
      "아무것도 하지 않아도 괜찮습니다. 그저 우리 곁에 있어 주세요.",
      "혼자 감당하기 힘들 때, 당신 곁에는 함께할 사람이 있습니다.",
      "주저하지 말고 말해주세요. 당신을 돕고 싶어 하는 이들이 있습니다.",
      "당신의 존재는 소중합니다. 당신이 없으면 안 되는 사람들이 있습니다.",
      "지금의 어려움은 영원하지 않습니다. 시간이 해결해 줄 수 있습니다.",
      "작은 변화가 큰 희망이 될 수 있습니다.",
      "당신의 삶에는 아직 발견되지 않은 아름다운 순간들이 많습니다.",
      "내일은 오늘과 다를 수 있습니다. 오늘을 버텨내면 내일이 달라질 거예요.",
      "포기하지 마세요. 당신의 내일은 아직 시작되지 않았습니다.",
      "가족, 친구, 혹은 믿을 수 있는 사람에게 당신의 어려움을 이야기해 보세요.",
      "지금 이 고통은 영원하지 않아요.",
      "당신은 혼자가 아니에요. 함께할 사람이 있어요.",
      "지금은 힘들지만, 당신에게는 이겨낼 힘이 있어요. 이미 여기까지 온 걸 보면 알 수 있어요.",
      "당신의 존재는 누군가에게 큰 의미가 있어요.",
      "지금은 완전히 무너진 것처럼 느껴질 수 있지만, 다시 일어설 가능성도 있어요.",
      "가끔은 길을 잃어도 괜찮아요. 새로운 길을 찾으면 되니까요.",
      "작은 변화가 큰 행복을 가져다줄 수 있어요.",
      "당신은 이 세상에 단 하나뿐인 소중한 존재예요.",
      "잠시 모든 것을 멈추고, 깊게 숨을 쉬어보세요.",
      "지금 이 감정도 결국엔 지나갈 거예요.",
      "괜찮아요, 당신은 이 상황을 잘 헤쳐나갈 수 있어요.",
      "잠시 쉬며, 좋아하는 음악을 들어보세요.",
      "조급해하지 않아도 괜찮아요. 한 번에 한 걸음씩, 천천히 나아가면 돼요.",
      "이 감정이 너무 감당하기 힘들다면, 전문가의 도움을 받는 것이 큰 힘이 될 수 있습니다.",
    ],
    EmotionCategory.anger: [],
    EmotionCategory.sad: [],
    EmotionCategory.afraid: [],
  };

  @override
  List<String> getPhrasesForCategory(EmotionCategory category) {
    return _phrases[category] ??
        _phrases[EmotionCategory.general] ??
        ["괜찮아. 괜찮아."];
  }

  @override
  String getRandomPhraseForCategory(EmotionCategory category) {
    final List<String> categoryPhrases = getPhrasesForCategory(category);
    if (categoryPhrases.isEmpty) {
      // 만약 특정 카테고리 문구가 비었으면, general에서 가져오거나 기본값 반환
      final List<String> generalPhrases = getPhrasesForCategory(
        EmotionCategory.general,
      );
      if (generalPhrases.isEmpty) return "괜찮아. 괜찮아."; // 최후의 기본값
      return generalPhrases[_random.nextInt(generalPhrases.length)];
    }
    return categoryPhrases[_random.nextInt(categoryPhrases.length)];
  }
}
