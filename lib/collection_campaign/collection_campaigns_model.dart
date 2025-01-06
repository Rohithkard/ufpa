// To parse this JSON data, do
//
//     final getCampaignResponseModel = getCampaignResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

List<GetCampaignResponseModel> getCampaignResponseModelFromJson(String str) =>
    List<GetCampaignResponseModel>.from(
        json.decode(str).map((x) => GetCampaignResponseModel.fromJson(x)));

String getCampaignResponseModelToJson(List<GetCampaignResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCampaignResponseModel {
  int? id;
  String? image;
  Rx<bool?> isPaid;
  String? campaignName;
  String? amount;
  DateTime? dueDate;

  GetCampaignResponseModel({
    this.id,
    this.image,
    this.campaignName,
    this.amount,
    required this.isPaid,
    this.dueDate,
  });

  factory GetCampaignResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCampaignResponseModel(
        id: json["id"],
        image: json["image"],
        campaignName: json["campaign_name"],
        amount: json["amount"],
        isPaid: Rx(json["isPaid"] ?? false),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "campaign_name": campaignName,
        "isPaid": isPaid,
        "amount": amount,
        "due_date": dueDate?.toIso8601String(),
      };
}
