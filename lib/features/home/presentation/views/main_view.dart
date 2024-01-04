import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_fonts.dart';
import '../../../../core/config/theme/app_values.dart';
import '../../../../core/data/services/key_value_storage_service_impl.dart';
import '../../../../core/utils/date_format.dart';
import '../../../incidents/data/repositories/local/incident_local_repository_impl.dart';
import '../../../incidents/presentation/blocs/incident_form/incident_form_bloc.dart';
import '../widgets/card_notification.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const name = '/';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncidentFormBloc(
          incident: null,
          keyValueStorageService: KeyValueStorageServiceImpl(),
          incidentLocalRepository: IncidentLocalRepositoryImpl()),
      child: Scaffold(body: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<IncidentFormBloc>().add(OnGetIncidents());
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  // Visibility(
                  //   visible: false,
                  //   child: ActionCard(
                  //     icon: FluentIcons.barcode_scanner_24_regular,
                  //     label: 'Escanear Código',
                  //     onTap: () => context.pushNamed('scanner'),
                  //   ),
                  // ),
                  ActionCard(
                    icon: FluentIcons.error_circle_24_regular,
                    label: 'Crear incidencia',
                    onTap: () {
                      context.push('/incident-form/new', extra: {
                        'incident': null
                      });
                    },
                  ),
                  // ActionCard(
                  //   icon: FluentIcons.clipboard_task_list_ltr_24_regular,
                  //   label: 'Crear Tarea',
                  //   onTap: () => context.pushNamed('task-form'),
                  // ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppMargin.m10),
                child: SectionDivider(
                  title: 'Últimas incidencias',
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<IncidentFormBloc, IncidentFormState>(
          builder: (context, state) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  return CardNotifitication(
                    onTap: () => context.push(
                        '/main/0/incident-details/${state.incidents[i].recordId}'),
                    incidentNumber: state.incidents[i].circuitNumber,
                    date: DateManager.formatTimeAgo(
                        DateTime.parse(state.incidents[i].startDate)),
                    description: state.incidents[i].title,
                    vehicleRecord:
                        '${state.incidents[i].vehicle.value?.name} | ${state.incidents[i].address}',
                    statusColor: AppColors.green400,
                    priorityLabel: state.incidents[i].priorityId,
                    statusLabel: 'Abierta',
                  );
                },
                childCount:
                    10 <= state.incidents.length ? 10 : state.incidents.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider(
      {super.key, required this.title, this.onPressed, this.textOfButton});

  final String title;
  final void Function()? onPressed;
  final String? textOfButton;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: getSemiBoldStyle(fontSize: FontSize.s14)),
      if (onPressed != null)
        TextButton(onPressed: onPressed, child: Text(textOfButton ?? '')),
    ]);
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key, this.onTap, required this.label, required this.icon});
  final void Function()? onTap;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.50 - 23,
          padding: const EdgeInsets.all(AppPadding.p14),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(AppBorderRadius.br10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.primaryColor),
              const SizedBox(height: AppMargin.m10),
              Text(
                label,
                style: getSemiBoldStyle(),
              )
            ],
          )),
    );
  }
}
