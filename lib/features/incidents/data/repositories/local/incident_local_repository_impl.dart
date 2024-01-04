import '../../../domain/datasources/local/incident_local_datasource.dart';
import '../../../domain/entities/incident.dart';
import '../../../domain/entities/type_incident.dart';
import '../../../domain/repositories/local/incident_local_repository.dart';
import '../../datasources/local/incident_local_datasource_impl.dart';

class IncidentLocalRepositoryImpl extends IncidentLocalRepository {
  final IncidentLocalDatasource datasource;

  @override
  IncidentLocalRepositoryImpl({IncidentLocalDatasourceImpl? datasource})
      : datasource = datasource ?? IncidentLocalDatasourceImpl();

  @override
  Future<void> createIncident(Incident incident) {
    return datasource.createIncident(incident);
  }

  @override
  Future<void> createTypesIncidents(List<TypeIncidentData> incidentsTypes) {
    return datasource.createTypeIncidents(incidentsTypes);
  }

  @override
  Future<List<TypeIncidentData>> getTypesIncidents() {
    return datasource.getTypesIncidents();
  }

  @override
  Future<List<Incident>> getIncidents() {
    return datasource.getIncidents();
  }

  @override
  Future<List<Incident>> getIncidentsByCircuitAndTitle(String value) {
    return datasource.getIncidentsByCircuitAndTitle(value);
  }

  @override
  Future<void> deleteIncidentByRecordId(String recordId) {
    return datasource.deleteIncidentByRecordId(recordId);
  }

  @override
  Future<Incident?> getIncidentByRecordId(String recordId) {
    return datasource.getIncidentByRecordId(recordId);
  }

  @override
  Future<List<String>> getDocumentUrlsByRecordId(String recordId) {
    return datasource.getDocumentUrlsByRecordId(recordId);
  }

  @override
  Future<List<String>> getPhotoUrlsByRecordId(String recordId) {
    return datasource.getPhotoUrlsByRecordId(recordId);
  }

  @override
  Future<List<String>> getVoiceNoteUrlsByRecordId(String recordId) {
    return datasource.getVoiceNoteUrlsByRecordId(recordId);
  }

  @override
  Future<void> updatePhotosByRecorId(String recordId, List<Document> urls) {
    return datasource.updatePhotosByRecorId(recordId, urls);
  }

  @override
  Future<void> updateAudiosByRecorId(String recordId, List<Document> urls) {
    return datasource.updateAudiosByRecorId(recordId, urls);
  }

  @override
  Future<void> updateDocumentsByRecorId(String recordId, List<Document> urls) {
    return datasource.updateDocumentsByRecorId(recordId, urls);
  }

  @override
  Future<void> updateIncident(Incident incident) {
    return datasource.updateIncident(incident);
  }
}
