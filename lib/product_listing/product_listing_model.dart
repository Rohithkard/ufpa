// To parse this JSON data, do
//
//     final getProductsResponseModel = getProductsResponseModelFromJson(jsonString);

import 'dart:convert';

GetProductsResponseModel getProductsResponseModelFromJson(String str) =>
    GetProductsResponseModel.fromJson(json.decode(str));

String getProductsResponseModelToJson(GetProductsResponseModel data) =>
    json.encode(data.toJson());

class GetProductsResponseModel {
  int? count;
  String? next;
  dynamic previous;
  List<Product>? results;

  GetProductsResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GetProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetProductsResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Product>.from(
                json["results"]!.map((x) => Product.fromJson(x))),
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

class Product {
  int? id;
  String? productImage;
  String? productName;
  String? productDescription;
  int? productPrice;
  DateTime? createdAt;
  bool? availability;

  Product({
    this.id,
    this.productImage,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.createdAt,
    this.availability,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productImage: json["product_image1"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productPrice: json["product_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_image": productImage,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "created_at": createdAt?.toIso8601String(),
        "availability": availability,
      };
}
