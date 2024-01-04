import 'dart:convert';

import 'package:offline_first/core/domain/entities/entities.dart';
import 'package:offline_first/features/incidents/domain/entities/type_incident.dart';
import 'package:isar/isar.dart';

part 'incident.g.dart';

Incident incidentsFromJson(String str) => Incident.fromJson(json.decode(str));

String incidentsToJson(Incident data) => json.encode(data.toJson());

@collection
class Incident {
  Id? isarId;
  final String vehicleId;
  @Index(unique: true, replace: true)
  final String recordId;
  final String circuitNumber;
  final String reportedById;
  final String issueTypeId;
  final String title;
  final String? body;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String address;
  final String sector;
  final String? zone;
  final String longitude;
  final String latitude;
  final String creation;
  final List<String> assignedContactsId;
  final String priorityId;
  final List<String>? labels;
  final String expirationDate;
  final bool isSynchronized;
  final bool isVoid;
  List<Document>? photos;
  List<Document>? documents;
  List<Document>? voiceNotes;

  final vehicle = IsarLink<VehicleData>();
  final typeIncident = IsarLink<TypeIncidentData>();
  final employee = IsarLink<EmployeeData>();
  final assignedEmployees = IsarLinks<EmployeeData>();

  Incident({
    required this.vehicleId,
    required this.recordId,
    required this.circuitNumber,
    required this.reportedById,
    required this.issueTypeId,
    required this.title,
    required this.creation,
    this.body,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.address,
    required this.sector,
    this.zone,
    required this.longitude,
    required this.latitude,
    required this.assignedContactsId,
    required this.priorityId,
    this.labels,
    required this.expirationDate,
    required this.isSynchronized,
    required this.isVoid,
    this.photos,
    this.documents,
    this.voiceNotes,
  });

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        recordId: json["record_id"],
        vehicleId: json["vehicle_id"],
        circuitNumber: json["circuit_number"],
        reportedById: json["reported_by_id"],
        issueTypeId: json["issue_type_id"],
        title: json["title"],
        body: json["body"],
        creation: json["creation"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        address: json["address"],
        sector: json["sector"],
        zone: json["zone"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        assignedContactsId:
            List<String>.from(json["assigned_contacts_id"].map((x) => x)),
        priorityId: json["priority_id"],
        labels: List<String>.from(json["labels"].map((x) => x)),
        expirationDate: json["expiration_date"],
        isSynchronized: json["is_synchronized"],
        isVoid: json["is_void"],
        photos: List<Document>.from(json["photos"].map((x) => x)),
        documents: List<Document>.from(json["documents"].map((x) => x)),
        voiceNotes: List<Document>.from(json["voice_notes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "vehicle_id": vehicleId,
        "circuit_number": circuitNumber,
        "reported_by_id": reportedById,
        "issue_type_id": issueTypeId,
        "title": title,
        "creation": creation,
        "body": body,
        "start_date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
        "address": address,
        "sector": sector,
        "zone": zone,
        "longitude": longitude,
        "latitude": latitude,
        "assigned_contacts_id":
            List<String>.from(assignedContactsId.map((x) => x)),
        "priority_id": priorityId,
        "labels":
            labels == null ? [] : List<String>.from(labels!.map((x) => x)),
        "expiration_date": expirationDate,
        "is_synchronized": isSynchronized,
        "is_void": isVoid,
        "photos":
            photos == null ? [] : List<String>.from(photos!.map((x) => x)),
        "documents": documents == null
            ? []
            : List<String>.from(documents!.map((x) => x)),
        "voice_notes": voiceNotes == null
            ? []
            : List<String>.from(voiceNotes!.map((x) => x)),
      };
}

@embedded
class Document {
  String? recordId;
  String? creation;
  String? name;
  String? url;
  String? module;
  String? documentType;
  String? longitude;
  String? latitude;
  String? userId;

  Document({
    this.recordId,
    this.creation,
    this.name,
    this.url,
    this.module,
    this.documentType,
    this.longitude,
    this.latitude,
    this.userId,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        recordId: json["record_id"],
        creation: json["creation"],
        name: json["name"],
        url: json["url"],
        module: json["module"],
        documentType: json["document_type"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "creation": creation,
        "name": name,
        "url": url,
        "module": module,
        "document_type": documentType,
        "longitude": longitude,
        "latitude": latitude,
        "user_id": userId,
      };
}
