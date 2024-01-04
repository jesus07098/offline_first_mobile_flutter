import '../../entities/type_incident.dart';

abstract class IncidentRemoteDatasource {
  Future<List<TypeIncidentData>> getTypesIncidents();
}
