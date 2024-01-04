import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';

import '../../entities/incident.dart';

abstract class IncidentLocalDatasource {
  Future<void> createIncident(Incident incident);
  Future<void> createTypeIncidents(List<TypeIncidentData> incidentsTypes);
  Future<void> updateIncident(Incident incident);
  Future<List<TypeIncidentData>> getTypesIncidents();
  Future<List<Incident>> getIncidents();
  Future<List<Incident>> getIncidentsByCircuitAndTitle(String value);
  Future<Incident?> getIncidentByRecordId(String recordId);
  Future<void> deleteIncidentByRecordId(String recordId);
  Future<List<String>> getPhotoUrlsByRecordId(String recordId);
  Future<List<String>> getDocumentUrlsByRecordId(String recordId);
  Future<List<String>> getVoiceNoteUrlsByRecordId(String recordId);
  Future<void> updatePhotosByRecorId(String recordId, List<Document> urls);
  Future<void> updateAudiosByRecorId(String recordId, List<Document> urls);
  Future<void> updateDocumentsByRecorId(String recordId, List<Document> urls);
}
