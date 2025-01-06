import 'dart:convert';

import '../events/event_model.dart';
import '../profile/profile_model.dart';

class ArgumentModelForRecordEntry {
  UserDetailsResponseModel? user;
  GetEventsResponseModel? events;
  ArgumentModelForRecordEntry({
    required this.user,
    required this.events,
  });
}

// To parse this JSON data, do
//
//     final getEventUserCountResponseModel = getEventUserCountResponseModelFromJson(jsonString);

GetEventUserCountResponseModel getEventUserCountResponseModelFromJson(
        String str) =>
    GetEventUserCountResponseModel.fromJson(json.decode(str));

String getEventUserCountResponseModelToJson(
        GetEventUserCountResponseModel data) =>
    json.encode(data.toJson());

class GetEventUserCountResponseModel {
  int? id;
  int? userId;
  int? eventId;
  int? adultCount;
  int? childCount;
  int? allottedPassCount;

  GetEventUserCountResponseModel({
    this.id,
    this.userId,
    this.eventId,
    this.adultCount,
    this.childCount,
    this.allottedPassCount,
  });

  factory GetEventUserCountResponseModel.fromJson(Map<String, dynamic> json) =>
      GetEventUserCountResponseModel(
        id: json["id"],
        userId: json["user_id"],
        eventId: json["event_id"],
        adultCount: json["adult_count"],
        childCount: json["child_count"],
        allottedPassCount: json["allotted_pass_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "event_id": eventId,
        "adult_count": adultCount,
        "child_count": childCount,
        "allotted_pass_count": allottedPassCount,
      };
}
