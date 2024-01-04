import 'package:offline_first/core/data/services/key_value_storage_service_impl.dart';
import 'package:offline_first/features/incidents/data/repositories/local/incident_local_repository_impl.dart';
import 'package:offline_first/features/incidents/presentation/blocs/incident_form/incident_form_bloc.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:offline_first/features/home/presentation/widgets/card_notification.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_values.dart';
import '../../../../core/utils/date_format.dart';

class IncidentsView extends StatefulWidget {
  const IncidentsView({super.key});

  @override
  State<IncidentsView> createState() => _IncidentsViewState();
}

class _IncidentsViewState extends State<IncidentsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IncidentFormBloc(
          incident: null,
          keyValueStorageService: KeyValueStorageServiceImpl(),
          incidentLocalRepository: IncidentLocalRepositoryImpl()),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<IncidentFormBloc>().add(OnGetIncidents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Incident> filteredIncidents =
    //     incidentFormBloc.state.incidents.where((incident) {
    //   final searchTerm = searchController.text.toLowerCase();
    //   return incident.title.toLowerCase().contains(searchTerm);
    // }).toList();

    return BlocBuilder<IncidentFormBloc, IncidentFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                context
                    .read<IncidentFormBloc>()
                    .add(OnGetIncidentsByTitle(value: value));
              },
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar por Circuito o Título',
                prefixIcon: Icon(FluentIcons.search_20_filled,
                    color: AppColors.grey500),
                filled: true,
                fillColor: AppColors.grey200,
                border: UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppBorderRadius.br12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppMargin.m8),
            Expanded(
              child: ListView.builder(
                  itemCount: state.incidents.length,
                  itemBuilder: (_, i) {
                    final incident = state.incidents[i];

                    return CardNotifitication(
                      onTap: () => context.push(
                          '/main/1/incident-details/${incident.recordId}'),
                      incidentNumber: incident.circuitNumber,
                      date: DateManager.formatTimeAgo(
                          DateTime.parse(incident.startDate)),
                      description: incident.title,
                      vehicleRecord:
                          '${incident.vehicle.value?.name ?? 'N/A'} | ${incident.address}',
                      statusColor: AppColors.green400,
                      priorityLabel: incident.priorityId,
                      statusLabel: 'Abierta',
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}

// searchRoutineByName(String searchName) async {
//     searching = true;
//     final routineCollection = widget.isar.routines;
//     final searchResults =
//         await routineCollection.filter().titleContains(searchName).findAll();
//     setState(() {
//       routines = searchResults;
//     });
//   }

        // const SizedBox(height: AppMargin.m8),


           // ActionChipCustom(
        //   label: 'Ordenar por',
        //   leadingIcon: FluentIcons.arrow_sort_20_filled,
        //   onPressed: () {},
        // ),