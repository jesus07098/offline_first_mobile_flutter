import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';


class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom(
      {Key? key,
      this.fillColor = Colors.white,
      this.hinttext,
      this.validator,
      this.controller,
      this.onChanged,
      this.initialValue,
      this.readOnly = false,
      this.maxLength,
      this.obscureText = false,
      this.horizontalPadding = 16,
      this.verticalPadding = 10,
      this.suffix,
      this.prefixIcon,
      this.suffixIcon,
      this.inputFormatters,
      this.fontSizeHintText = FontSize.s14,
      this.fontColorHintText = AppColors.grey500,
      this.fontSizeLabel = FontSize.s14,
      this.keyboardType,
      this.textAlign = TextAlign.start,
      this.autovalidateMode,
      this.focusNode,
      this.focusedBorderColor = AppColors.primaryColor,
      this.onTap,
      this.onTapOutside,
      this.enableInteractiveSelection,
      this.errorText,
      this.fontSize = FontSize.s14,
      this.borderRadius = 10,
      this.marginBottom = 0,
      this.marginTop = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.enabledBorderColor = AppColors.grey300})
      : assert(errorText == null || validator == null,
            "The errorText and validator not empty"),
        super(key: key);

  final String? hinttext;
  final TextInputType? keyboardType;
  final dynamic controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool readOnly;
  final int? maxLength;
  final bool obscureText;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final double? fontSizeHintText;
  final Color? fontColorHintText;
  final double? fontSizeLabel;
  final void Function()? onTap;
  final TextAlign textAlign;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final Color focusedBorderColor;
  final String? errorText;
  final bool? enableInteractiveSelection;
  final double fontSize;
  final double borderRadius;
  final Color enabledBorderColor;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: marginBottom,
          left: marginLeft,
          right: marginRight,
          top: marginTop),
      child: TextFormField(
        onTap: onTap,
        onTapOutside: onTapOutside,
        focusNode: focusNode,
        style: getRegularStyle(fontSize: fontSize),
        readOnly: readOnly,
        textAlign: textAlign,
        keyboardType: keyboardType,
        controller: (controller != null) ? controller : null,
        maxLength: maxLength,
        validator: validator,
        initialValue: initialValue,
        obscureText: obscureText,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 8.0),
            child: prefixIcon,
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffix: suffix,
          suffixIcon: suffixIcon,
          counterText: '',
          disabledBorder: InputBorder.none,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          fillColor: fillColor,
          hintText: hinttext,
          labelStyle: TextStyle(fontSize: fontSizeLabel),
          hintStyle:
              TextStyle(fontSize: fontSizeHintText, color: fontColorHintText),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.grey300)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: enabledBorderColor)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.red900,
            ),
          ),
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: focusedBorderColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey300),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
