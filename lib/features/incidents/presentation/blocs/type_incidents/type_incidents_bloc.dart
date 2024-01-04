import 'dart:developer';

import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';
import 'package:offline_first/features/incidents/domain/repositories/local/incident_local_repository.dart';
import 'package:offline_first/features/incidents/domain/repositories/remote/incident_remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'type_incidents_event.dart';
part 'type_incidents_state.dart';

class TypesIncidentsBloc extends Bloc<TypesIncidentsEvent, TypeIncidentsState> {
  TypesIncidentsBloc(
      {required IncidentLocalRepository incidentLocalRepository,
      required IncidentRemoteRepository incidentRemoteRepository})
      : _incidentLocalRepository = incidentLocalRepository,
        _incidentRemoteRepository = incidentRemoteRepository,
        super(const TypeIncidentsState()) {
    on<OnSaveTypesIncidents>(_saveTypes);
    on<OnSetTypeIncident>(_setCurrentType);
    on<OnSetTypeIncidentUpdating>(_setCurrentTypeUpdating);
    on<OnGetTypesIncidents>(_getTypes);
    on<OnClearTypeIncident>(_clearTypeIncident);
  }

  final IncidentLocalRepository _incidentLocalRepository;
  final IncidentRemoteRepository _incidentRemoteRepository;
  Future<void> _saveTypes(
      OnSaveTypesIncidents event, Emitter<TypeIncidentsState> emit) async {
    try {
      final types = await _incidentRemoteRepository.getTypesIncidents();

      await _incidentLocalRepository.createTypesIncidents(types);
    } catch (e) {
      emit(state.copyWith(
          message:
              'Ocurrió un error al querer guardar los tipos de incidencias en la bd local'));
      log('Ocurrió un error al querer guardar los tipos de incidencias $e');
    }
  }

  Future<void> _setCurrentType(
      OnSetTypeIncident event, Emitter<TypeIncidentsState> emit) async {
    final typeIncident = state.incidentsTypes[event.index];
    emit(state.copyWith(currentType: () => typeIncident));
  }

  void _setCurrentTypeUpdating(
      OnSetTypeIncidentUpdating event, Emitter<TypeIncidentsState> emit) {
    emit(state.copyWith(currentType: () => event.type));
  }

  void _clearTypeIncident(
      OnClearTypeIncident event, Emitter<TypeIncidentsState> emit) {
    emit(state.copyWith(currentType: () => null));
  }

  Future<void> _getTypes(
      OnGetTypesIncidents event, Emitter<TypeIncidentsState> emit) async {
    try {
      emit(state.copyWith(typeIncidentsStatus: TypeIncidentsStatus.waiting));
      final resp = await _incidentLocalRepository.getTypesIncidents();
      emit(state.copyWith(
          incidentsTypes: resp,
          typeIncidentsStatus: TypeIncidentsStatus.established));
    } catch (e) {
      emit(state.copyWith(typeIncidentsStatus: TypeIncidentsStatus.none));
    }
  }
}
