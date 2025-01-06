// To parse this JSON data, do
//
//     final getExcutiveMembersResponseModel = getExcutiveMembersResponseModelFromJson(jsonString);

import 'dart:convert';

GetExcutiveMembersResponseModel getExcutiveMembersResponseModelFromJson(
        String str) =>
    GetExcutiveMembersResponseModel.fromJson(json.decode(str));

String getExcutiveMembersResponseModelToJson(
        GetExcutiveMembersResponseModel data) =>
    json.encode(data.toJson());

class GetExcutiveMembersResponseModel {
  int? count;
  String? next;
  dynamic previous;
  List<ExecutiveMember>? results;

  GetExcutiveMembersResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetExcutiveMembersResponseModel.fromJson(Map<String, dynamic> json) =>
      GetExcutiveMembersResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<ExecutiveMember>.from(
                json["results"]!.map((x) => ExecutiveMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ExecutiveMember {
  int? id;
  String? idno;
  String? name;
  String? phoneNumber;
  String? image;
  String? area;
  String? membershipType;
  String? designation;

  ExecutiveMember({
    this.id,
    this.idno,
    this.name,
    this.phoneNumber,
    this.image,
    this.area,
    this.membershipType,
    this.designation,
  });

  factory ExecutiveMember.fromJson(Map<String, dynamic> json) =>
      ExecutiveMember(
        id: json["id"],
        idno: json["idno"],
        name: json["name"],
        phoneNumber: json["phone_number1"],
        image: json["image"],
        area: json["area"],
        membershipType: json["membership_type"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idno": idno,
        "name": name,
        "phone_number1": phoneNumber,
        "image": image,
        "area": area,
        "membership_type": membershipType,
        "designation": designation,
      };
}
