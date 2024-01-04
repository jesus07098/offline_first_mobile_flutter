import '../../../../../core/data/services/api_service_impl.dart';
import '../../../domain/datasources/remote/incident_remote_datasource.dart';
import '../../../domain/entities/type_incident.dart';

class IncidentRemoteDatasourceImpl extends IncidentRemoteDatasource {
  final apiService = DioApiService();
  @override
  Future<List<TypeIncidentData>> getTypesIncidents() async {
    try {
      final response = await apiService.get(
        '/app/issue-types',
      );

      final typeIncidentResponse = TypeIncident.fromJson(response.data);

      return typeIncidentResponse.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
