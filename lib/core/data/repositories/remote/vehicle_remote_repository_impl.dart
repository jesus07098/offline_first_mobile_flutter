import '../../../domain/datasources/remote/vehicle_remote_datasource.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/remote/vehicle_remote_repository.dart';
import '../../datasources/remote/vehicle_remote_datasource_impl.dart';

class VehicleRemoteRepositoryImpl extends VehicleRemoteRepository {
  final VehicleRemoteDatasource datasource;
  VehicleRemoteRepositoryImpl({VehicleRemoteDatasourceImpl? datasource})
      : datasource = datasource ?? VehicleRemoteDatasourceImpl();

  @override
  Future<List<VehicleData>> getVehicles() {
    return datasource.getVehicles();
  }
}
