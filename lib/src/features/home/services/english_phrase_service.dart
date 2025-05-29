// lib/src/features/home/services/english_phrase_service.dart
import 'dart:math';

import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';

class EnglishPhraseService implements PhraseService {
  final Random _random = Random();

  static const Map<EmotionCategory, List<String>> _phrases = {
    EmotionCategory.general: [
      "It's okay. It's okay.",
      "When you think it's too late, that's actually the best time to start.",
      "This moment, too, will surely pass.",
      "Even if it feels overwhelming right now, you've overcome many difficulties before.",
      "Anyone can make mistakes.",
      "It might be hard to imagine now, but a day may come when this darkness gradually lifts.",
      "There's definitely someone who truly cares for you. Your own feelings matter more than others' opinions.",
      "It's hard to fully control your emotions, but try to breathe slowly and practice accepting this present moment.",
      "It's not too late yet.",
      "The future is built little by little, starting now. Your choices can change that future.",
      "You don't have to be alone. Be with someone.",
      "Call someone close who can help you. And talk to them.",
      "There must be a better way than this.",
      "It's okay to do nothing. Just please stay with us.",
      "When it's too hard to bear alone, there are people by your side to share the burden.",
      "Don't hesitate to speak up. There are people who want to help you.",
      "Your existence is precious. There are people who need you.",
      "This current difficulty is not forever. Time can heal.",
      "A small change can bring great hope.",
      "There are many undiscovered beautiful moments in your life.",
      "Tomorrow can be different from today. If you get through today, tomorrow will change.",
      "Don't give up. Your tomorrow hasn't started yet.",
      "Try talking about your difficulties with family, friends, or someone you trust.",
      "This pain isn't forever.",
      "You are not alone. There are people to be with you.",
      "It's tough now, but you have the strength to overcome it. You can tell by how far you've already come.",
      "Your existence means a great deal to someone.",
      "You might feel completely broken now, but there's still a chance to get back up.",
      "It's okay to get lost sometimes. You can just find a new path.",
      "Small changes can bring great happiness.",
      "You are a unique and precious being in this world.",
      "Pause everything for a moment and take a deep breath.",
      "This feeling, too, will eventually pass.",
      "It's okay, you can get through this.",
      "Take a short break and listen to some music you like.",
      "It's okay not to rush. Just take it one step at a time, slowly.",
      "If this emotion feels too overwhelming, seeking professional help can be a great support.",
    ],
    EmotionCategory.anger: [],
    EmotionCategory.sad: [],
    EmotionCategory.afraid: [],
  };

  @override
  List<String> getPhrasesForCategory(EmotionCategory category) {
    return _phrases[category] ??
        _phrases[EmotionCategory.general] ??
        ["It's okay. It's okay."];
  }

  @override
  String getRandomPhraseForCategory(EmotionCategory category) {
    final List<String> categoryPhrases = getPhrasesForCategory(category);
    if (categoryPhrases.isEmpty) {
      final List<String> generalPhrases = getPhrasesForCategory(
        EmotionCategory.general,
      );
      if (generalPhrases.isEmpty) {
        return "It's okay. It's okay.";
      }
      return generalPhrases[_random.nextInt(generalPhrases.length)];
    }
    return categoryPhrases[_random.nextInt(categoryPhrases.length)];
  }
}
