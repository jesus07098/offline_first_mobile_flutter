import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/local/entity_local_repository.dart';
import '../../../domain/repositories/remote/entity_remote_repository.dart';

part 'entities_event.dart';
part 'entities_state.dart';

class EntitiesBloc extends Bloc<EntitiesEvent, EntitiesState> {
  EntitiesBloc(
      {required EntityLocalRepository entityLocalRepository,
      required EntityRemoteRepository entityRemoteRepository})
      : _entityLocalRepository = entityLocalRepository,
        _entityRemoteRepository = entityRemoteRepository,
        super(const EntitiesState()) {
    on<OnSaveEmployees>(_createEmployees);
    on<OnGetEmployees>(_getEmployees);
    on<OnSetCurrentEmployee>(_setCurrentEmployee);
    on<OnSetCurrentEmployeeUpdating>(_setCurrentEmployeeUpdating);
    on<OnClearCurrentEmployee>(_clearCurrentEmployee);
    on<OnSetAssignedEmployees>(_setAssignedEmployees);
    on<OnSetAssignedEmployeesUpdating>(_setAssignedEmployeesUpdating);
    on<OnClearAssignedEmployees>(_clearAssignedEmployees);
  }

  final EntityLocalRepository _entityLocalRepository;
  final EntityRemoteRepository _entityRemoteRepository;
  _createEmployees(OnSaveEmployees event, Emitter<EntitiesState> emit) async {
    try {
      final employees = await _entityRemoteRepository.getEmployees();
      _entityLocalRepository.createEmployees(employees);
    } catch (e) {
      log('Ocurrió un error al guardar los empleados $e');
    }
  }

  Future<void> _getEmployees(
      OnGetEmployees event, Emitter<EntitiesState> emit) async {
    try {
      emit(state.copyWith(status: EntityStatus.waiting));
      final resp = await _entityLocalRepository.getEmployees();
      emit(state.copyWith(employees: resp, status: EntityStatus.established));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.none));
    }
  }

  Future<void> _setCurrentEmployee(
      OnSetCurrentEmployee event, Emitter<EntitiesState> emit) async {
    final employee = state.employees[event.index];
    emit(state.copyWith(currentEmployee: () => employee));
  }

  void _clearCurrentEmployee(
      OnClearCurrentEmployee event, Emitter<EntitiesState> emit) {
    emit(state.copyWith(currentEmployee: () => null));
  }

  Future<void> _setAssignedEmployees(
      OnSetAssignedEmployees event, Emitter<EntitiesState> emit) async {
    final indexes = event.indexes;
    List<EmployeeData> assignedEmployees = [];
    for (int index in indexes) {
      if (index >= 0 && index < state.employees.length) {
        assignedEmployees.add(state.employees[index]);
      }
    }
    emit(state.copyWith(assignedEmployees: () => assignedEmployees));
  }

  void _clearAssignedEmployees(
      OnClearAssignedEmployees event, Emitter<EntitiesState> emit) {
    emit(state.copyWith(assignedEmployees: () => null));
  }

  void _setAssignedEmployeesUpdating(
      OnSetAssignedEmployeesUpdating event, Emitter<EntitiesState> emit) {
    emit(state.copyWith(assignedEmployees: () => event.employees));
  }

  void _setCurrentEmployeeUpdating(
      OnSetCurrentEmployeeUpdating event, Emitter<EntitiesState> emit) {
    emit(state.copyWith(currentEmployee: () => event.employee));
  }
}
