// lib/src/features/home/services/spanish_phrase_service.dart
import 'dart:math';

import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';

class SpanishPhraseService implements PhraseService {
  final Random _random = Random();

  static const Map<EmotionCategory, List<String>> _phrases = {
    EmotionCategory.general: [
      "Está bien. Está bien.",
      "Cuando piensas que es tarde, es en realidad el momento más oportuno.",
      "Este momento también pasará.",
      "Aunque ahora te parezca abrumador, has superado muchas dificultades antes.",
      "Cualquiera puede cometer errores.",
      "Aunque ahora sea difícil de imaginar, puede llegar un día en que esta oscuridad se disipe poco a poco.",
      "Definitivamente hay alguien que te quiere de verdad. Tus propios sentimientos son más importantes que la opinión de los demás.",
      "Es difícil controlar completamente las emociones, pero intenta respirar lentamente y practica aceptar este momento presente.",
      "Aún no es tarde.",
      "El futuro se construye poco a poco desde ahora. Tus elecciones pueden cambiar ese futuro.",
      "No tienes que estar solo/a. Busca la compañía de alguien.",
      "Llama a alguien cercano que pueda ayudarte. Y habla con esa persona.",
      "Seguro que hay una forma mejor que esta.",
      "Está bien no hacer nada. Solo quédate a nuestro lado, por favor.",
      "Cuando es demasiado difícil de sobrellevar solo/a, hay personas a tu lado para compartir la carga.",
      "No dudes en decirlo. Hay personas que quieren ayudarte.",
      "Tu existencia es valiosa. Hay personas que te necesitan.",
      "Esta dificultad actual no es para siempre. El tiempo puede ayudar a resolverlo.",
      "Un pequeño cambio puede traer una gran esperanza.",
      "Hay muchos momentos hermosos aún por descubrir en tu vida.",
      "Mañana puede ser diferente a hoy. Si superas el día de hoy, el mañana cambiará.",
      "No te rindas. Tu mañana aún no ha comenzado.",
      "Intenta hablar de tus dificultades con tu familia, amigos o alguien en quien confíes.",
      "Este dolor no es para siempre.",
      "No estás solo/a. Hay gente que te acompaña.",
      "Ahora es difícil, pero tienes la fuerza para superarlo. Se nota por lo lejos que ya has llegado.",
      "Tu existencia tiene un gran significado para alguien.",
      "Puede que ahora te sientas completamente destrozado/a, pero aún existe la posibilidad de levantarse.",
      "A veces está bien perderse. Simplemente puedes encontrar un nuevo camino.",
      "Pequeños cambios pueden traer gran felicidad.",
      "Eres un ser único y valioso en este mundo.",
      "Detén todo por un momento y respira profundamente.",
      "Este sentimiento también pasará con el tiempo.",
      "Está bien, puedes superar esta situación.",
      "Tómate un breve descanso y escucha algo de música que te guste.",
      "No hay por qué apurarse. Solo da un paso a la vez, lentamente.",
      "Si esta emoción es demasiado abrumadora, buscar ayuda profesional puede ser un gran apoyo.",
    ],
    EmotionCategory.anger: [],
    EmotionCategory.sad: [],
    EmotionCategory.afraid: [],
  };

  @override
  List<String> getPhrasesForCategory(EmotionCategory category) {
    return _phrases[category] ??
        _phrases[EmotionCategory.general] ??
        ["Está bien. Está bien."];
  }

  @override
  String getRandomPhraseForCategory(EmotionCategory category) {
    final List<String> categoryPhrases = getPhrasesForCategory(category);
    if (categoryPhrases.isEmpty) {
      // 만약 특정 카테고리 문구가 비었으면, general에서 가져오거나 기본값 반환
      final List<String> generalPhrases = getPhrasesForCategory(
        EmotionCategory.general,
      );
      if (generalPhrases.isEmpty) {
        return "Está bien. Está bien."; // 최후의 기본값
      }
      return generalPhrases[_random.nextInt(generalPhrases.length)];
    }
    return categoryPhrases[_random.nextInt(categoryPhrases.length)];
  }
}
