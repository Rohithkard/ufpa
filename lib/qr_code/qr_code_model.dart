// To parse this JSON data, do
//
//     final getUserDetailsResponseModel = getUserDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailsResponseModel getUserDetailsResponseModelFromJson(String str) =>
    GetUserDetailsResponseModel.fromJson(json.decode(str));

String getUserDetailsResponseModelToJson(GetUserDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetUserDetailsResponseModel {
  int? id;
  String? idno;
  String? rcptno;
  String? name;
  String? address1;
  String? address2;
  String? address3;
  int? age;
  String? phoneNumber;
  String? whatsappNumber;
  String? bloodGroup;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? adhar;
  String? relation;
  String? otherOrganisation;
  String? image;
  String? qrCode;
  String? area;

  GetUserDetailsResponseModel({
    this.id,
    this.idno,
    this.rcptno,
    this.name,
    this.address1,
    this.address2,
    this.address3,
    this.age,
    this.phoneNumber,
    this.whatsappNumber,
    this.bloodGroup,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.adhar,
    this.relation,
    this.otherOrganisation,
    this.image,
    this.qrCode,
    this.area,
  });

  factory GetUserDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetUserDetailsResponseModel(
        id: json["id"],
        idno: json["idno"],
        rcptno: json["rcptno"],
        name: json["name"],
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        age: json["age"],
        phoneNumber: json["phone_number1"],
        whatsappNumber: json["whatsapp_number"],
        bloodGroup: json["blood_group"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactNumber: json["emergency_contact_number"],
        adhar: json["adhar"],
        relation: json["relation"],
        otherOrganisation: json["other_organisation"],
        image: json["image"],
        qrCode: json["qr_code"],
        area: json["area"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idno": idno,
        "rcptno": rcptno,
        "name": name,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "age": age,
        "phone_number1": phoneNumber,
        "whatsapp_number": whatsappNumber,
        "blood_group": bloodGroup,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "adhar": adhar,
        "relation": relation,
        "other_organisation": otherOrganisation,
        "image": image,
        "qr_code": qrCode,
        "area": area,
      };
}
