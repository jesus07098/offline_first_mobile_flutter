import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';

class VehiclesListScreen extends StatelessWidget {
  const VehiclesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBar: AppBarCustom(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seleccione un vehículo',
                style: getBoldStyle(fontSize: FontSize.s16)),
            Text('Driver Vehicle Inspection Report (Simple)',
                style: getRegularStyle()),
          ],
        ),
      ),
      body: Column(
        children: [
          const TextFormFieldCustom(
            fillColor: AppColors.grey100,
            prefixIcon: Icon(FluentIcons.search_20_filled),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: const Text('1100 [2028 Toyota Prius]'),
                onTap: ()=> context.go('/main/0/inspections-type/vehicles-list/inspection-form'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
