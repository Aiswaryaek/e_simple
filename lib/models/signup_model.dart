// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  String? emailorphonenumber;
  String? firstName;
  String? lastName;
  String? id;
  String? password;
  int? v;

  SignUpModel({
    this.emailorphonenumber,
    this.firstName,
    this.lastName,
    this.id,
    this.password,
    this.v,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    emailorphonenumber: json["emailorphonenumber"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    id: json["_id"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "emailorphonenumber": emailorphonenumber,
    "firstName": firstName,
    "lastName": lastName,
    "_id": id,
    "password": password,
    "__v": v,
  };
}
