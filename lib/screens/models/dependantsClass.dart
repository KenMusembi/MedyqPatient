// To parse this JSON data, do
//
//     final dependantsClass = dependantsClassFromJson(jsonString);

import 'dart:convert';

List<DependantsClass> dependantsClassFromJson(String str) =>
    List<DependantsClass>.from(
        json.decode(str).map((x) => DependantsClass.fromJson(x)));

String dependantsClassToJson(List<DependantsClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DependantsClass {
  DependantsClass({
    this.id,
    this.uuid,
    this.patientId,
    this.dependantId,
    this.relationshipId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.restoredBy,
    this.restoredAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.number,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.residence,
    this.idType,
    this.idNumber,
    this.dob,
    this.status,
    this.salutationId,
    this.maritalStatusId,
    this.genderId,
    this.patientSearch,
    this.title,
  });

  int id;
  String uuid;
  int patientId;
  int dependantId;
  int relationshipId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic restoredBy;
  dynamic restoredAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String number;
  String firstName;
  dynamic middleName;
  String lastName;
  String email;
  String phoneNumber;
  String residence;
  dynamic idType;
  String idNumber;
  DateTime dob;
  int status;
  int salutationId;
  int maritalStatusId;
  int genderId;
  String patientSearch;
  String title;

  factory DependantsClass.fromJson(Map<String, dynamic> json) =>
      DependantsClass(
        id: json["id"],
        uuid: json["uuid"],
        patientId: json["patient_id"],
        dependantId: json["dependant_id"],
        relationshipId: json["relationship_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        restoredBy: json["restored_by"],
        restoredAt: json["restored_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        number: json["number"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        residence: json["residence"],
        idType: json["id_type"],
        idNumber: json["id_number"],
        dob: DateTime.parse(json["dob"]),
        status: json["status"],
        salutationId: json["salutation_id"],
        maritalStatusId: json["marital_status_id"],
        genderId: json["gender_id"],
        patientSearch: json["patient_search"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "patient_id": patientId,
        "dependant_id": dependantId,
        "relationship_id": relationshipId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "restored_by": restoredBy,
        "restored_at": restoredAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "number": number,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "residence": residence,
        "id_type": idType,
        "id_number": idNumber,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "status": status,
        "salutation_id": salutationId,
        "marital_status_id": maritalStatusId,
        "gender_id": genderId,
        "patient_search": patientSearch,
        "title": title,
      };
}
