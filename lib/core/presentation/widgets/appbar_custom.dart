import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom(
      {super.key,
      this.titleText,
      this.title,
      this.actions,
      this.bgColor,
      this.bottom,
      this.textColor = AppColors.black,
      this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
      this.isVisibleBackButton = true})
      : assert(!(title != null && titleText != null),
            'Title and title text cannot be defined at the same time');

  final String? titleText;
  final Widget? title;
  final List<Widget>? actions;
  final Color? bgColor;
  final PreferredSizeWidget? bottom;
  final bool isVisibleBackButton;
  final Color textColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      backgroundColor: bgColor,
      systemOverlayStyle: systemUiOverlayStyle,
      title: titleText != null
          ? Text(titleText ?? '',
              style: getMediumStyle(fontSize: FontSize.s16, color: textColor))
          : title,
      leading: Visibility(
        visible: isVisibleBackButton,
        child: _BackButtonAppBarWidget(iconColor: textColor),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(Size.infinite.width, kToolbarHeight);
}

class _BackButtonAppBarWidget extends StatelessWidget {
  const _BackButtonAppBarWidget({Key? key, this.iconColor = AppColors.black})
      : super(key: key);

  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Ir atrás',
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.pop();
      },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: iconColor,
        size: 16,
      ),
    );
  }
}
