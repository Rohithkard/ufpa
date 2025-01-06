// To parse this JSON data, do
//
//     final membershipResponseModel = membershipResponseModelFromJson(jsonString);

import 'dart:convert';

MembershipResponseModel membershipResponseModelFromJson(String str) =>
    MembershipResponseModel.fromJson(json.decode(str));

String membershipResponseModelToJson(MembershipResponseModel data) =>
    json.encode(data.toJson());

class MembershipResponseModel {
  int? count;
  int? totalCount;
  String? next;
  String? previous;
  List<Users>? results;

  MembershipResponseModel({
    this.count,
    this.totalCount,
    this.next,
    this.previous,
    this.results,
  });

  factory MembershipResponseModel.fromJson(Map<String, dynamic> json) =>
      MembershipResponseModel(
        count: json["count"],
        totalCount: json["total_count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Users>.from(json["results"]!.map((x) => Users.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "total_count": totalCount,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Users {
  int? id;
  String? area;
  String? membershipType;
  String? image;
  String? qrCode;
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
  bool? reportable;
  bool? reviewable;
  String? otherOrganisation;
  DateTime? membershipValidity;

  Users.Users({
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
    this.reviewable,
    this.reportable,
    this.age,
    this.phoneNumber,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.relation,
    this.otherOrganisation,
    this.membershipValidity,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users.Users(
        id: json["id"],
        area: json["area"],
        membershipType: json["membership_type"],
        image: json["image"],
        qrCode: json["qr_code"],
        idno: json["idno"],
        rcptno: json["rcptno"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        bloodGroup: json["blood_group"],
        adhar: json["adhar"],
        reviewable: json["reviewable"],
        reportable: json["reportable"],
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
        "adhar": adhar,
        "age": age,
        "phone_number1": phoneNumber,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "relation": relation,
        "reportable": reportable,
        "reviewable": reviewable,
        "r": reportable,
        "other_organisation": otherOrganisation,
        "membership_validity":
            "${membershipValidity!.year.toString().padLeft(4, '0')}-${membershipValidity!.month.toString().padLeft(2, '0')}-${membershipValidity!.day.toString().padLeft(2, '0')}",
      };
}
