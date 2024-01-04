import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

class SnackBarCustom {
  static SnackBar snackBarError(String message) {
    return SnackBar(
        showCloseIcon: true,
        closeIconColor: AppColors.black,
        backgroundColor: AppColors.red100,
        content: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(FluentIcons.error_circle_12_regular,
                color: AppColors.red900, size: 20),
            Text(message, style: getMediumStyle(color: AppColors.black)),
          ],
        ));
  }

  static SnackBar snackBarSuccess(String message) {
    return SnackBar(
        showCloseIcon: true,
        closeIconColor: AppColors.black,
        backgroundColor: AppColors.green100,
        content: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(FluentIcons.checkmark_12_regular,
                color: AppColors.greenA700, size: 20),
            Text(message, style: getMediumStyle(color: AppColors.black)),
          ],
        ));
  }
}
