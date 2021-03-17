// To parse this JSON data, do
//
//     final allergiesClass = allergiesClassFromJson(jsonString);

import 'dart:convert';

List<AllergiesClass> allergiesClassFromJson(String str) =>
    List<AllergiesClass>.from(
        json.decode(str).map((x) => AllergiesClass.fromJson(x)));

String allergiesClassToJson(List<AllergiesClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllergiesClass {
  AllergiesClass({
    this.id,
    this.uuid,
    this.patientId,
    this.allergyId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.restoredBy,
    this.restoredAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String uuid;
  int patientId;
  int allergyId;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  dynamic restoredBy;
  dynamic restoredAt;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  factory AllergiesClass.fromJson(Map<String, dynamic> json) => AllergiesClass(
        id: json["id"],
        uuid: json["uuid"],
        patientId: json["patient_id"],
        allergyId: json["allergy_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        restoredBy: json["restored_by"],
        restoredAt: json["restored_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "patient_id": patientId,
        "allergy_id": allergyId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "restored_by": restoredBy,
        "restored_at": restoredAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt == null ? null : deletedAt.toIso8601String(),
      };
}
