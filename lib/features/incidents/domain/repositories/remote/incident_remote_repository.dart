import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';

abstract class IncidentRemoteRepository {
  Future<List<TypeIncidentData>> getTypesIncidents();
}
