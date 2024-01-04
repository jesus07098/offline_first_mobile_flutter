import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';

import '../../../domain/datasources/remote/incident_remote_datasource.dart';
import '../../../domain/repositories/remote/incident_remote_repository.dart';
import '../../datasources/remote/incident_remote_datasource_impl.dart';


class IncidentRemoteRepositoryImpl extends IncidentRemoteRepository {
  final IncidentRemoteDatasource datasource;
  IncidentRemoteRepositoryImpl({IncidentRemoteDatasourceImpl? datasource})
      : datasource = IncidentRemoteDatasourceImpl();
  @override
  Future<List<TypeIncidentData>> getTypesIncidents() {
    return datasource.getTypesIncidents();
  }
}
