import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

class TextFormFieldMultiLine extends StatelessWidget {
  const TextFormFieldMultiLine(
      {Key? key, this.hinttext, this.controller, this.validator, this.onChanged, this.errorText})
      : super(key: key);

  final String? hinttext;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      
      textAlign: TextAlign.start,
      style: const TextStyle(color: AppColors.black, fontSize: 14),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.red900,
          ),
        ),
        hintText: hinttext,
        hintStyle:
            getRegularStyle(fontSize: FontSize.s14, color: AppColors.grey500),
        contentPadding:
            const EdgeInsets.only(bottom: 60, left: 16, right: 16, top: 10),
        filled: false,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.grey300)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.grey300)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      minLines: 1,
      maxLines: 5,
    );
  }
}
