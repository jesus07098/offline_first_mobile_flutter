import '../../entities/vehicle.dart';

abstract class VehicleLocalRepository {
  Future<void> createVehicle(List<VehicleData> vehicle);
  Future<List<VehicleData>> getVehicles();
} 