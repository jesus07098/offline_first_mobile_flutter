import '../../../domain/datasources/remote/vehicle_remote_datasource.dart';
import '../../../domain/entities/vehicle.dart';
import '../../services/api_service_impl.dart';

class VehicleRemoteDatasourceImpl extends VehicleRemoteDatasource {
  final apiService = DioApiService();

  @override
  Future<List<VehicleData>> getVehicles() async {
    try {
      final response = await apiService.get(
        '/app/vehicles',
      );

      final vehicles = Vehicle.fromJson(response.data);

      return vehicles.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
