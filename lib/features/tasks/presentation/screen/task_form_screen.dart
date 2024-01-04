import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:offline_first/core/config/theme/app_fonts.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_values.dart';
import '../../../../core/domain/entities/priority.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../controllers/task/task_bloc.dart';

final List<Priority> priorities = [
  Priority(id: 'a1', description: 'Juan Perez'),
  Priority(id: 'a2', description: 'Jonatán Cueto'),
  Priority(id: 'a3', description: 'Jesus Cirineo')
];

class TaskFormScreen extends StatelessWidget {
  const TaskFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final taskFormBloc = context.watch<TaskFormBloc>();
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: AppBarCustom(titleText: 'Crear tarea', actions: [
        TextButton(
            onPressed: () {},
            // onPressed: () => taskFormBloc.onSubmit(),
            child: const Text('Guardar'))
      ]),
      body: _RegisterBody(),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  _RegisterBody();
  final dueDateController = TextEditingController();
  final initDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionContainer(
                child: Column(
                  children: [
                    const LabelField(
                        label: 'Título de la tarea', isRequired: true),
                    TextFormFieldCustom(
                        // errorText: title.errorMessage,
                        onChanged: (value) {
                          context
                              .read<TaskFormBloc>()
                              .add(OnTitleChanged(value));
                        },
                        hinttext: 'Ingrese el título de la tarea'),
                    const SizedBox(height: AppPadding.p12),
                    const LabelField(label: 'Descripción', isRequired: true),
                    TextFormFieldCustom(
                      onChanged: (value) {
                        context
                            .read<TaskFormBloc>()
                            .add(OnDescriptionChanged(value));
                      },
                      hinttext:
                          'Contexto, instrucciones, especificaciones, etc.',
                    ),
                    const SizedBox(height: AppPadding.p12),
                    const LabelField(label: 'Creada por'),
                    DropDownFieldCustom(
                        // hinttext: state.createdBy.value,
                        onTap: () {
                      // showModalBottomSheet(
                      //     isScrollControlled: true,
                      //     context: context,
                      //     builder: (context) => DraggableEmployees(
                      //           employees: employees,
                      //           onOptionSelected: (value) {
                      //             context.read<TaskFormBloc>().add(
                      //                 OnCreatedByChanged(
                      //                     employees[value].id));
                      //           },
                      //         ));
                    }),
                    const SizedBox(height: AppPadding.p12),
                    const LabelField(
                        label: 'Fecha de inicio', isRequired: true),
                    TextFormFieldDate(
                      initialDate: DateTime(1900),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2140),
                      // controller: state.initDate.value != null
                      //     ? TextEditingController(
                      //         text: DateUtil.formatDate(
                      //             state.initDate.value,
                      //             visualFormat: true))
                      //     : null,
                      onChanged: (value) {
                        // context
                        //     .read<TaskFormBloc>()
                        //     .add(OnInitDateChanged(value));
                      },
                    ),
                    const SizedBox(height: AppPadding.p12),
                    const LabelField(
                        label: 'Fecha de vencimiento', isRequired: true),
                    TextFormFieldDate(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now(),
                      controller: dueDateController,
                      suffixIcon: dueDateController.text == ""
                          ? const Icon(Icons.calendar_month)
                          : IconButton(
                              icon: const Icon(Icons.cancel),
                              color: AppColors.primaryColor,
                              onPressed: dueDateController.clear),
                      onChanged: (value) {
                        // context
                        //     .read<TaskFormBloc>()
                        //     .add(OnDueDateChanged(value));
                      },
                    ),
                    const SizedBox(height: AppPadding.p12),
                  ],
                ),
              ),

              //Delegation info
              const SizedBox(height: AppPadding.p20),
              const LabelSection(label: 'Delegación'),
              const SectionContainer(
                  child: Column(
                children: [
                  LabelField(label: 'Asignado a', isRequired: true),
                  // DropDownFieldCustom(
                  //   hinttext: 'Seleccione el personal asignado',
                  //   onTap: () => showModalBottomSheet(
                  //       context: context,
                  //       builder: (context) => DraggableAssignedEmployee(
                  //             employees: employees,
                  //             selectedEmployeeIds: assignatedTo,
                  //             onEmployeeSelection:
                  //                 (updatedSelectedEmployeeIds) {
                  //               assignatedTo = updatedSelectedEmployeeIds;
                  //               log(assignatedTo.toString());
                  //             },
                  //           )),
                  // ),
                  SizedBox(height: AppPadding.p12),
                  LabelField(label: 'Prioridad', isRequired: true),
                  // DropDownFieldCustom(
                  //   hinttext: 'Seleccione la prioridad',
                  //   onTap: () => showModalBottomSheet(
                  //       context: context,
                  //       builder: (context) => const DraggablePriority()),
                  // ),
                  SizedBox(height: AppPadding.p12),
                  LabelField(label: 'Vehículo'),
                  // DropDownFieldCustom(
                  //     hinttext: 'Seleccione un vehículo',
                  //     onTap: () => showModalBottomSheet(
                  //         isScrollControlled: true,
                  //         context: context,
                  //         builder: (context) => const DraggableVehicles())),
                  SizedBox(height: AppPadding.p12),
                ],
              )),
              const LabelSection(label: 'Archivos adjuntos'),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppBorderRadius.br8)),
                tileColor: AppColors.white,
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                title: Text('Audios, fotos, comentarios, documentos',
                    style: getRegularStyle(
                        fontSize: FontSize.s14,
                        overflow: TextOverflow.ellipsis)),
                onTap: () => context.pushNamed('files'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
