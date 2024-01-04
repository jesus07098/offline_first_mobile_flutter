import 'package:offline_first/core/data/services/key_value_storage_service_impl.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../../core/data/repositories/local/entity_local_repository_impl.dart';
import '../../../../core/data/repositories/local/vehicle_local_repository_impl.dart';
import '../../../../core/data/repositories/remote/entity_remote_repository_impl.dart';
import '../../../../core/data/repositories/remote/vehicle_remote_repository_impl.dart';
import '../../../../core/presentation/blocs/blocs.dart';
import '../../../../core/presentation/widgets/draggable_type_incidents.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/utils/utils.dart';
import '../../data/repositories/local/incident_local_repository_impl.dart';
import '../../data/repositories/remote/incident_remote_repository_impl.dart';
import '../../domain/entities/incident.dart';
import '../blocs/incident_form/incident_form_bloc.dart';
import '../blocs/type_incidents/type_incidents_bloc.dart';
import '../widgets/type_file_selector.dart';

class IncidentFormScreen extends StatelessWidget {
  final Incident? incident;

  const IncidentFormScreen({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => IncidentFormBloc(
                incident: incident,
                incidentLocalRepository: IncidentLocalRepositoryImpl(),
                keyValueStorageService: KeyValueStorageServiceImpl())),
        BlocProvider(
            create: (_) => EntitiesBloc(
                entityLocalRepository: EntityLocalRepositoryImpl(),
                entityRemoteRepository: EntityRemoteRepositoryImpl())),
        BlocProvider(
            create: (_) => VehiclesBloc(
                vehicleLocalRepository: VehicleLocalRepositoryImpl(),
                vehicleRemoteRepository: VehicleRemoteRepositoryImpl())),
        BlocProvider(
            create: (_) => TypesIncidentsBloc(
                incidentLocalRepository: IncidentLocalRepositoryImpl(),
                incidentRemoteRepository: IncidentRemoteRepositoryImpl())),
      ],
      child: _Scaffold(
        incident: incident,
      ),
    );
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold({required this.incident});
  final Incident? incident;

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  late final TextEditingController circuitController;
  late final TextEditingController tagsController;
  late final TextEditingController observationController;
  late final TextEditingController titleController;
  late final TextEditingController directionController;
  late final TextEditingController sectorController;
  late final TextEditingController zoneController;
  @override
  void initState() {
    context.read<VehiclesBloc>().add(OnGetVehicles());
    if (widget.incident?.typeIncident.value != null) {
      context.read<TypesIncidentsBloc>().add(OnSetTypeIncidentUpdating(
          type: widget.incident!.typeIncident.value!));
    }
    if (widget.incident?.vehicle.value != null) {
      context.read<VehiclesBloc>().add(OnSetCurrentVehicleUpdating(
          vehicle: widget.incident!.vehicle.value!));
    }

     if (widget.incident?.assignedEmployees != null) {
      context.read<EntitiesBloc>().add(OnSetAssignedEmployeesUpdating(
          employees: widget.incident!.assignedEmployees.toList()));
    }

     if (widget.incident?.employee != null) {
      context.read<EntitiesBloc>().add(OnSetCurrentEmployeeUpdating(
          employee: widget.incident!.employee.value!));
    }
    circuitController =
        TextEditingController(text: widget.incident?.circuitNumber);
    titleController = TextEditingController(text: widget.incident?.title);
    tagsController = TextEditingController(
        text: widget.incident?.labels?.map((e) => e).join(', '));
    observationController = TextEditingController(text: widget.incident?.body);
    directionController = TextEditingController(text: widget.incident?.address);
    sectorController = TextEditingController(text: widget.incident?.sector);
    zoneController = TextEditingController(text: widget.incident?.zone);
    context.read<EntitiesBloc>().add(OnGetEmployees());
    context.read<TypesIncidentsBloc>().add(OnGetTypesIncidents());
    FToast().init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final RegExp wordRegExp = RegExp(r'\s+');
    final incidentFormBloc = context.watch<IncidentFormBloc>();

    return Scaffold(
        appBar: AppBarCustom(
          titleText: widget.incident != null
              ? 'Editar incidencia'
              : 'Crear incidencia',
          actions: [
            BlocListener<IncidentFormBloc, IncidentFormState>(
              listenWhen: (previous, current) =>
                  previous.formStatus != current.formStatus,
              listener: (_, state) {
                if (state.message == '') {
                  return;
                }
                if (state.formStatus == FormzSubmissionStatus.success) {
                  AlertsManager.showSnackBarCustom(
                      context, SnackBarCustom.snackBarSuccess(state.message));
                } else if (state.formStatus == FormzSubmissionStatus.canceled ||
                    state.formStatus == FormzSubmissionStatus.failure) {
                  AlertsManager.showSnackBarCustom(
                      context, SnackBarCustom.snackBarError(state.message));
                }
              },
              child: TextButton(
                  onPressed: () {
                    if (widget.incident == null) {
                      incidentFormBloc
                        ..add(OnSubmitted())
                        ..add(const OnSave());
                      AlertsManager.showToastCustom(
                          const ToastCustom(text: 'Espere un momento...'));
                    }else{
                       incidentFormBloc
                        ..add(OnSubmitted())
                        ..add(const OnUpdate());
                      AlertsManager.showToastCustom(
                          const ToastCustom(text: 'Espere un momento...'));
                    }

                  },
                  child: const Text('Guardar')),
            ),
          ],
        ),
        body: BlocConsumer<IncidentFormBloc, IncidentFormState>(
          listener: (context, state) {
            if (state.formStatus == FormzSubmissionStatus.success) {
              context.read<TypesIncidentsBloc>().add(OnClearTypeIncident());
              context.read<VehiclesBloc>().add(OnClearCurrentVehicle());
              context.read<EntitiesBloc>()
                ..add(OnClearCurrentEmployee())
                ..add(OnClearAssignedEmployees());
              circuitController.text = '';
              tagsController.text = '';
              observationController.text = '';
              titleController.text = '';
              directionController.text = '';
              sectorController.text = '';
              zoneController.text = '';
            }
          },
          builder: (context, state) {
            final incidentState = state;
            final incidentContext = context;
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p18),
                color: AppColors.grey200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionContainer(
                      child: Column(
                        children: [
                          const LabelField(
                              label: 'Seleccione un tipo de incidencia',
                              isRequired: true),
                          BlocBuilder<TypesIncidentsBloc, TypeIncidentsState>(
                            builder: (context, state) {
                              return TextFormFieldCustom(
                                onTapOutside: (event) =>
                                    FocusScope.of(context).unfocus(),
                                readOnly: true,
                                hinttext: 'Seleccione un tipo de incidencia',
                                controller: TextEditingController(
                                    text: state.currentType?.name),
                                errorText: incidentState.isFormPosted
                                    ? incidentState.typeIncident.errorMessage
                                    : null,
                                suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                onTap: () => showModalBottomSheet(
                                    isScrollControlled: false,
                                    context: context,
                                    builder: (_) => DraggableTypeIncidents(
                                          onChanged: (typeId) => context
                                              .read<IncidentFormBloc>()
                                              .add(
                                                  OnTypeIncidentChange(typeId)),
                                          typeIncidents: state.incidentsTypes,
                                          onTap: (index) {
                                            context
                                                .read<TypesIncidentsBloc>()
                                                .add(OnSetTypeIncident(
                                                    index: index));
                                          },
                                        )),
                              );
                            },
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                              label: 'Seleccione un vehículo',
                              isRequired: true),
                          BlocBuilder<VehiclesBloc, VehiclesState>(
                            builder: (_, state) {
                              return TextFormFieldCustom(
                                  controller: TextEditingController(
                                      text: state.currentVehicle?.name),
                                  readOnly: true,
                                  suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  hinttext: 'Seleccione un vehículo',
                                  errorText: incidentState.isFormPosted
                                      ? incidentState.vehicle.errorMessage
                                      : null,
                                  onTap: () => showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (_) => DraggableVehicles(
                                            onChanged: (vehicleId) {
                                              context
                                                  .read<IncidentFormBloc>()
                                                  .add(OnVehicleChange(
                                                      vehicleId));
                                            },
                                            vehicles: state.vehicles,
                                            onTap: (index) {
                                              context.read<VehiclesBloc>().add(
                                                  OnSetCurrentVehicle(
                                                      index: index));
                                            },
                                          )));
                            },
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(label: 'Circuito', isRequired: true),
                          TextFormFieldCustom(
                            controller: circuitController,
                            errorText: state.isFormPosted
                                ? state.circuit.errorMessage
                                : null,
                            hinttext: 'Ingrese el circuito',
                            onChanged: (value) => context
                                .read<IncidentFormBloc>()
                                .add(OnCircuitChange(value)),
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                            label: 'Reportada por',
                            isRequired: true,
                          ),
                          BlocBuilder<EntitiesBloc, EntitiesState>(
                            builder: (context, state) {
                              return TextFormFieldCustom(
                                suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                errorText: incidentState.isFormPosted
                                    ? incidentState.reportedBy.errorMessage
                                    : null,
                                hinttext: 'Seleccione creador de la incidencia',
                                controller: TextEditingController(
                                    text: state
                                        .currentEmployee?.entity.completeName),
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (_) => DraggableEmployees(
                                            employees: state.employees,
                                            onTap: (index) {
                                              context.read<EntitiesBloc>().add(
                                                  OnSetCurrentEmployee(
                                                      index: index));
                                            },
                                            onChanged: (entityId) => context
                                                .read<IncidentFormBloc>()
                                                .add(OnReportedByChange(
                                                    entityId)),
                                          ));
                                },
                                readOnly: true,
                              );
                            },
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                              label: 'Título de la incidencia',
                              isRequired: true),
                          TextFormFieldCustom(
                              controller: titleController,
                              errorText: state.isFormPosted
                                  ? state.title.errorMessage
                                  : null,
                              onChanged: (value) => context
                                  .read<IncidentFormBloc>()
                                  .add(OnTitleChange(value)),
                              hinttext: 'Ingrese el título de la incidencia'),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(label: 'Observación'),
                          TextFormFieldMultiLine(
                            controller: observationController,
                            onChanged: (value) => context
                                .read<IncidentFormBloc>()
                                .add(OnObservationChange(value)),
                            hinttext:
                                'Contexto, instrucciones, especificaciones, etc.',
                          ),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                              label: 'Fecha de inicio', isRequired: true),
                          TextFormFieldDate(
                              onChanged: (value) => context
                                  .read<IncidentFormBloc>()
                                  .add(OnStartDateChange(value.toString())),
                              errorText: state.isFormPosted
                                  ? state.startDate.errorMessage
                                  : null,
                              controller: TextEditingController(
                                  text: DateManager.formatDate(
                                      DateTime.parse(state.startDate.value ??
                                          DateTime.now().toString()),
                                      visualFormat: true)),
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2140),
                              suffixIcon:
                                  const Icon(FluentIcons.calendar_20_regular)),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                              label: 'Hora inicio', isRequired: true),
                          TextFormFieldHour(
                              onChanged: (value) => context
                                  .read<IncidentFormBloc>()
                                  .add(OnStartHourChange(value.toString())),
                              controller: TextEditingController(
                                text: state.startHour.value ??
                                    TimeOfDay(
                                            hour: DateTime.now().hour,
                                            minute: DateTime.now().minute)
                                        .format(context),
                              ),
                              initialTime: TimeOfDay.now()),
                          const SizedBox(height: AppPadding.p12),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppPadding.p20),
                    const LabelSection(label: 'Datos de dirección'),
                    SectionContainer(
                        child: Column(
                      children: [
                        const LabelField(label: 'Dirección', isRequired: true),
                        TextFormFieldCustom(
                            controller: directionController,
                            onChanged: (value) => context
                                .read<IncidentFormBloc>()
                                .add(OnDirectionChange(value)),
                            errorText: state.isFormPosted
                                ? state.direction.errorMessage
                                : null,
                            hinttext: 'Describa la dirección'),
                        const SizedBox(height: AppPadding.p12),
                        const LabelField(label: 'Sector', isRequired: true),
                        TextFormFieldCustom(
                          controller: sectorController,
                          onChanged: (value) => context
                              .read<IncidentFormBloc>()
                              .add(OnSectorChange(value)),
                          errorText: state.isFormPosted
                              ? state.sector.errorMessage
                              : null,
                          hinttext: 'Ingrese el sector',
                        ),
                        const SizedBox(height: AppPadding.p12),
                        const LabelField(label: 'Zona'),
                        TextFormFieldCustom(
                          controller: zoneController,
                          onChanged: (value) => context
                              .read<IncidentFormBloc>()
                              .add(OnZoneChange(value)),
                          hinttext: 'Ingrese la zona',
                        )
                      ],
                    )),
                    const SizedBox(height: AppPadding.p20),
                    const LabelSection(label: 'Delegación'),
                    SectionContainer(
                        child: Column(
                      children: [
                        const LabelField(label: 'Asignado a', isRequired: true),
                        BlocBuilder<EntitiesBloc, EntitiesState>(
                          builder: (context, state) {
                            return TextFormFieldCustom(
                              errorText: incidentState.isFormPosted
                                  ? incidentState.assignedTo.errorMessage
                                  : null,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: state.assignedEmployees
                                          ?.map((employee) =>
                                              employee.entity.completeName)
                                          .join(', ') ??
                                      ''),
                              hinttext: 'Seleccione el personal asignado',
                              onTap: () => AlertsManager.showBottomSheetCustom(
                                  context,
                                  DraggableAssignedEmployees(
                                    onChanged: (employeesIds) {
                                      incidentContext
                                          .read<IncidentFormBloc>()
                                          .add(
                                              OnAssignedToChange(employeesIds));
                                    },
                                    employees: state.employees,
                                    onSelectedEmployees: (indexes) {
                                      context.read<EntitiesBloc>().add(
                                          OnSetAssignedEmployees(
                                              indexes: indexes));
                                    },
                                  )),
                            );
                          },
                        ),
                        const SizedBox(height: AppPadding.p12),
                        const LabelField(label: 'Prioridad', isRequired: true),
                        TextFormFieldCustom(
                          errorText: state.isFormPosted
                              ? state.priority.errorMessage
                              : null,
                          hinttext: 'Seleccione la prioridad',
                          readOnly: true,
                          onTap: () => showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => DraggablePriority(
                                    onTap: (priority) => context
                                        .read<IncidentFormBloc>()
                                        .add(OnPriorityChange(priority)),
                                  )),
                          controller:
                              TextEditingController(text: state.priority.value),
                        ),
                        const SizedBox(height: AppPadding.p12),
                      ],
                    )),
                    const SizedBox(height: AppPadding.p20),
                    const LabelSection(label: 'Etiquetas'),
                    SectionContainer(
                      child: Column(
                        children: [
                          const LabelField(
                              label: 'Etiquetas (separadas por espacio)'),
                          TextFormFieldCustom(
                            controller: tagsController,
                            hinttext: 'Agrega etiquetas separadas por espacio',
                            onChanged: (value) => context
                                .read<IncidentFormBloc>()
                                .add(OnTagsChange(
                                    value.trim().split(wordRegExp))),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: AppPadding.p20),
                    const LabelSection(label: 'Configuraciones de vencimiento'),
                    SectionContainer(
                      child: Column(
                        children: [
                          const LabelField(
                            label: 'Fecha de vencimiento',
                            isRequired: true,
                          ),
                          TextFormFieldDate(
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2140),
                              controller: TextEditingController(
                                text: DateManager.formatDate(
                                    DateTime.parse(state.dueDate.value ??
                                        DateTime.now().toString()),
                                    visualFormat: true),
                              ),
                              suffixIcon:
                                  const Icon(FluentIcons.calendar_20_regular)),
                          const SizedBox(height: AppPadding.p12),
                          const LabelField(
                            label: 'Hora de vencimiento',
                            isRequired: true,
                          ),
                          TextFormFieldHour(
                            onChanged: (value) => context
                                .read<IncidentFormBloc>()
                                .add(OnFinishHourChange(value.toString())),
                            controller: TextEditingController(
                              text: state.finishHour.value ??
                                  TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute)
                                      .format(context),
                            ),
                            initialTime: TimeOfDay(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute),
                          ),
                          const SizedBox(height: AppPadding.p12),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.incident == null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelSection(label: 'Archivos adjuntos'),
                          TypeFileSelector(
                            documentsQuantity: state.documents?.length,
                            audiosQuantity: state.audios?.length,
                            photosQuantity: state.photos?.length,
                            onTapDocuments: () => context.pushNamed('documents',
                                extra: {'context': incidentContext}),
                            onTapAudios: () => context.pushNamed('audios',
                                extra: {'context': incidentContext}),
                            onTapPhotos: () => context.pushNamed('photos',
                                extra: {'context': incidentContext}),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
