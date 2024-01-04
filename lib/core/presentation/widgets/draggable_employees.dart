import 'package:offline_first/core/domain/entities/entities.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/theme.dart';

import 'draggable_header.dart';
import 'textformfield_custom.dart';

class DraggableEmployees extends StatefulWidget {
  const DraggableEmployees(
      {super.key,
      required this.employees,
      required this.onTap,
      required this.onChanged});
  final void Function(int value) onTap;
  final List<EmployeeData> employees;
  final void Function(String) onChanged;

  @override
  State<DraggableEmployees> createState() => _DraggableEmployeesState();
}

class _DraggableEmployeesState extends State<DraggableEmployees> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    List<EmployeeData> filteredEmployees = widget.employees
        .where((employee) =>
            employee.entity.completeName?.toLowerCase().contains(filter) ??
            false)
        .toList();
    return DraggableScrollableSheet(
        minChildSize: 0.8,
        expand: false,
        initialChildSize: 0.8,
        builder: (context, _) => Column(
              children: [
                DraggableHeader(title: 'Reportado por', context: context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                  child: TextFormFieldCustom(
                    prefixIcon: const Icon(FluentIcons.search_20_filled),
                    hinttext: 'Filtrar por nombre',
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
                        itemCount: filteredEmployees.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              widget.onTap(index);
                              widget.onChanged.call(
                                  filteredEmployees[index].entity.id ??
                                      "No id");
                              context.pop();
                            },
                            title: Text(
                              filteredEmployees[index].entity.completeName ??
                                  'No name',
                              style: getRegularStyle(fontSize: FontSize.s14),
                            ),
                            subtitle: Text(
                                filteredEmployees[index].position.name ??
                                    'No position',
                                style:
                                    getRegularStyle(color: AppColors.grey600)),
                          );
                        }))
              ],
            ));
  }
}
