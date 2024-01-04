part of 'vehicles_bloc.dart';

enum VehicleStatus {
  none,
  waiting,
  sending,
  established,
}

class VehiclesState extends Equatable {
  final VehicleStatus vehicleStatus;
  final List<VehicleData> vehicles;
  final String message;
  final VehicleData? currentVehicle;
  const VehiclesState(
      {this.vehicleStatus = VehicleStatus.none,
      this.vehicles = const [],
      this.message = '',
      this.currentVehicle});
  VehiclesState copyWith(
      {VehicleStatus? vehicleStatus,
      List<VehicleData>? vehicles,
      String? message,
      VehicleData? Function()? currentVehicle}) {
    return VehiclesState(
        vehicleStatus: vehicleStatus ?? this.vehicleStatus,
        vehicles: vehicles ?? this.vehicles,
        message: message ?? this.message,
        currentVehicle:
            currentVehicle != null ? currentVehicle() : this.currentVehicle);
  }

  @override
  List<Object?> get props => [vehicleStatus, message, vehicles, currentVehicle];
}
