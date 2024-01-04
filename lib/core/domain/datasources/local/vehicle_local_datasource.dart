import '../../entities/vehicle.dart';

abstract class VehicleLocalDatasource {
  Future<void> createVehicles(List<VehicleData> vehicles);
  Future<List<VehicleData>> getVehicles();
}
