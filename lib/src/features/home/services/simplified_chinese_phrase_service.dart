// lib/src/features/home/services/simplified_chinese_phrase_service.dart
import 'dart:math';

import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';

class SimplifiedChinesePhraseService implements PhraseService {
  final Random _random = Random();

  static const Map<EmotionCategory, List<String>> _phrases = {
    EmotionCategory.general: [
      "没关系，没关系。",
      "当你觉得为时已晚的时候，恰恰是最早的时候。",
      "眼下的这段时光也一定会过去的。",
      "即使现在感觉难以承受，但你也是一位曾经历并战胜过许多困难的人。",
      "谁都会犯错。",
      "虽然现在难以想象，但这片黑暗一点点散去的日子总会到来的。",
      "一定有真心珍惜你的人。比起别人的评价，你自己的感受更重要。",
      "虽然完全控制情绪很难，但试着慢慢呼吸，练习接受此时此刻。",
      "现在还不晚。",
      "未来是从现在开始一点点创造的。你的选择可以改变那个未来。",
      "不必独自一人，和谁一起吧。",
      "给能帮助你的亲近的人打个电话，然后告诉他们你的情况。",
      "一定会有比现在更好的办法。",
      "什么都不做也没关系，请陪在我们身边。",
      "当你独自难以承受时，你身边有可以与你分担的人。",
      "不要犹豫，请说出来。有很多人想帮助你。",
      "你的存在非常宝贵。有些人不能没有你。",
      "眼前的困难不是永恒的。时间会解决一切。",
      "小小的改变可以带来巨大的希望。",
      "你的生命中还有许多未被发现的美好瞬间。",
      "明天可能和今天不一样。只要撑过今天，明天就会有所不同。",
      "请不要放弃。你的明天还没有开始。",
      "试着和家人、朋友或你信任的人谈谈你的困境。",
      "现在的痛苦不是永恒的。",
      "你不是一个人，有人会陪着你。",
      "虽然现在很艰难，但你有战胜它的力量。看看你已经走了这么远就知道了。",
      "你的存在对某个人来说意义重大。",
      "现在可能感觉彻底崩溃了，但你仍然有重新站起来的可能。",
      "偶尔迷路也没关系，因为你可以找到新的路。",
      "小小的改变可以带来巨大的幸福。",
      "你是这个世界上独一无二的宝贵存在。",
      "暂时停下一切，深呼吸一下吧。",
      "现在这种情绪最终也会过去的。",
      "没关系，你能够顺利度过这个难关的。",
      "休息一下，听听你喜欢的音乐吧。",
      "不用着急，一步一个脚印，慢慢来就好。",
      "如果这种情绪让你难以承受，寻求专业人士的帮助会给你很大的支持。",
    ],
    EmotionCategory.anger: [],
    EmotionCategory.sad: [],
    EmotionCategory.afraid: [],
  };

  @override
  List<String> getPhrasesForCategory(EmotionCategory category) {
    return _phrases[category] ??
        _phrases[EmotionCategory.general] ??
        ["没关系，没关系。"];
  }

  @override
  String getRandomPhraseForCategory(EmotionCategory category) {
    final List<String> categoryPhrases = getPhrasesForCategory(category);
    if (categoryPhrases.isEmpty) {
      // 만약 특정 카테고리 문구가 비었으면, general에서 가져오거나 기본값 반환
      final List<String> generalPhrases = getPhrasesForCategory(
        EmotionCategory.general,
      );
      if (generalPhrases.isEmpty) return "没关系，没关系。"; // 최후의 기본값
      return generalPhrases[_random.nextInt(generalPhrases.length)];
    }
    return categoryPhrases[_random.nextInt(categoryPhrases.length)];
  }
}
