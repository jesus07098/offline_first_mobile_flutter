import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom({
    Key? key,
    required this.label,
    required this.action,
    this.bgColor = AppColors.primaryColor,
    this.isLoading = false,
    this.labelColor = AppColors.white,
  }) : super(key: key);
  final String label;
  final VoidCallback? action;
  final Color bgColor;
  final Color? labelColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(Size.infinite.width, 48)),
          fixedSize: MaterialStateProperty.all(Size(Size.infinite.width, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
          elevation: MaterialStateProperty.all<double?>(0),
        ),
        onPressed: isLoading ? null : action,
        child: isLoading
            ? Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 3,
                ))
            : FittedBox(
                child: Text(label,
                    style: getBoldStyle(
                        letterSpacing: 0.3,
                        color: AppColors.white,
                        fontSize: FontSize.s14)),
              ),
      ),
    );
  }
}
