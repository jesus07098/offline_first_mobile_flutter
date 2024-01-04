import 'package:flutter/material.dart';

import 'package:offline_first/core/config/theme/app_fonts.dart';

import '../../config/theme/app_colors.dart';

class DropDownFieldCustom<T> extends StatelessWidget {
  const DropDownFieldCustom(
      {Key? key,
      this.fillColor = AppColors.white,
      this.hinttext = '',
      this.validator,
      this.value,
      this.onChanged,
      this.items,
      this.onTap})
      : super(key: key);

  final List<DropdownMenuItem<T>>? items;
  final String? Function(T?)? validator;
    final void Function(T?)? onChanged;
  final T? value;
  final String hinttext;
  final Color? fillColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DropdownButtonFormField<T>(
        dropdownColor: AppColors.black,
        elevation: 0,
        borderRadius: BorderRadius.circular(16),
        style: getRegularStyle(),
        iconEnabledColor: AppColors.primaryColor,
        hint: Text(
          hinttext,
          style: const TextStyle(fontSize: 14, color: AppColors.grey500),
        ),
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.black,
          size: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.grey300),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.grey300),
          ),
          fillColor: fillColor,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        items: items,
        value: value,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
