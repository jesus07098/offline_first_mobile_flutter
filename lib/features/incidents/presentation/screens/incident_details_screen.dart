import 'dart:developer';

import 'package:offline_first/core/data/services/key_value_storage_service_impl.dart';
import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:offline_first/features/incidents/data/repositories/local/incident_local_repository_impl.dart';
import 'package:offline_first/features/incidents/presentation/blocs/incident_form/incident_form_bloc.dart';
import 'package:offline_first/features/incidents/presentation/widgets/type_file_selector.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:offline_first/core/config/theme/app_colors.dart';
import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:offline_first/core/config/theme/app_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';

class IncidentsDetailsScreen extends StatelessWidget {
  const IncidentsDetailsScreen({super.key, required this.incidentId});
  final String incidentId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncidentFormBloc(
          incident: null,
          keyValueStorageService: KeyValueStorageServiceImpl(),
          incidentLocalRepository: IncidentLocalRepositoryImpl()),
      child: _Scaffold(incidentId: incidentId),
    );
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold({
    required this.incidentId,
  });

  final String incidentId;

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  @override
  void initState() {
    context
        .read<IncidentFormBloc>()
        .add(OnGetIncidentByRecordId(recordId: widget.incidentId));
    context
        .read<IncidentFormBloc>()
        .add(OnGetPhotosUrlsByRecordId(recordId: widget.incidentId));
    context
        .read<IncidentFormBloc>()
        .add(OnGetVoiceNotesUrlsByRecordId(recordId: widget.incidentId));
    context
        .read<IncidentFormBloc>()
        .add(OnGetDocumentsUrlsByRecordId(recordId: widget.incidentId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FToast().init(context);

    return BlocConsumer<IncidentFormBloc, IncidentFormState>(
      listener: (context, state) {
        log(state.startDate.toString());
        if (state.message != '') {
          AlertsManager.showToastCustom(ToastSuccess(text: state.message));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarCustom(
            titleText: state.incidentByRecordId?.circuitNumber,
            actions: [
              IconButton(
                  onPressed: () {
                    context.push('/incident-form/${widget.incidentId}',
                        extra: {'incident': state.incidentByRecordId});
                  },
                  icon: const Icon(FluentIcons.edit_20_regular)),
              _DeleteButton(widget: widget),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p8, horizontal: AppPadding.p18),
                color: AppColors.white,
                width: Size.infinite.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${state.incidentByRecordId?.title}',
                        style: getMediumStyle(fontSize: FontSize.s16)),
                    _TextLabel(
                      text: state.incidentByRecordId?.startDate != null
                          ? 'Reportado en ${DateManager.formatDateLageHuman(state.incidentByRecordId?.creation ?? '')}'
                          : '',
                      fontSize: FontSize.s14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: Size.infinite.width,
                  color: AppColors.grey200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p8, horizontal: AppPadding.p18),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionContainer(
                            horizontalPadding: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const _TextLabel(
                                        text: 'Tipo de incidencia'),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${state.incidentByRecordId?.typeIncident.value?.name}'),
                                  ],
                                ),
                                const SizedBox(
                                    height: 20,
                                    child: VerticalDivider(
                                      color: AppColors.grey300,
                                    )),
                                Column(
                                  children: [
                                    const _TextLabel(text: 'Prioridad'),
                                    StatusRow(
                                      text:
                                          '${state.incidentByRecordId?.priorityId}',
                                      icon: IconManager.getIconByTypePriority(
                                          state.incidentByRecordId
                                                  ?.priorityId ??
                                              ''),
                                      iconColor:
                                          AppColors.getColorByTypePriority(state
                                                  .incidentByRecordId
                                                  ?.priorityId ??
                                              ''),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _DescriptionCard(state: state),
                          SectionContainer(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _TextLabel(text: 'Vehiculo'),
                              Text(
                                  '${state.incidentByRecordId?.vehicle.value?.fleetNumber} [${state.incidentByRecordId?.vehicle.value?.year} ${state.incidentByRecordId?.vehicle.value?.vehicleBrand.name}]'),
                              const SizedBox(height: AppMargin.m12),
                              const _TextLabel(text: 'Reportado por:'),
                              Text(
                                  '${state.incidentByRecordId?.employee.value?.entity.completeName}'),
                              const SizedBox(height: AppMargin.m12),
                              const _TextLabel(text: 'Reportado en:'),
                              Text(DateManager.formatDateLageHuman(
                                  state.incidentByRecordId?.creation ??
                                      DateTime.now().toString())),
                              const SizedBox(height: AppMargin.m12),
                              const _TextLabel(text: 'Asignados:'),
                              Text(
                                  '${state.incidentByRecordId?.assignedEmployees.map((employee) => employee.entity.completeName).join(', ')}')
                            ],
                          )),
                          TypeFileSelector(
                            photosQuantity: state.photos?.length,
                            documentsQuantity: state.documents?.length,
                            audiosQuantity: state.audios?.length,
                            onTapPhotos: () => context.pushNamed('photos',
                                extra: {
                                  'context': context,
                                  'id': widget.incidentId
                                }),
                            onTapAudios: () => context.pushNamed('audios',
                                extra: {
                                  'context': context,
                                  'id': widget.incidentId
                                }),
                            onTapDocuments: () => context.pushNamed('documents',
                                extra: {
                                  'context': context,
                                  'id': widget.incidentId
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    required this.widget,
  });

  final _Scaffold widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          AlertsManager.showDialogCustom(
              context,
              Dialog(
                backgroundColor: AppColors.white,
                insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.delete_48_regular,
                        size: 50,
                        color: AppColors.red500,
                      ),
                      const SizedBox(
                        height: AppMargin.m12,
                      ),
                      Text(
                        '¿Estás seguro que deseas eliminar esta incidencia?',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(fontSize: FontSize.s14),
                      ),
                      const SizedBox(height: AppMargin.m8),
                      Text(
                        'Los datos eliminados no serán recuperados de forma permanente',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            fontSize: FontSize.s12, color: AppColors.grey600),
                      ),
                      const SizedBox(height: AppPadding.p16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => context.pop(),
                              child: Text('Cancelar',
                                  style: getMediumStyle(
                                      color: AppColors.primaryColor))),
                          const SizedBox(width: AppMargin.m10),
                          ActionChip(
                            side: BorderSide.none,
                            visualDensity: VisualDensity.compact,
                            shape: const StadiumBorder(),
                            backgroundColor: AppColors.primaryColor,
                            label: Text('Eliminar',
                                style: getMediumStyle(color: AppColors.white)),
                            onPressed: () {
                              context.read<IncidentFormBloc>().add(
                                  OnDeleteIncident(
                                      recordId: widget.incidentId));

                              context
                                ..pop()
                                ..pop();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
        icon:
            const Icon(FluentIcons.delete_20_regular, color: AppColors.red500));
  }
}

class _DescriptionCard extends StatefulWidget {
  const _DescriptionCard({required this.state});
  final IncidentFormState state;
  @override
  State<_DescriptionCard> createState() => _DescriptionCardState();
}

class _DescriptionCardState extends State<_DescriptionCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding:
          const EdgeInsets.symmetric(vertical: AppPadding.p12, horizontal: 16),
      constraints: const BoxConstraints(
        minHeight: 20.0,
      ),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.br8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _TextLabel(text: 'Descripción'),
              TextButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size?>(const Size(10, 10)),
                    overlayColor: MaterialStateProperty.all<Color?>(
                        AppColors.transparent),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        EdgeInsets.zero)),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Ver menos' : 'Ver más',
                  style: getRegularStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            ],
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppBorderRadius.br8)),
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(top: 6.0),
            height: isExpanded ? null : 50.0,
            child: Text('${widget.state.incidentByRecordId?.body}',
                style: getRegularStyle(fontSize: FontSize.s14)),
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.text});
  final IconData icon;
  final Color iconColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 2),
            Text(text, style: getRegularStyle()),
          ],
        ),
      ],
    );
  }
}

class _TextLabel extends StatelessWidget {
  const _TextLabel({required this.text, this.fontSize = FontSize.s12});
  final String text;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle(color: AppColors.grey700, fontSize: fontSize!),
    );
  }
}
