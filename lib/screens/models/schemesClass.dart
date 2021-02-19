// To parse this JSON data, do
//
//     final schemesClass = schemesClassFromJson(jsonString);

import 'dart:convert';

List<SchemesClass> schemesClassFromJson(String str) => List<SchemesClass>.from(
    json.decode(str).map((x) => SchemesClass.fromJson(x)));

String schemesClassToJson(List<SchemesClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchemesClass {
  SchemesClass({
    this.id,
    this.uuid,
    this.patientId,
    this.schemeId,
    this.memberNumber,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.restoredBy,
    this.restoredAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.creditLimit,
    this.status,
  });

  int id;
  String uuid;
  int patientId;
  int schemeId;
  String memberNumber;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic restoredBy;
  dynamic restoredAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String creditLimit;
  int status;

  factory SchemesClass.fromJson(Map<String, dynamic> json) => SchemesClass(
        id: json["id"],
        uuid: json["uuid"],
        patientId: json["patient_id"],
        schemeId: json["scheme_id"],
        memberNumber: json["member_number"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        restoredBy: json["restored_by"],
        restoredAt: json["restored_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        name: json["name"],
        creditLimit: json["credit_limit"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "patient_id": patientId,
        "scheme_id": schemeId,
        "member_number": memberNumber,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "restored_by": restoredBy,
        "restored_at": restoredAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "name": name,
        "credit_limit": creditLimit,
        "status": status,
      };
}
