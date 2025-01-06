// To parse this JSON data, do
//
//     final searchUsersResponseModel = searchUsersResponseModelFromJson(jsonString);

import 'dart:convert';

List<SearchUsersResponseModel> searchUsersResponseModelFromJson(String str) =>
    List<SearchUsersResponseModel>.from(
        json.decode(str).map((x) => SearchUsersResponseModel.fromJson(x)));

String searchUsersResponseModelToJson(List<SearchUsersResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUsersResponseModel {
  String? name;
  String? phoneNumber;
  String? image;
  String? idno;
  int? id;

  SearchUsersResponseModel({
    this.name,
    this.phoneNumber,
    this.image,
    this.idno,
    this.id,
  });

  factory SearchUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchUsersResponseModel(
        name: json["name"],
        phoneNumber: json["phone_number1"],
        image: json["image"],
        idno: json["idno"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number1": phoneNumber,
        "image": image,
        "idno": idno,
        "id": id,
      };
}

// To parse this JSON data, do
//
//     final reportGenrationResponseModel = reportGenrationResponseModelFromJson(jsonString);

ReportGenrationResponseModel reportGenrationResponseModelFromJson(String str) =>
    ReportGenrationResponseModel.fromJson(json.decode(str));

String reportGenrationResponseModelToJson(ReportGenrationResponseModel data) =>
    json.encode(data.toJson());

class ReportGenrationResponseModel {
  int? id;
  int? member;
  String? report;
  DateTime? createdAt;

  ReportGenrationResponseModel({
    this.id,
    this.member,
    this.report,
    this.createdAt,
  });

  factory ReportGenrationResponseModel.fromJson(Map<String, dynamic> json) =>
      ReportGenrationResponseModel(
        id: json["id"],
        member: json["member"],
        report: json["report"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member": member,
        "report": report,
        "created_at": createdAt?.toIso8601String(),
      };
}
