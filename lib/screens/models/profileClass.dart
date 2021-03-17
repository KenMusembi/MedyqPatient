// To parse this JSON data, do
//
//     final profileClass = profileClassFromJson(jsonString);

import 'dart:convert';

ProfileClass profileClassFromJson(String str) =>
    ProfileClass.fromJson(json.decode(str));

String profileClassToJson(ProfileClass data) => json.encode(data.toJson());

class ProfileClass {
  ProfileClass({
    this.id,
    this.uuid,
    this.number,
    this.dob,
    this.phoneNumber,
    this.email,
  });

  int id;
  String uuid;
  String number;
  dynamic dob;
  String phoneNumber;
  String email;

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
        id: json["id"],
        uuid: json["uuid"],
        number: json["number"],
        dob: json["dob"],
        phoneNumber: json["phone_number"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "number": number,
        "dob": dob,
        "phone_number": phoneNumber,
        "email": email,
      };
}
