import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class ChipCustom extends StatelessWidget {
  const ChipCustom(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconColor});
  final String title;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      visualDensity: VisualDensity.compact,
      labelPadding:
          const EdgeInsets.only(left: 0.0, right: 4.0, top: 0.0, bottom: 0.0),
      side: const BorderSide(color: AppColors.transparent),
      backgroundColor: AppColors.grey100,
      shape: const StadiumBorder(side: BorderSide.none),
      label: Text(title),
      avatar: Icon(icon, color: iconColor),
    );
  }
}
