// To parse this JSON data, do
//
//     final getProductsDetailsResponseModel = getProductsDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetProductsDetailsResponseModel getProductsDetailsResponseModelFromJson(
        String str) =>
    GetProductsDetailsResponseModel.fromJson(json.decode(str));

String getProductsDetailsResponseModelToJson(
        GetProductsDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetProductsDetailsResponseModel {
  int? id;
  String? productImage1;
  dynamic productImage2;
  dynamic productImage3;
  dynamic productImage4;
  dynamic productImage5;
  String? productName;
  String? productDescription;
  int? productPrice;
  DateTime? createdAt;
  bool? availability;

  GetProductsDetailsResponseModel({
    this.id,
    this.productImage1,
    this.productImage2,
    this.productImage3,
    this.productImage4,
    this.productImage5,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.createdAt,
    this.availability,
  });

  factory GetProductsDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetProductsDetailsResponseModel(
        id: json["id"],
        productImage1: json["product_image1"],
        productImage2: json["product_image2"],
        productImage3: json["product_image3"],
        productImage4: json["product_image4"],
        productImage5: json["product_image5"],
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
        "product_image1": productImage1,
        "product_image2": productImage2,
        "product_image3": productImage3,
        "product_image4": productImage4,
        "product_image5": productImage5,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "created_at": createdAt?.toIso8601String(),
        "availability": availability,
      };
}
