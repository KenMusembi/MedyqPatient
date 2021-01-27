// To parse this JSON data, do
//
//     final visitsClass = visitsClassFromJson(jsonString);

import 'dart:convert';

VisitsClass visitsClassFromJson(String str) => VisitsClass.fromJson(json.decode(str));

String visitsClassToJson(VisitsClass data) => json.encode(data.toJson());

class VisitsClass {
    VisitsClass({
        this.facilityVisits,
        this.token,
    });

    List<dynamic> facilityVisits;
    String token;

    factory VisitsClass.fromJson(Map<String, dynamic> json) => VisitsClass(
        facilityVisits: List<dynamic>.from(json["facility_visits"].map((x) => x)),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "facility_visits": List<dynamic>.from(facilityVisits.map((x) => x)),
        "token": token,
    };
}

class FacilityVisitClass {
    FacilityVisitClass({
        this.name,
        this.number,
        this.createdAt,
    });

    String name;
    String number;
    DateTime createdAt;

    factory FacilityVisitClass.fromJson(Map<String, dynamic> json) => FacilityVisitClass(
        name: json["name"],
        number: json["number"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "created_at": createdAt.toIso8601String(),
    };
}
