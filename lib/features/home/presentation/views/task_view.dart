import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:offline_first/features/home/presentation/widgets/card_notification.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_values.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});
  static const name = '/task-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Buscar',
            prefixIcon:
                Icon(FluentIcons.search_20_filled, color: AppColors.grey500),
            filled: true,
            fillColor: AppColors.grey200,
            border: UnderlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppBorderRadius.br12)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: AppMargin.m8),
        // ActionChipCustom(
        //   label: 'Ordenar por',
        //   leadingIcon: FluentIcons.arrow_sort_20_filled,
        //   onPressed: () {},
        // ),
   
        CardNotifitication(
          onTap: () => context.go('/main/2/incident-details'),
      
          incidentNumber: 'COR SUR [N/A]',
          date: 'Hace 4 días',
          description: 'Hicimos una interconexión',
          vehicleRecord: 'F-018 | Calle Francisco Peña Gómez',
    
          statusColor: AppColors.green400,
          priorityLabel: 'Alta',
          statusLabel: 'Abierta',
        ),
      ],
    ));
  }
}
