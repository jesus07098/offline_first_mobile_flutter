import 'package:offline_first/core/config/theme/app_values.dart';
import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../home/presentation/widgets/card_notification.dart';

class IncidentsListScreen extends StatelessWidget {
  const IncidentsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const AppBarCustom(titleText: 'Listado de incidencias'),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        itemCount: 40,
        itemBuilder: (context, index) => CardNotifitication(
          onTap: () => context.go('/main/0/task-list/incident-details'),
       
          incidentNumber: 'COR SUR [N/A]',
          date: 'Hace 1 días',
          description: 'Cortamos árbol',
          vehicleRecord: 'F-030 | Calle Los Alcarrizos',

          statusColor: AppColors.green400,
          priorityLabel: 'Alta',
          statusLabel: 'Abierta',
        ),
      ),
    );
  }
}
