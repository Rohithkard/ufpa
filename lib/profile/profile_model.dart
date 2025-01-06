// To parse this JSON data, do
//
//     final userDetailsResponseModel = userDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

UserDetailsResponseModel userDetailsResponseModelFromJson(String str) =>
    UserDetailsResponseModel.fromJson(json.decode(str));

String userDetailsResponseModelToJson(UserDetailsResponseModel data) =>
    json.encode(data.toJson());

class UserDetailsResponseModel {
  int? id;
  String? area;
  String? membershipType;
  String? image;
  String? qrCode;
  String? idno;
  String? rcptno;
  String? name;
  String? email;
  String? address1;
  String? address3;
  String? address2;
  String? bloodGroup;
  String? adhar;
  String? phoneNumber2;
  int? age;
  String? phoneNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? relation;
  bool? reportable;
  bool? reviewable;
  bool? editOption;
  String? otherOrganisation;
  DateTime? membershipValidity;

  UserDetailsResponseModel({
    this.id,
    this.area,
    this.membershipType,
    this.image,
    this.qrCode,
    this.idno,
    this.rcptno,
    this.reviewable,
    this.reportable,
    this.name,
    this.email,
    this.address1,
    this.editOption,
    this.address2,
    this.address3,
    this.phoneNumber2,
    this.bloodGroup,
    this.adhar,
    this.age,
    this.phoneNumber,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.relation,
    this.otherOrganisation,
    this.membershipValidity,
  });

  factory UserDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponseModel(
        id: json["id"],
        area: json["area"],
        membershipType: json["membership_type"],
        image: json["image"],
        qrCode: json["qr_code"],
        idno: json["idno"],
        rcptno: json["rcptno"],
        reviewable: json["reviewable"],
        reportable: json["reportable"],
        editOption: json["edit_option"],
        name: json["name"],
        email: json["email"],
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        bloodGroup: json["blood_group"],
        adhar: json["adhar"],
        age: json["age"],
        phoneNumber: json["phone_number1"],
        phoneNumber2: json["phone_number2"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactNumber: json["emergency_contact_number"],
        relation: json["relation"],
        otherOrganisation: json["other_organisation"],
        membershipValidity: json["membership_validity"] == null
            ? null
            : DateTime.parse(json["membership_validity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "membership_type": membershipType,
        "image": image,
        "qr_code": qrCode,
        "idno": idno,
        "rcptno": rcptno,
        "name": name,
        "email": email,
        "edit_option": editOption,
        "reportable": reportable,
        "reviewable": reviewable,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "blood_group": bloodGroup,
        "adhar": adhar,
        "age": age,
        "phone_number2": phoneNumber2,
        "phone_number1": phoneNumber,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "relation": relation,
        "other_organisation": otherOrganisation,
        "membership_validity":
            "${membershipValidity!.year.toString().padLeft(4, '0')}-${membershipValidity!.month.toString().padLeft(2, '0')}-${membershipValidity!.day.toString().padLeft(2, '0')}",
      };
}
