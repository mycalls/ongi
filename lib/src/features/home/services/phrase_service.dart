// lib/src/features/home/services/phrase_service.dart

import 'package:ongi/src/core/constants/emotion_category.dart';

abstract class PhraseService {
  List<String> getPhrasesForCategory(EmotionCategory category);
  String getRandomPhraseForCategory(EmotionCategory category);
}
