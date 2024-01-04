import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_values.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer(
      {super.key, this.child, this.horizontalPadding = AppPadding.p16});
  final Widget? child;
  final double? horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Size.infinite.width,
        margin: const EdgeInsets.only(bottom: AppMargin.m10),
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p12, horizontal: horizontalPadding!),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppBorderRadius.br8)),
        child: child);
  }
}
