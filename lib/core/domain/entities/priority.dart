import 'dart:convert';

List<Priority> priorityFromJson(String str) => List<Priority>.from(json.decode(str).map((x) => Priority.fromJson(x)));

String priorityToJson(List<Priority> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Priority {
    final String id;
    final String description;

    Priority({
        required this.id,
        required this.description,
    });

    factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        id: json["_id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
    };
}
