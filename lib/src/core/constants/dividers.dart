// lib/src/core/constants/divides.dart (새로운 파일 또는 기존 constants 파일에 추가)

import 'package:flutter/material.dart';

class Dividers {
  Dividers._(); // 인스턴스 생성 방지

  static const divider16 = Divider(indent: 16, endIndent: 16, thickness: 0);

  static const divider24 = Divider(indent: 24, endIndent: 24, thickness: 0);

  static const zeroDivider16 = Divider(
    indent: 16,
    endIndent: 16,
    thickness: 0,
    height: 0,
  );

  static const zeroDivider24 = Divider(
    indent: 24,
    endIndent: 24,
    thickness: 0,
    height: 0,
  );
}
