import 'package:offline_first/core/config/theme/app_fonts.dart';

import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../utils/date_format.dart';

class TextFormFieldDate extends StatelessWidget {
  const TextFormFieldDate(
      {Key? key,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      this.onChanged,
      this.controller,
      this.hinText = 'dd/MM/aaaa',
      this.fontValueSize = FontSize.s12,
      this.color = AppColors.white,
      this.validator,
      this.errorText,
      this.readOnly = false,
      this.suffixIcon})
      : assert(errorText == null || validator == null,
            "The errorText and validator not empty"),
        super(key: key);

  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color? color;
  final String? hinText;
  final String? errorText;
  final double fontValueSize;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: readOnly
            ? null
            : () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    builder: (BuildContext context, Widget? child) => child!);

                if (selectedDate == null) {
                  return;
                }
                if (controller != null) {
                  controller!.text =
                      DateManager.formatDate(selectedDate, visualFormat: true);
                }

                if (onChanged != null) {
                  onChanged!.call(selectedDate.toString());
                }
              },
        readOnly: true,
        style: getRegularStyle(fontSize: FontSize.s14),
        validator: validator,
        controller: (controller != null) ? controller : null,
        autofocus: false,
        decoration: InputDecoration(
            errorText: errorText,
            hintStyle: const TextStyle(fontSize: 14, color: AppColors.grey400),
            hintText: hinText,
            filled: false,
            fillColor: color,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColors.grey300)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.red900),
            ),
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.only(left: 10),
            labelStyle: const TextStyle(color: AppColors.black),
            suffixIcon: suffixIcon));
  }
}
