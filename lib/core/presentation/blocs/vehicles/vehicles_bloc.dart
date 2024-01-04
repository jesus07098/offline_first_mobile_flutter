import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:offline_first/core/domain/repositories/local/vehicle_local_repository.dart';
import 'package:offline_first/core/domain/repositories/remote/vehicle_remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/vehicle.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  VehiclesBloc(
      {required VehicleLocalRepository vehicleLocalRepository,
      required VehicleRemoteRepository vehicleRemoteRepository})
      : _vehicleLocalRepository = vehicleLocalRepository,
        _vehicleRemoteRepository = vehicleRemoteRepository,
        super(const VehiclesState()) {
    on<OnSaveVehicles>(_saveVehicles);
    on<OnGetVehicles>(_getVehicles);
    on<OnSetCurrentVehicle>(_setCurrentVehicle);
    on<OnSetCurrentVehicleUpdating>(_setCurrentVehicleUpdating);
    on<OnClearCurrentVehicle>(_clearCurrentVehicle);
  }

  final VehicleLocalRepository _vehicleLocalRepository;
  final VehicleRemoteRepository _vehicleRemoteRepository;
  Future<void> _saveVehicles(
      OnSaveVehicles event, Emitter<VehiclesState> emit) async {
    final vehiclesApi = await _vehicleRemoteRepository.getVehicles();
    try {
      await _vehicleLocalRepository.createVehicle(vehiclesApi);
    } catch (e) {
      emit(state.copyWith(
          message: 'Ocurrió un error al querer guardar un vehiculo'));
    }
  }

  Future<void> _getVehicles(
      OnGetVehicles event, Emitter<VehiclesState> emit) async {
    try {
      emit(state.copyWith(vehicleStatus: VehicleStatus.waiting));
      final resp = await _vehicleLocalRepository.getVehicles();
      emit(state.copyWith(
          vehicles: resp, vehicleStatus: VehicleStatus.established));
    } catch (e) {
      emit(state.copyWith(vehicleStatus: VehicleStatus.none));
    }
  }

  void _clearCurrentVehicle(
      OnClearCurrentVehicle event, Emitter<VehiclesState> emit) {
    emit(state.copyWith(currentVehicle: () => null));
  }

  Future<void> _setCurrentVehicle(
      OnSetCurrentVehicle event, Emitter<VehiclesState> emit) async {
    final vehicle = state.vehicles[event.index];
    emit(state.copyWith(currentVehicle: () => vehicle));
  }

  void _setCurrentVehicleUpdating(
      OnSetCurrentVehicleUpdating event, Emitter<VehiclesState> emit) {
    emit(state.copyWith(currentVehicle: () => event.vehicle));
  }
}
