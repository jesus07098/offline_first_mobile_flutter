import 'package:offline_first/core/data/datasources/local/vehicle_local_datasource_impl.dart';


import '../../../domain/datasources/local/vehicle_local_datasource.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/local/vehicle_local_repository.dart';

class VehicleLocalRepositoryImpl extends VehicleLocalRepository {

  final VehicleLocalDatasource datasource;

  VehicleLocalRepositoryImpl({VehicleLocalDatasourceImpl? datasource}): datasource = datasource ?? VehicleLocalDatasourceImpl();

  @override
  Future<void> createVehicle(List<VehicleData> vehicle) {
    return datasource.createVehicles(vehicle);
  }

  @override
  Future<List<VehicleData>> getVehicles() {
    return datasource.getVehicles();
  }
}
