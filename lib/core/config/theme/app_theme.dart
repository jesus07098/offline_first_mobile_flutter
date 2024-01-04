import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primaryColor,
        brightness: Brightness.light,
        fontFamily: FontConstants.fontFamily,
        appBarTheme: const AppBarTheme(
            color: AppColors.white, surfaceTintColor: AppColors.white),
        scaffoldBackgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        cardTheme: const CardTheme(
            surfaceTintColor: AppColors.white, color: AppColors.white),
      );
}
