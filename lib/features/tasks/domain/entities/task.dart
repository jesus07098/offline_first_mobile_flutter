import 'package:isar/isar.dart';

// part 'task.g.dart';

class Task {
   Id? isarId;
  final String id;
  final String title;
  final String description;
  final String status;
  final String isSync;
  final String isResync;
  final String latitude;
  final String longitude;
  final String createdBy;
  final DateTime initDate;
  final DateTime endDate;
  final List<String> assignedUsers;
  final String priority;
  final String vehicle;
  final List<FileElement> files;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.isSync,
    required this.isResync,
    required this.latitude,
    required this.longitude,
    required this.createdBy,
    required this.initDate,
    required this.endDate,
    required this.assignedUsers,
    required this.priority,
    required this.vehicle,
    required this.files,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        isSync: json["is_sync"],
        isResync: json["is_resync"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdBy: json["createdBy"],
        initDate: DateTime.parse(json["initDate"]),
        endDate: DateTime.parse(json["endDate"]),
        assignedUsers: List<String>.from(json["assignedUsers"].map((x) => x)),
        priority: json["priority"],
        vehicle: json["vehicle"],
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "is_sync": isSync,
        "is_resync": isResync,
        "latitude": latitude,
        "longitude": longitude,
        "createdBy": createdBy,
        "initDate":
            "${initDate.year.toString().padLeft(4, '0')}-${initDate.month.toString().padLeft(2, '0')}-${initDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "assignedUsers": List<dynamic>.from(assignedUsers.map((x) => x)),
        "priority": priority,
        "vehicle": vehicle,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

@embedded
class FileElement {
  final String? id;
  final String? fileName;
  final String? type;

  FileElement({
     this.id,
     this.fileName,
     this.type,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        fileName: json["fileName"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "type": type,
      };
}
