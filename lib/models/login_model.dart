// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Status? success;

  LoginModel({
    this.success,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"] == null ? null : Status.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success?.toJson(),
  };
}

class Status {
  String? token;

  Status({
    this.token,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
