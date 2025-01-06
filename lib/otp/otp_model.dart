// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) =>
    json.encode(data.toJson());

class OtpResponseModel {
  String? message;
  String? token;
  Member? member;

  OtpResponseModel({
    this.message,
    this.token,
    this.member,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
        message: json["message"],
        token: json["token"],
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "member": member?.toJson(),
      };
}

class Member {
  int? id;
  String? area;
  String? membershipType;
  dynamic image;
  dynamic qrCode;
  String? idno;
  String? rcptno;
  String? name;
  String? email;
  String? address;
  String? bloodGroup;
  String? adhar;
  int? age;
  String? phoneNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? relation;
  String? otherOrganisation;
  DateTime? membershipValidity;
  bool? reportable;
  bool? reviewable;
  bool? editOption;

  Member({
    this.id,
    this.area,
    this.membershipType,
    this.image,
    this.qrCode,
    this.idno,
    this.rcptno,
    this.name,
    this.email,
    this.address,
    this.bloodGroup,
    this.adhar,
    this.age,
    this.phoneNumber,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.relation,
    this.otherOrganisation,
    this.reviewable,
    this.reportable,
    this.editOption,
    this.membershipValidity,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        area: json["area"],
        membershipType: json["membership_type"],
        image: json["image"],
        reviewable: json["reviewable"],
        reportable: json["reportable"],
        editOption: json["edit_option"],
        qrCode: json["qr_code"],
        idno: json["idno"],
        rcptno: json["rcptno"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        bloodGroup: json["blood_group"],
        adhar: json["adhar"],
        age: json["age"],
        phoneNumber: json["phone_number1"],
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
        "address": address,
        "blood_group": bloodGroup,
        "edit_option": editOption,
        "reportable": reportable,
        "reviewable": reviewable,
        "adhar": adhar,
        "age": age,
        "phone_number1": phoneNumber,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "relation": relation,
        "other_organisation": otherOrganisation,
        "membership_validity":
            "${membershipValidity!.year.toString().padLeft(4, '0')}-${membershipValidity!.month.toString().padLeft(2, '0')}-${membershipValidity!.day.toString().padLeft(2, '0')}",
      };
}
