// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  String? message;
  String? otp;
  String? error;

  LoginResponseModel({
    this.message,
    this.otp,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        otp: json["otp"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "otp": otp,
        "error": error,
      };
}
