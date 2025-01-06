// To parse this JSON data, do
//
//     final getEventsResponseModel = getEventsResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetEventsResponseModel> getEventsResponseModelFromJson(String str) =>
    List<GetEventsResponseModel>.from(
        json.decode(str).map((x) => GetEventsResponseModel.fromJson(x)));

String getEventsResponseModelToJson(List<GetEventsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventsResponseModel {
  int? id;
  String? event;
  String? venue;
  String? eventImage;
  DateTime? date;
  DateTime? endDate;
  List<int>? authorizedMembers;

  GetEventsResponseModel({
    this.id,
    this.event,
    this.venue,
    this.eventImage,
    this.date,
    this.endDate,
    this.authorizedMembers,
  });

  factory GetEventsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetEventsResponseModel(
        id: json["id"],
        event: json["event"],
        venue: json["venue"],
        eventImage: json["event_image"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        authorizedMembers: json["authorized_members"] == null
            ? []
            : List<int>.from(json["authorized_members"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event": event,
        "venue": venue,
        "event_image": eventImage,
        "date": date?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "authorized_members": authorizedMembers == null
            ? []
            : List<dynamic>.from(authorizedMembers!.map((x) => x)),
      };
}
