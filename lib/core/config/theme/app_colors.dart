import 'package:flutter/material.dart';

class AppColors {
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffffffff);
  static const Color white50 = Color(0xfffafafa);

  //blue - primary colors
  static const Color primaryColor = Color(0xFF1A56C0);
  static const Color primaryColor50 = Color(0xffe9e8ff);
  static const Color primaryColor200 = Color(0xff9ea1fc);
  static const Color primaryColor300 = Color(0xff717bfc);

  //red colors
  static const Color red100 = Color(0xffffcad0);
  static const Color red500 = Color(0xffff2339);
  static const Color red900 = Color(0xffc9001d);

  //orange colors
  static const Color orange400 = Color(0xffFFA726);

  //green colors
  static const Color green100 = Color(0xffc7e7c7);
  static const Color green400 = Color(0xff62bd64);
  static const Color greenA700 = Color(0xff00c853);

  // grey colors
  static const Color grey50 = Color(0xfffafafa);
  static const Color grey100 = Color(0xfff5f7f9);
  static const Color grey200 = Color(0xffeff1f3);
  static const Color grey300 = Color(0xffe2e4e6);
  static const Color grey400 = Color(0xffc0c2c4);
  static const Color grey500 = Color(0xffa1a3a5); // inactive colors
  static const Color grey600 = Color(0xff787a7c);
  static const Color grey700 = Color(0xff646667);
  static const Color grey800 = Color(0xff454648);
  static const Color black = Color(0xff131313);

  static Map<String, Color> priorityColors = {
    'Critica': AppColors.red900,
    'Alta': AppColors.red900,
    'Media': AppColors.orange400,
    'Baja': AppColors.grey600,
    'No prioritaria': AppColors.grey600,
  };

  static Color getColorByTypePriority(String iconType) {
    return priorityColors[iconType] ?? AppColors.black;
  }
}
