import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class ActionChipCustom extends StatelessWidget {
  const ActionChipCustom(
      {super.key, required this.label,
      required this.leadingIcon,
      required this.onPressed});
  final String label;
  final IconData leadingIcon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.all(2),
      side: const BorderSide(color: AppColors.grey300),
      avatar: Icon(leadingIcon, color: AppColors.black),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.black)
        ],
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
