import 'package:offline_first/core/config/theme/theme.dart';
import 'package:offline_first/core/presentation/widgets/textformfield_custom.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../domain/entities/employee.dart';

import 'draggable_header.dart';

class DraggableAssignedEmployees extends StatefulWidget {
  final List<EmployeeData> employees;

  final void Function(List<String>) onChanged;
  final void Function(List<int>) onSelectedEmployees;

  const DraggableAssignedEmployees(
      {super.key,
      required this.employees,
      required this.onSelectedEmployees,
      required this.onChanged});

  @override
  State<DraggableAssignedEmployees> createState() =>
      _DraggableAssignedEmployeesState();
}

class _DraggableAssignedEmployeesState
    extends State<DraggableAssignedEmployees> {
  Map<String, bool> selectedEmployeesMap = {}; // Utilizamos un Map para rastrear selecciones
  String filter = '';

  @override
  Widget build(BuildContext context) {
    List<EmployeeData> filteredEmployees = widget.employees
        .where((employee) =>
            employee.entity.completeName
                ?.toLowerCase()
                .contains(filter.toLowerCase()) ??
            false)
        .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.86,
      minChildSize: 0.86,
      builder: (context, scrollController) => Column(
        children: <Widget>[
          DraggableHeader(title: 'Reportado por', context: context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormFieldCustom(
              prefixIcon: const Icon(FluentIcons.search_20_filled),
              hinttext: 'Filtrar por nombre',
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employeeId = filteredEmployees[index].entity.id ?? 'no Id';
                final isSelected = selectedEmployeesMap[employeeId] ?? false;

                return CheckboxListTile(
                  title: Text(
                    filteredEmployees[index].entity.completeName ?? 'No name',
                    style: getRegularStyle(fontSize: FontSize.s14),
                  ),
                  value: isSelected,
                  onChanged: (bool? newValue) {
                    setState(() {
                      selectedEmployeesMap[employeeId] = newValue ?? false;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  final selectedIndexes = selectedEmployeesMap.entries
                      .where((entry) => entry.value)
                      .map((entry) =>
                          filteredEmployees.indexWhere((employee) =>
                              employee.entity.id == entry.key))
                      .toList();

                  widget.onSelectedEmployees.call(selectedIndexes);
                  widget.onChanged.call(selectedEmployeesMap.keys.toList());
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}