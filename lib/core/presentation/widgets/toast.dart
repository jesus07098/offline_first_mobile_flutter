import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

class ToastCustom extends StatelessWidget {
  const ToastCustom(
      {super.key,
      this.bgColor = AppColors.grey200,
      required this.text,
      this.showIcon = false,
      this.icon = Icons.add,
      this.iconColor = AppColors.primaryColor});
  final Color bgColor;
  final String text;
  final bool showIcon;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: bgColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(visible: showIcon, child: Icon(icon, color: iconColor)),
            Text(
              text,
              style: getMediumStyle(color: AppColors.black),
            ),
          ],
        ));
  }
}

class ToastError extends StatelessWidget {
  const ToastError({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ToastCustom(
      text: text,
      bgColor: AppColors.red100,
      showIcon: true,
      icon: FluentIcons.checkmark_12_regular,
      iconColor: AppColors.red900,
    );
  }
}

class ToastSuccess extends StatelessWidget {
  const ToastSuccess({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ToastCustom(
      text: text,
      bgColor: AppColors.green100,
      showIcon: true,
      icon: FluentIcons.checkmark_12_regular,
      iconColor: AppColors.greenA700,
    );
  }
}
