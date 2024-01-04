import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';


import '../../../features/incidents/domain/entities/type_incident.dart';
import '../../config/theme/app_values.dart';

import 'draggable_header.dart';

class DraggableTypeIncidents extends StatelessWidget {
  const DraggableTypeIncidents(
      {super.key,
      required this.typeIncidents,
      required this.onTap,
      required this.onChanged});
  final List<TypeIncidentData> typeIncidents;
  final void Function(int) onTap;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.8,
        expand: false,
        initialChildSize: 0.8,
        builder: (context, _) => Column(
              children: [
                DraggableHeader(
                    title: 'Seleccione un tipo de incidencia',
                    context: context),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p18),
                        itemCount: typeIncidents.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              onTap(index);
                              onChanged!.call(typeIncidents[index].id);
                              context.pop();
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text(typeIncidents[index].name),
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
