// lib/src/features/home/providers/main_category_provider.dart
import 'package:ongi_app/src/core/constants/emotion_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_category_provider.g.dart';

@Riverpod(keepAlive: true)
class MainCategory extends _$MainCategory {
  @override
  EmotionCategory build() {
    return EmotionCategory.general;
  }

  void set(EmotionCategory category) {
    state = category;
  }
}
