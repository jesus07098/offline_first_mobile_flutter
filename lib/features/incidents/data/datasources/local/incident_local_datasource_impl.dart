import 'dart:developer';

import 'package:offline_first/core/domain/entities/entities.dart';
import 'package:isar/isar.dart';

import 'package:offline_first/features/incidents/domain/entities/incident.dart';
import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';

import '../../../../../core/data/services/local_db_impl.dart';
import '../../../domain/datasources/local/incident_local_datasource.dart';

class IncidentLocalDatasourceImpl extends IncidentLocalDatasource {
  @override
  Future<void> createIncident(Incident incident) async {
// Buscar el vehículo por su ID
    final vehicle = await IsarDbImpl.instance.vehicleDatas
        .filter()
        .idEqualTo(incident.vehicleId)
        .findFirst();
    // Buscar el empleado que reportó la incidencia por su ID
    final reportedBy = await IsarDbImpl.instance.employeeDatas
        .filter()
        .entity((q) => q.idEqualTo(incident.reportedById))
        .findFirst();

    // Buscar tipo de incidencia por su ID
    final incidentType = await IsarDbImpl.instance.typeIncidentDatas
        .filter()
        .idEqualTo(incident.issueTypeId)
        .findFirst();

    // Buscar los empleados asignados a la incidencia
    final List<EmployeeData> assignedEmployees = await IsarDbImpl
        .instance.employeeDatas
        .where()
        .anyOf(incident.assignedContactsId,
            (q, employeeId) => q.idEqualTo(employeeId))
        .findAll();

    final vehicleLinked = incident..vehicle.value = vehicle;
    final reportedByLinked = incident..employee.value = reportedBy;
    final incidentTypeLinked = incident..typeIncident.value = incidentType;
    final assignedEmployeesLinked = incident
      ..assignedEmployees.addAll(assignedEmployees);

    await IsarDbImpl.instance.writeTxn(() async {
      await IsarDbImpl.instance.incidents.put(incident);
      await IsarDbImpl.instance.vehicleDatas.put(vehicle!);
      await IsarDbImpl.instance.employeeDatas.put(reportedBy!);
      await IsarDbImpl.instance.employeeDatas.putAll(assignedEmployees);
      await vehicleLinked.vehicle.save();
      await reportedByLinked.employee.save();
      await incidentTypeLinked.typeIncident.save();
      await assignedEmployeesLinked.assignedEmployees.save();
    });
  }

  @override
  Future<void> createTypeIncidents(
      List<TypeIncidentData> incidentsTypes) async {
    await IsarDbImpl.instance.writeTxn(() async {
      await IsarDbImpl.instance.typeIncidentDatas
          .putAllByIndex('id', incidentsTypes);
    });
  }

  @override
  Future<List<TypeIncidentData>> getTypesIncidents() async {
    return await IsarDbImpl.instance.typeIncidentDatas.where().findAll();
  }

  @override
  Future<List<Incident>> getIncidents() async {
    final incidents = await IsarDbImpl.instance.incidents.where().findAll();
    return incidents.reversed.toList();
  }

  @override
  Future<List<Incident>> getIncidentsByCircuitAndTitle(String value) async {
    final incidents = await IsarDbImpl.instance.incidents
        .filter()
        .titleContains(value, caseSensitive: false)
        .or()
        .circuitNumberContains(value, caseSensitive: false)
        .findAll();

    return incidents.reversed.toList();
  }

  @override
  Future<void> deleteIncidentByRecordId(String recordId) async {
    try {
      await IsarDbImpl.instance.writeTxn(() async {
        await IsarDbImpl.instance.incidents
            .filter()
            .recordIdEqualTo(recordId)
            .deleteFirst();
      });
    } catch (e) {
      Exception('Error al querer eliminar una incidencia por record id, $e');
    }
  }

  @override
  Future<Incident?> getIncidentByRecordId(String recordId) async {
    try {
      final incident = await IsarDbImpl.instance.incidents
          .filter()
          .recordIdEqualTo(recordId)
          .findFirst();
      if (incident != null) {
        return incident;
      }
      return null;
    } catch (e) {
      Exception(
          'Ocurrió un error al querer obtener una incidencia por recordId $e');
      return null;
    }
  }

  @override
  Future<List<String>> getPhotoUrlsByRecordId(String recordId) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();
    final incidentPhotos =
        incident?.photos?.map((photos) => photos.url!).toList() ?? [];

    return incidentPhotos;
  }

  @override
  Future<List<String>> getVoiceNoteUrlsByRecordId(String recordId) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();
    final incidentVoiceNotes =
        incident?.voiceNotes?.map((voiceNotes) => voiceNotes.url!).toList() ??
            [];

    return incidentVoiceNotes;
  }

  @override
  Future<List<String>> getDocumentUrlsByRecordId(String recordId) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();
    final incidentDocs =
        incident?.documents?.map((document) => document.url!).toList() ?? [];

    return incidentDocs;
  }

  @override
  Future<void> updatePhotosByRecorId(
      String recordId, List<Document> urls) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();

    if (incident != null) {
      await IsarDbImpl.instance.writeTxn(() async {
        incident.photos = urls;
        await IsarDbImpl.instance.incidents.put(incident);
      });
    }
  }

  @override
  Future<void> updateAudiosByRecorId(
      String recordId, List<Document> urls) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();

    if (incident != null) {
      await IsarDbImpl.instance.writeTxn(() async {
        log('URLS AGREGADAS $urls');
        incident.voiceNotes = urls;
        await IsarDbImpl.instance.incidents.put(incident);
      });
    }
  }

  @override
  Future<void> updateDocumentsByRecorId(
      String recordId, List<Document> urls) async {
    final incident = await IsarDbImpl.instance.incidents
        .where()
        .filter()
        .recordIdEqualTo(recordId)
        .findFirst();

    if (incident != null) {
      await IsarDbImpl.instance.writeTxn(() async {
        incident.documents = urls;
        await IsarDbImpl.instance.incidents.put(incident);
      });
    }
  }

  @override
  Future<void> updateIncident(Incident incident) async {
    // Buscar el vehículo por su ID
    final vehicle = await IsarDbImpl.instance.vehicleDatas
        .filter()
        .idEqualTo(incident.vehicleId)
        .findFirst();
    // Buscar el empleado que reportó la incidencia por su ID
    final reportedBy = await IsarDbImpl.instance.employeeDatas
        .filter()
        .entity((q) => q.idEqualTo(incident.reportedById))
        .findFirst();

    // Buscar tipo de incidencia por su ID
    final incidentType = await IsarDbImpl.instance.typeIncidentDatas
        .filter()
        .idEqualTo(incident.issueTypeId)
        .findFirst();

    // Buscar los empleados asignados a la incidencia
    final List<EmployeeData> assignedEmployees = await IsarDbImpl
        .instance.employeeDatas
        .where()
        .anyOf(incident.assignedContactsId,
            (q, employeeId) => q.idEqualTo(employeeId))
        .findAll();

    final vehicleLinked = incident..vehicle.value = vehicle;
    final reportedByLinked = incident..employee.value = reportedBy;
    final incidentTypeLinked = incident..typeIncident.value = incidentType;
    final assignedEmployeesLinked = incident
      ..assignedEmployees.addAll(assignedEmployees);
    await IsarDbImpl.instance.writeTxn(() async {
      await IsarDbImpl.instance.incidents.putByIndex('recordId', incident);
      await IsarDbImpl.instance.vehicleDatas.put(vehicle!);
      await IsarDbImpl.instance.employeeDatas.put(reportedBy!);
      await IsarDbImpl.instance.employeeDatas.putAll(assignedEmployees);
      await vehicleLinked.vehicle.save();
      await reportedByLinked.employee.save();
      await incidentTypeLinked.typeIncident.save();
      await assignedEmployeesLinked.assignedEmployees.save();
    });
  }
}
