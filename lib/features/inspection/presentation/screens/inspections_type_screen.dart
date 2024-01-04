import 'package:flutter/material.dart';

import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class InspectionsTypeScreen extends StatelessWidget {
  const InspectionsTypeScreen({super.key});
  static const name = 'inspections-type';
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBar: const AppBarCustom(
            titleText: 'Selecciona un Formulario de Inspección'),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => _ListTileInspection(
                  onTap: () =>
                      context.go('/main/0/inspections-type/vehicles-list'),
                  title: 'Inspección general de vehiculo',
                  subtitle:
                      'Es requerido para la inspección de estados de las flotillas que salen y entran',
                )));
  }
}

class _ListTileInspection extends StatelessWidget {
  const _ListTileInspection(
      {required this.title, required this.subtitle, this.onTap});

  final String title;
  final String subtitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            onTap: onTap,
            title: Text(title),
            subtitle: Text(subtitle,
                style: getRegularStyle(color: AppColors.grey700))));
  }
}
