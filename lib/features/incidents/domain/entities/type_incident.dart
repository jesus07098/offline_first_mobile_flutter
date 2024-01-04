import 'dart:convert';

import 'package:isar/isar.dart';

part "type_incident.g.dart";

TypeIncident typeIncidentFromJson(String str) =>
    TypeIncident.fromJson(json.decode(str));

String typeIncidentToJson(TypeIncident data) => json.encode(data.toJson());

class TypeIncident {
  final List<TypeIncidentData> data;
  final String message;

  TypeIncident({
    required this.data,
    required this.message,
  });

  factory TypeIncident.fromJson(Map<String, dynamic> json) => TypeIncident(
        data: List<TypeIncidentData>.from(
            json["data"].map((x) => TypeIncidentData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

@collection
class TypeIncidentData {
  Id? isarId;
  @Index(replace: true, unique: true)
  final String id;
  final String name;

  TypeIncidentData({
    required this.id,
    required this.name,
  });

  factory TypeIncidentData.fromJson(Map<String, dynamic> json) =>
      TypeIncidentData(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
