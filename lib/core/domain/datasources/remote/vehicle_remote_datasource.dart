import 'package:offline_first/core/domain/entities/vehicle.dart';

abstract class VehicleRemoteDatasource {
  Future<List<VehicleData>> getVehicles();
}