// To parse this JSON data, do
//
//     final invoiceClass = invoiceClassFromJson(jsonString);

import 'dart:convert';

List<InvoiceClass> invoiceClassFromJson(String str) => List<InvoiceClass>.from(
    json.decode(str).map((x) => InvoiceClass.fromJson(x)));

String invoiceClassToJson(List<InvoiceClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceClass {
  InvoiceClass({
    this.id,
    this.name,
    this.quantity,
    this.totalAmount,
    this.amountPaid,
    this.balance,
    this.change,
    this.datePaid,
    this.dispensed,
    this.dateDispensed,
    this.discountAmount,
    this.coalesce,
  });

  int id;
  String name;
  String quantity;
  String totalAmount;
  String amountPaid;
  String balance;
  String change;
  dynamic datePaid;
  bool dispensed;
  dynamic dateDispensed;
  String discountAmount;
  String coalesce;

  factory InvoiceClass.fromJson(Map<String, dynamic> json) => InvoiceClass(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        totalAmount: json["total_amount"],
        amountPaid: json["amount_paid"],
        balance: json["balance"],
        change: json["change"],
        datePaid: json["date_paid"],
        dispensed: json["dispensed"],
        dateDispensed: json["date_dispensed"],
        discountAmount: json["discount_amount"],
        coalesce: json["coalesce"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "total_amount": totalAmount,
        "amount_paid": amountPaid,
        "balance": balance,
        "change": change,
        "date_paid": datePaid,
        "dispensed": dispensed,
        "date_dispensed": dateDispensed,
        "discount_amount": discountAmount,
        "coalesce": coalesce,
      };
}
