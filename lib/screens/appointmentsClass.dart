// To parse this JSON data, do
//
//     final appointmentsClass = appointmentsClassFromJson(jsonString);

import 'dart:convert';

List<AppointmentsClass> appointmentsClassFromJson(String str) => List<AppointmentsClass>.from(json.decode(str).map((x) => AppointmentsClass.fromJson(x)));

String appointmentsClassToJson(List<AppointmentsClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentsClass {
    AppointmentsClass({
        this.description,
        this.startTime,
        this.endTime,
        this.status,
        this.name,
        this.createdAt,
    });

    String description;
    String startTime;
    String endTime;
    int status;
    String name;
    DateTime createdAt;

    factory AppointmentsClass.fromJson(Map<String, dynamic> json) => AppointmentsClass(
        description: json["description"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        status: json["status"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "start_time": startTime,
        "end_time": endTime,
        "status": status,
        "name": name,
        "created_at": createdAt.toIso8601String(),
    };
}
