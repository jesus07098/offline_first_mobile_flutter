import 'package:offline_first/core/config/theme/app_values.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_fonts.dart';

class LabelSection extends StatelessWidget {
  const LabelSection({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Text(label, style: getMediumStyle(fontSize: FontSize.s16)),
    );
  }
}
