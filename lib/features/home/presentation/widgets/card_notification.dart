import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:offline_first/core/utils/icon_type_priority.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_fonts.dart';
import '../../../../core/presentation/widgets/widgets.dart' show ChipCustom;

class CardNotifitication extends StatelessWidget {
  const CardNotifitication(
      {super.key,
      required this.incidentNumber,
      required this.date,
      required this.description,
      required this.vehicleRecord,
      required this.statusColor,
      required this.priorityLabel,
      required this.statusLabel,
      this.onTap});
  final String incidentNumber;
  final String date;
  final String description;
  final String vehicleRecord;
  final void Function()? onTap;

  final Color statusColor;
  final String statusLabel;
  final String priorityLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: AppColors.white,
        shape: const Border(bottom: BorderSide(color: AppColors.grey300)),
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextDescriptionGray(
                  text: incidentNumber,
                ),
                TextDescriptionGray(
                  text: date,
                )
              ],
            ),
            const SizedBox(height: 2),
            Text(description, style: getMediumStyle(fontSize: FontSize.s14)),
            const SizedBox(height: 2),
            TextDescriptionGray(
              text: vehicleRecord,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
              child: Wrap(
                spacing: 8,
                children: [
                  ChipCustom(
                      icon: FluentIcons.circle_20_filled,
                      title: statusLabel,
                      iconColor: statusColor),
                  ChipCustom(
                      icon: IconManager.getIconByTypePriority(priorityLabel),
                      title: priorityLabel,
                      iconColor:
                          AppColors.getColorByTypePriority(priorityLabel))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextDescriptionGray extends StatelessWidget {
  const TextDescriptionGray(
      {super.key, this.fontSize = FontSize.s14, required this.text});
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle(color: AppColors.grey600, fontSize: fontSize),
    );
  }
}
