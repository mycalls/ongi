// lib/constants/app_colors.dart (새로운 파일 또는 기존 constants 파일에 추가)

import 'package:flutter/material.dart';

class BoxGradientColors {
  BoxGradientColors._(); // 인스턴스 생성 방지

  static const List<List<Color>> gradientPalettes = [
    // 기존 팔레트
    [Color(0xFFede342), Color(0xFFff51eb)],
    [Color(0xFF439cfb), Color(0xFFf187fb)],
    [Color(0xFF0061FF), Color(0xFF60efff)],
    [Color(0xFFf4f269), Color(0xFF5cb270)],
    [Color(0xFFff0f7b), Color(0xFFf89b29)],
    [Color(0xFF5D4157), Color(0xFFA8CABA)],
    [Color(0xFF61f4de), Color(0xFF6e78ff)],
    [Color(0xFFb79c05), Color(0xFF161616)],
    [Color(0xFF42047e), Color(0xFF07f49e)],
    [Color(0xFF40c9ff), Color(0xFFe81cff)],
    [Color(0xFFeca0ff), Color(0xFF84ffc9)],
    [Color(0xFFffa585), Color(0xFFffeda0)],
    [Color(0xFFffcf67), Color(0xFFd3321d)],
    [Color(0xFFe2db1f), Color(0xFFae10f9)],
    [Color(0xFFffefc1), Color(0xFF874f9e)],
    [Color(0xFFf7a2a1), Color(0xFFffed00)],
    [Color(0xFFf86ca7), Color(0xFFf4d444)],
    [Color(0xFFce9eec), Color(0xFF3a7ff2)],
    [Color(0xFFd46c76), Color(0xFFffc07c)],
    [Color(0xFFfc5c7d), Color(0xFF6a82fb)],
    [Color(0xFFbf0fff), Color(0xFFcbff49)],
    [Color(0XFF432371), Color(0xFFfaae7b)],
    [Color(0xFF1dbde6), Color(0xFFf1515e)],
    [Color(0xFFf5c900), Color(0xFF183182)],

    // 추가 팔레트 (따뜻한 느낌, 차분한 느낌, 밝은 느낌 등 다양하게)
    // [Color(0xFFf83600), Color(0xFFf9d423)], // 6. 오렌지-옐로우 (따뜻함)
    // [Color(0xFF00c6ff), Color(0xFF0072ff)], // 7. 스카이블루-블루 (시원함)
    // [Color(0xFFa8e063), Color(0xFF56ab2f)], // 8. 라이트그린-그린 (자연)
    // [Color(0xFFfc5c7d), Color(0xFF6a82fb)], // 9. 코랄-퍼플블루 (부드러움)
    // [Color(0xFF8e2de2), Color(0xFF4a00e0)], // 10. 퍼플-딥퍼플 (신비로움)

    // [Color(0xFFff9a9e), Color(0xFFfad0c4)], // 11. 옅은 핑크-살구 (부드러운 파스텔)
    // [Color(0xFFa1c4fd), Color(0xFFc2e9fb)], // 12. 옅은 블루-스카이 (부드러운 파스텔)
    // [Color(0xFF667eea), Color(0xFF764ba2)], // 13. 블루퍼플-퍼플 (몽환적)
    // [Color(0xFFffdde1), Color(0xFFee9ca7)], // 14. 핑크-로즈 (사랑스러움)
    // [Color(0xFFc1dfc4), Color(0xFFdeecdd)], // 15. 옅은 그린-페일그린 (평온함)

    // [Color(0xFFf093fb), Color(0xFFf5576c)], // 16. 마젠타-레드핑크 (활기참)
    // [Color(0xFF4facfe), Color(0xFF00f2fe)], // 17. 밝은 블루-아쿠아 (청량함)
    // [Color(0xFFfa709a), Color(0xFFfee140)], // 18. 핑크-골드 (화려함)
    // [Color(0xFF30cfd0), Color(0xFF330867)], // 19. 터콰이즈-딥퍼플 (우주)
    // [Color(0xFFa8c0ff), Color(0xFF3f2b96)], // 20. 페일블루-인디고 (차분함)

    // [Color(0xFF76b852), Color(0xFF8DC26F)], // 21. 그린-라이트그린 (싱그러움)
    // [Color(0xFFFBD3E9), Color(0xFFBB377D)], // 22. 베이비핑크-핫핑크 (대비)
    // [Color(0xFF182848), Color(0xFF4b6cb7)], // 23. 다크블루-블루 (깊이감)
    // [Color(0xFFff7e5f), Color(0xFFfeb47b)], // 24. 코랄-살몬 (따스함)
    // [Color(0xFF6a11cb), Color(0xFF2575fc)], // 25. 바이올렛-블루 (세련됨)
    // 기존 팔레트 (순서 변경 및 중복 제거)
    // [Color(0xFF5D4157), Color(0xFFA8CABA)], // 26. 딥퍼플-민트 (독특함) - 기존 6번
    // [Color(0xFF61f4de), Color(0xFF6e78ff)], // 27. 민트-라벤더 (부드러움) - 기존 7번
    // [Color(0xFFb79c05), Color(0xFF161616)], // 28. 골드-블랙 (고급스러움) - 기존 8번
    // [Color(0xFF42047e), Color(0xFF07f49e)], // 29. 딥퍼플-네온그린 (강렬함) - 기존 9번
    // [Color(0xFF40c9ff), Color(0xFFe81cff)], // 30. 블루-마젠타 (화려함) - 기존 10번
    // --> 위 5개는 이미 좋은 조합이므로 포함시키되, 번호를 이어가겠습니다.
    // [Color(0xFF5D4157), Color(0xFFA8CABA)], // 26.
    // [Color(0xFF61f4de), Color(0xFF6e78ff)], // 27.
    // [Color(0xFFb79c05), Color(0xFF161616)], // 28.
    // [Color(0xFF42047e), Color(0xFF07f49e)], // 29.
    // [Color(0xFF40c9ff), Color(0xFFe81cff)], // 30.
  ];
}

class AppBasicColors {
  AppBasicColors._(); // 인스턴스 생성 방지

  static const List<Color> colors = [
    Color(0xFFFF930F),
    Color(0xFF4CB0A6),
    Color(0xFFFF6F68),
    Color(0xFF5cb270),
    Color(0xFFffa8bd),
    Color(0xFFb79c05),
    Color(0xFF00ACA5),
    Color(0xFFEE84B3),
    Color(0xFF20503E),
    Color(0xFFB57E79),
  ];

  static const List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
}
