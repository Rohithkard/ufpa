// To parse this JSON data, do
//
//     final sendReviewResponseModel = sendReviewResponseModelFromJson(jsonString);

import 'dart:convert';

SendReviewResponseModel sendReviewResponseModelFromJson(String str) =>
    SendReviewResponseModel.fromJson(json.decode(str));

String sendReviewResponseModelToJson(SendReviewResponseModel data) =>
    json.encode(data.toJson());

class SendReviewResponseModel {
  int? id;
  int? member;
  String? review;
  DateTime? createdAt;

  SendReviewResponseModel({
    this.id,
    this.member,
    this.review,
    this.createdAt,
  });

  factory SendReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      SendReviewResponseModel(
        id: json["id"],
        member: json["member"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member": member,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
      };
}
