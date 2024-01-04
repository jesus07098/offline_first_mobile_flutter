import 'package:offline_first/core/domain/entities/vehicle.dart';

abstract class VehicleRemoteRepository {
  Future<List<VehicleData>> getVehicles();
}