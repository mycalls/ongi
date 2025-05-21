import 'package:flutter/material.dart';
import 'package:ongi/src/core/constants/app_constants.dart';

class AppThemeData {
  static ThemeData themeData({Brightness? brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: appMainColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        // elevation: 10,
        // toolbarHeight: 80,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //shape: CircleBorder(),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(24))),
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(24))),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(24))),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(24))),
      ),
      // Prevent color change on mouseover in inkwell widget
      // inkwell 위젯에서 마우스 오버시 색깔 변경 방지
      hoverColor: Colors.transparent,
    );
  }
}
