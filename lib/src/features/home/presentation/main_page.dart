import 'package:flutter/material.dart';
import 'package:ongi_app/src/constants/app_colors.dart';
import 'package:ongi_app/src/constants/comfort_phrases.dart';
import 'package:ongi_app/src/features/home/presentation/phrase_body.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  EmotionCategory _selectedCategory = EmotionCategory.general; // 현재 선택된 카테고리

  // Drawer에서 항목 선택 시 호출될 콜백 함수
  void _onCategorySelected(EmotionCategory category) {
    setState(() {
      _selectedCategory = category;
    });
    Navigator.pop(context); // Drawer 닫기
  }

  // EmotionCategory를 한국어 문자열로 변환하는 헬퍼 함수 (선택적)
  String _getCategoryDisplayName(EmotionCategory category) {
    switch (category) {
      case EmotionCategory.anger:
        return "화가 날 때";
      case EmotionCategory.hurt:
        return "상처 받았을 때";
      case EmotionCategory.fear:
        return "두려울 때";
      case EmotionCategory.general:
      // ignore: unreachable_switch_default
      default:
        return "일반적인 위로";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white, // 배경색 투명 또는 테마 색상
        elevation: 0, // 그림자 제거
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 16),
            /*
            DrawerHeader(
              decoration: BoxDecoration(color: AppBasicColors.colors[0]),
              child: const Text(
                '감정 선택하기',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            */
            ...EmotionCategory.values.map((e) {
              return ListTile(
                leading: Icon(
                  Icons.label_outline,
                  color: AppBasicColors.colors[e.index % 10],
                ),
                title: Text(_getCategoryDisplayName(e)),
                onTap: () => _onCategorySelected(e),
                selected: _selectedCategory == e,
              );
            }),
          ],
        ),
      ),
      // Scaffold의 배경을 AnimatedColorBox로 하거나, HomeScreen 내부의 AnimatedColorBox를 그대로 사용
      // 여기서는 HomeScreen이 AnimatedColorBox를 포함하고 있으므로, MainPage의 body는 HomeScreen이 됩니다.
      // 만약 AnimatedColorBox를 Scaffold 전체 배경으로 쓰고 싶다면 구조 변경 필요.
      // 현재 구조에서는 HomeScreen이 AnimatedColorBox를 body로 가짐.
      // 하지만 HomeScreen의 build에서 Scaffold를 반환하지 않도록 수정했으므로,
      // MainPage의 body에 HomeScreen을 넣고, HomeScreen 내부의 AnimatedColorBox가 배경이 됨.
      // AppBar가 AnimatedColorBox 위에 뜨도록 하려면 Stack을 사용하거나,
      // AppBar의 backgroundColor를 AnimatedColorBox와 동기화해야 함.
      // 가장 간단한 방법은 AppBar 배경을 투명하게 하고, HomeScreen의 AnimatedColorBox가 전체 배경이 되도록 하는 것.
      // 이를 위해 Scaffold의 extendBodyBehindAppBar = true; 옵션 사용 가능
      extendBodyBehindAppBar: true, // AppBar 뒤로 Body가 확장되도록
      body: PhraseBody(
        selectedCategory: _selectedCategory, // 선택된 카테고리 전달
      ),
    );
  }
}
