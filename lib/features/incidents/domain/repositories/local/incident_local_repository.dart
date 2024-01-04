import '../../entities/incident.dart';
import '../../entities/type_incident.dart';

abstract class IncidentLocalRepository {
  Future<void> updateIncident(Incident incident);
  Future<void> createIncident(Incident incident);
  Future<void> createTypesIncidents(List<TypeIncidentData> incidentsTypes);
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
