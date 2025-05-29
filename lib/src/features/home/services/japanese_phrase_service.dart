// lib/src/features/home/services/japanese_phrase_service.dart
import 'dart:math';

import 'package:ongi/src/core/constants/emotion_category.dart';
import 'package:ongi/src/features/home/services/phrase_service.dart';

class JapanesePhraseService implements PhraseService {
  final Random _random = Random();

  static const Map<EmotionCategory, List<String>> _phrases = {
    EmotionCategory.general: [
      "大丈夫。大丈夫だよ。",
      "遅いと思った時が、一番早い時です。",
      "今この時間も、きっと過ぎ去ります。",
      "今は辛くても、あなたはこれまで多くの困難を乗り越えてきた人です。",
      "誰だって失敗することはありますよ。",
      "今は想像しにくいかもしれませんが、この暗闇が少しずつ晴れていく日が来るかもしれません。",
      "あなたのことを心から大切に思っている人は必ずいます。他の人の評価よりも、あなた自身の気持ちがもっと大切です。",
      "感情を完全にコントロールするのは難しいですが、ゆっくりと息をして、今のこの瞬間を受け入れる練習をしてみましょう。",
      "まだ遅くありません。",
      "未来は今から少しずつ作っていくものです。あなたの選択がその未来を変えることができます。",
      "一人でいなくても大丈夫です。誰かと一緒にいましょう。",
      "あなたを助けることができる身近な人に電話してください。そして、話してみてください。",
      "今よりもっと良い方法がきっとあるはずです。",
      "何も しなくても大丈夫です。ただ、私たちのそばにいてください。",
      "一人で抱えきれない時、あなたのそばには一緒にいてくれる人がいます。",
      "ためらわずに話してください。あなたを助けたいと思っている人たちがいます。",
      "あなたの存在は大切です。あなたがいなければ困る人たちがいます。",
      "今の困難は永遠ではありません。時間が解決してくれることもあります。",
      "小さな変化が大きな希望になることがあります。",
      "あなたの人生には、まだ発見されていない美しい瞬間がたくさんあります。",
      "明日は今日と違うかもしれません。今日を乗り越えれば、明日が変わるでしょう。",
      "諦めないでください。あなたの明日はまだ始まっていません。",
      "家族、友人、あるいは信頼できる人にあなたの困難を話してみてください。",
      "今のこの苦しみは永遠ではありません。",
      "あなたは一人ではありません。一緒にいてくれる人がいます。",
      "今は大変ですが、あなたには乗り越える力があります。ここまで来られたことを見ればわかります。",
      "あなたの存在は誰かにとって大きな意味を持っています。",
      "今は完全に打ちのめされたように感じるかもしれませんが、再び立ち上がる可能性もあります。",
      "時には道に迷っても大丈夫です。新しい道を見つければいいのですから。",
      "小さな変化が大きな幸せをもたらすことがあります。",
      "あなたはこの世にただ一人の大切な存在です。",
      "少しの間すべてを止めて、深呼吸してみてください。",
      "今のこの感情も、結局は過ぎ去っていくでしょう。",
      "大丈夫です、あなたならこの状況を乗り越えられますよ。",
      "少し休んで、好きな音楽を聴いてみてください。",
      "焦らなくても大丈夫です。一歩ずつ、ゆっくりと進めばいいのです。",
      "この感情があまりにも耐え難い場合は、専門家の助けを求めることが大きな力になることがあります。",
    ],
    EmotionCategory.anger: [],
    EmotionCategory.sad: [],
    EmotionCategory.afraid: [],
  };

  @override
  List<String> getPhrasesForCategory(EmotionCategory category) {
    return _phrases[category] ??
        _phrases[EmotionCategory.general] ??
        ["大丈夫。大丈夫だよ。"];
  }

  @override
  String getRandomPhraseForCategory(EmotionCategory category) {
    final List<String> categoryPhrases = getPhrasesForCategory(category);
    if (categoryPhrases.isEmpty) {
      // 만약 특정 카테고리 문구가 비었으면, general에서 가져오거나 기본값 반환
      final List<String> generalPhrases = getPhrasesForCategory(
        EmotionCategory.general,
      );
      if (generalPhrases.isEmpty) return "大丈夫。大丈夫だよ。"; // 최후의 기본값
      return generalPhrases[_random.nextInt(generalPhrases.length)];
    }
    return categoryPhrases[_random.nextInt(categoryPhrases.length)];
  }
}
