// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? id;
  String? emailorphonenumber;
  String? firstName;
  String? lastName;
  String? password;
  int? v;

  LoginModel({
    this.id,
    this.emailorphonenumber,
    this.firstName,
    this.lastName,
    this.password,
    this.v,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["_id"],
    emailorphonenumber: json["emailorphonenumber"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "emailorphonenumber": emailorphonenumber,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "__v": v,
  };
}
