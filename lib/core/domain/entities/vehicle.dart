import 'dart:convert';

import 'package:isar/isar.dart';

part 'vehicle.g.dart';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  final List<VehicleData> data;
  final String message;

  Vehicle({
    required this.data,
    required this.message,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        data: List<VehicleData>.from(
            json["data"].map((x) => VehicleData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

@collection
class VehicleData {
  Id? isarId;
  @Index(unique: true, replace: true)
  final String id;
  final String name;
  final String vin;
  final String licensePlate;
  final int year;
  final String fleetNumber;
  final Brand vehicleType;
  final Brand vehicleBrand;
  final Brand vehicleModel;
  final bool status;

  VehicleData({
    required this.id,
    required this.name,
    required this.vin,
    required this.licensePlate,
    required this.year,
    required this.fleetNumber,
    required this.vehicleType,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.status,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
        id: json["_id"],
        name: json["name"],
        vin: json["vin"],
        licensePlate: json["license_plate"],
        year: json["year"],
        fleetNumber: json["fleet_number"],
        vehicleType: Brand.fromJson(json["vehicle_type"]),
        vehicleBrand: Brand.fromJson(json["vehicle_brand"]),
        vehicleModel: Brand.fromJson(json["vehicle_model"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "vin": vin,
        "license_plate": licensePlate,
        "year": year,
        "fleet_number": fleetNumber,
        "vehicle_type": vehicleType.toJson(),
        "vehicle_brand": vehicleBrand.toJson(),
        "vehicle_model": vehicleModel.toJson(),
        "status": status,
      };
}

@embedded
class Brand {
  String? id;
  String? name;

  Brand({
    this.id,
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

