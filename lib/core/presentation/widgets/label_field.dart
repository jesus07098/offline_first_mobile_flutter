import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class LabelField extends StatelessWidget {
  const LabelField({super.key, this.isRequired = false, required this.label});
  final bool isRequired;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(label),
          Visibility(
            visible: isRequired,
            child: Text(
              '*',
              style: getBoldStyle(color: AppColors.red900),
            ),
          )
        ],
      ),
    );
  }
}
