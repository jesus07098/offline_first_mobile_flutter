part of 'vehicles_bloc.dart';

abstract class VehiclesEvent {
  const VehiclesEvent();
}

class OnSaveVehicles extends VehiclesEvent {}

class OnGetVehicles extends VehiclesEvent {}

class OnClearCurrentVehicle extends VehiclesEvent {}

class OnSetCurrentVehicle extends VehiclesEvent {
  final int index;

  const OnSetCurrentVehicle({required this.index});
}


class OnSetCurrentVehicleUpdating extends VehiclesEvent {
  final VehicleData vehicle;

  const OnSetCurrentVehicleUpdating({required this.vehicle});
}