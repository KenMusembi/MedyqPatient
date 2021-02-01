// To parse this JSON data, do
//
//     final prescriptionsClass = prescriptionsClassFromJson(jsonString);

import 'dart:convert';

List<PrescriptionsClass> prescriptionsClassFromJson(String str) =>
    List<PrescriptionsClass>.from(
        json.decode(str).map((x) => PrescriptionsClass.fromJson(x)));

String prescriptionsClassToJson(List<PrescriptionsClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrescriptionsClass {
  PrescriptionsClass({
    this.id,
    this.uuid,
    this.visitId,
    this.productId,
    this.quantity,
    this.dosage,
    this.dosageUomId,
    this.frequency,
    this.duration,
    this.dosageInstructions,
    this.mealInstructions,
    this.notes,
    this.dispensed,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.restoredBy,
    this.restoredAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.genericName,
    this.brandName,
    this.code,
    this.categoryId,
    this.description,
    this.sideEffects,
    this.status,
    this.unit,
    this.symbol,
  });

  int id;
  String uuid;
  int visitId;
  int productId;
  int quantity;
  int dosage;
  int dosageUomId;
  int frequency;
  String duration;
  dynamic dosageInstructions;
  dynamic mealInstructions;
  dynamic notes;
  bool dispensed;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic restoredBy;
  dynamic restoredAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String genericName;
  String brandName;
  String code;
  int categoryId;
  String description;
  dynamic sideEffects;
  String status;
  String unit;
  String symbol;

  factory PrescriptionsClass.fromJson(Map<String, dynamic> json) =>
      PrescriptionsClass(
        id: json["id"],
        uuid: json["uuid"],
        visitId: json["visit_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        dosage: json["dosage"],
        dosageUomId: json["dosage_uom_id"],
        frequency: json["frequency"],
        duration: json["duration"],
        dosageInstructions: json["dosage_instructions"],
        mealInstructions: json["meal_instructions"],
        notes: json["notes"],
        dispensed: json["dispensed"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        restoredBy: json["restored_by"],
        restoredAt: json["restored_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        genericName: json["generic_name"],
        brandName: json["brand_name"],
        code: json["code"],
        categoryId: json["category_id"],
        description: json["description"],
        sideEffects: json["side_effects"],
        status: json["status"],
        unit: json["unit"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "visit_id": visitId,
        "product_id": productId,
        "quantity": quantity,
        "dosage": dosage,
        "dosage_uom_id": dosageUomId,
        "frequency": frequency,
        "duration": duration,
        "dosage_instructions": dosageInstructions,
        "meal_instructions": mealInstructions,
        "notes": notes,
        "dispensed": dispensed,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "restored_by": restoredBy,
        "restored_at": restoredAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "generic_name": genericName,
        "brand_name": brandName,
        "code": code,
        "category_id": categoryId,
        "description": description,
        "side_effects": sideEffects,
        "status": status,
        "unit": unit,
        "symbol": symbol,
      };
}
