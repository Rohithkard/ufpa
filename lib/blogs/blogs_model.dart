// To parse this JSON data, do
//
//     final getBlogsResponseModel = getBlogsResponseModelFromJson(jsonString);

import 'dart:convert';

GetBlogsResponseModel getBlogsResponseModelFromJson(String str) =>
    GetBlogsResponseModel.fromJson(json.decode(str));

String getBlogsResponseModelToJson(GetBlogsResponseModel data) =>
    json.encode(data.toJson());

class GetBlogsResponseModel {
  int? count;
  String? next;
  dynamic previous;
  List<Blogs>? results;

  GetBlogsResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetBlogsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBlogsResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Blogs>.from(json["results"]!.map((x) => Blogs.fromJson(x))),
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

class Blogs {
  int? id;
  String? image;
  String? title;
  String? content;
  DateTime? createdAt;

  Blogs({
    this.id,
    this.image,
    this.title,
    this.content,
    this.createdAt,
  });

  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        content: json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
      };
}
