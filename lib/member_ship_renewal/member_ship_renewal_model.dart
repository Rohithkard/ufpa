// To parse this JSON data, do
//
//     final getRenewalDetailsResponseModel = getRenewalDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetRenewalDetailsResponseModel getRenewalDetailsResponseModelFromJson(
        String str) =>
    GetRenewalDetailsResponseModel.fromJson(json.decode(str));

String getRenewalDetailsResponseModelToJson(
        GetRenewalDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetRenewalDetailsResponseModel {
  int? id;
  DateTime? membershipValidity;
  int? days;
  int? amount;

  GetRenewalDetailsResponseModel({
    this.id,
    this.membershipValidity,
    this.days,
    this.amount,
  });

  factory GetRenewalDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetRenewalDetailsResponseModel(
        id: json["id"],
        membershipValidity: json["membership_validity"] == null
            ? null
            : DateTime.parse(json["membership_validity"]),
        days: json["days"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "membership_validity":
            "${membershipValidity!.year.toString().padLeft(4, '0')}-${membershipValidity!.month.toString().padLeft(2, '0')}-${membershipValidity!.day.toString().padLeft(2, '0')}",
        "days": days,
        "amount": amount,
      };
}

class ArgumentModelForRenewalDetails {
  DateTime? validityDate;
  String? userName;
  String? area;
  int? amount;
  ArgumentModelForRenewalDetails({
    required this.amount,
    required this.validityDate,
    required this.userName,
    required this.area,
  });
}
