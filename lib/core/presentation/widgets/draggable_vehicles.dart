import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:offline_first/core/domain/entities/vehicle.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_values.dart';
import 'draggable_header.dart';
import 'textformfield_custom.dart';

class DraggableVehicles extends StatefulWidget {
  const DraggableVehicles(
      {super.key,
      required this.vehicles,
      required this.onTap,
      required this.onChanged});
  final List<VehicleData> vehicles;
  final void Function(int) onTap;
  final void Function(String)? onChanged;

  @override
  State<DraggableVehicles> createState() => _DraggableVehiclesState();
}

class _DraggableVehiclesState extends State<DraggableVehicles> {
   String filter = '';
  @override
  Widget build(BuildContext context) {
      List<VehicleData> filteredVehicles = widget.vehicles
        .where((vehicle) =>
            vehicle.vehicleBrand.name?.toLowerCase().contains(filter) ??
            false)
        .toList();
    return DraggableScrollableSheet(
        minChildSize: 0.8,
        expand: false,
        initialChildSize: 0.8,
        builder: (context, _) => Column(
              children: [
                DraggableHeader(
                    title: 'Seleccione un vehículo', context: context),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                  child: TextFormFieldCustom(
                    prefixIcon: const Icon(FluentIcons.search_20_filled),
                    hinttext: 'Filtrar por marca',
                    onChanged: (value) {
                      setState(() {
                        filter = value.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p18),
                        itemCount: filteredVehicles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              widget.onTap(index);
                              widget.onChanged!.call(filteredVehicles[index].id);
                              context.pop();
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text(filteredVehicles[index].name),
                            subtitle: Text( '${filteredVehicles[index].vehicleBrand.name} ${filteredVehicles[index].vehicleModel.name} - ${filteredVehicles[index].fleetNumber} - ${filteredVehicles[index].licensePlate}',
                                style:
                                    getRegularStyle(color: AppColors.grey500)),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: 3,
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          );
                        }))
              ],
            ));
  }
}
