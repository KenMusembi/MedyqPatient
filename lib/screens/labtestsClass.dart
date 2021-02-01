// To parse this JSON data, do
//
//     final labTestsClass = labTestsClassFromJson(jsonString);

import 'dart:convert';

List<LabTestsClass> labTestsClassFromJson(String str) => List<LabTestsClass>.from(json.decode(str).map((x) => LabTestsClass.fromJson(x)));

String labTestsClassToJson(List<LabTestsClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LabTestsClass {
    LabTestsClass({
        this.id,
        this.uuid,
        this.labTestId,
        this.visitId,
        this.notes,
        this.completed,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.restoredBy,
        this.restoredAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name,
        this.status,
        this.test,
        this.result,
    });

    int id;
    String uuid;
    int labTestId;
    int visitId;
    dynamic notes;
    bool completed;
    int createdBy;
    int updatedBy;
    dynamic deletedBy;
    dynamic restoredBy;
    dynamic restoredAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String name;
    int status;
    String test;
    dynamic result;

    factory LabTestsClass.fromJson(Map<String, dynamic> json) => LabTestsClass(
        id: json["id"],
        uuid: json["uuid"],
        labTestId: json["lab_test_id"],
        visitId: json["visit_id"],
        notes: json["notes"],
        completed: json["completed"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        restoredBy: json["restored_by"],
        restoredAt: json["restored_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        name: json["name"],
        status: json["status"],
        test: json["test"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "lab_test_id": labTestId,
        "visit_id": visitId,
        "notes": notes,
        "completed": completed,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "restored_by": restoredBy,
        "restored_at": restoredAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "name": name,
        "status": status,
        "test": test,
        "result": result,
    };
}
