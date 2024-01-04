import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

class ProgressIndicatorCustom extends StatelessWidget {
  const ProgressIndicatorCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        width: Size.infinite.width,
        height: Size.infinite.height,
        color: AppColors.white,
        child: const SizedBox(
            width: 40, height: 40, child: CircularProgressIndicator()));
  }
}
