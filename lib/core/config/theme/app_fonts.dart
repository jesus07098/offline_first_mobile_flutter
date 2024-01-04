import 'package:flutter/material.dart';
import 'app_colors.dart';

class FontConstants {
  static String? fontFamily = 'SF-Pro-Display';
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
}

TextStyle _getTextStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight,
    Color color,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow) {
  return TextStyle(
      overflow: overflow,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      height: height);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12,
    Color color = AppColors.black,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily!,
      FontWeightManager.regular, color, letterSpacing, height, overflow);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s12,
    Color color = AppColors.black,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily!,
      FontWeightManager.light, color, letterSpacing, height, overflow);
}

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12,
    Color color = AppColors.black,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily!,
      FontWeightManager.bold, color, letterSpacing, height, overflow);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12,
    Color color = AppColors.black,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily!,
      FontWeightManager.semiBold, color, letterSpacing, height, overflow);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    Color color = AppColors.black,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily!,
      FontWeightManager.medium, color, letterSpacing, height, overflow);
}
