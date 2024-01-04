import 'dart:convert';

import 'package:isar/isar.dart';

part 'employee.g.dart';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  final List<EmployeeData> data;
  final String message;

  Employee({
    required this.data,
    required this.message,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        data: List<EmployeeData>.from(
            json["data"].map((x) => EmployeeData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

@collection
class EmployeeData {
  Id? isarId;
  @Index(unique: true, replace: true)
  final String id;
  final Area position;
  final Area area;
  final Area pointOfSales;
  final Area employeeType;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Entity entity;

  EmployeeData({
    required this.id,
    required this.position,
    required this.area,
    required this.pointOfSales,
    required this.employeeType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.entity,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        id: json["entity"]["_id"],
        position: Area.fromJson(json["position"]),
        area: Area.fromJson(json["area"]),
        pointOfSales: Area.fromJson(json["point_of_sales"]),
        employeeType: Area.fromJson(json["employee_type"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        entity: Entity.fromJson(json["entity"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position.toJson(),
        "area": area.toJson(),
        "point_of_sales": pointOfSales.toJson(),
        "employee_type": employeeType.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "entity": entity.toJson(),
      };
}

@embedded
class Area {
  String? id;
  String? name;

  Area({
    this.id,
    this.name,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

@embedded
class Entity {
  String? id;
  String? completeName;
  String? firstName;
  String? lastName;
  String? identificationType;
  String? identification;
  String? sex;
  String? nationality;
  String? maritalStatus;
  String? birthDate;
  List<String>? phones;
  List<Address>? addresses;
  List<String>? email;

  Entity({
    this.id,
    this.completeName,
    this.firstName,
    this.lastName,
    this.identificationType,
    this.identification,
    this.sex,
    this.nationality,
    this.maritalStatus,
    this.birthDate,
    this.phones,
    this.addresses,
    this.email,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["_id"],
        completeName: json["complete_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        identificationType: json["identification_type"],
        identification: json["identification"],
        sex: json["sex"],
        nationality: json["nationality"],
        maritalStatus: json["marital_status"],
        birthDate: json["birth_date"],
        phones: List<String>.from(json["phones"].map((x) => x)),
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        email: List<String>.from(json["email"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "complete_name": completeName,
        "first_name": firstName,
        "last_name": lastName,
        "identification_type": identificationType,
        "identification": identification,
        "sex": sex,
        "nationality": nationality,
        "marital_status": maritalStatus,
        "birth_date": birthDate,
        "phones": List<dynamic>.from(phones?.map((x) => x) ?? []),
        "addresses":
            List<dynamic>.from(addresses?.map((x) => x.toJson()) ?? []),
        "email": List<dynamic>.from(email?.map((x) => x) ?? []),
      };
}

@embedded
class Address {
  String? address;
  String? name;
  List<String>? phone;
  String? longitude;
  String? latitude;
  String? references;
  String? comments;

  Address({
    this.address,
    this.name,
    this.phone,
    this.longitude,
    this.latitude,
    this.references,
    this.comments,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        name: json["name"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        longitude: json["longitude"],
        latitude: json["latitude"],
        references: json["references"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
        "phone": List<String>.from(phone?.map((x) => x) ?? []),
        "longitude": longitude,
        "latitude": latitude,
        "references": references,
        "comments": comments,
      };
}
