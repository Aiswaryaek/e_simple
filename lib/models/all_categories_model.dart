// To parse this JSON data, do
//
//     final allCategoriesModel = allCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<AllCategoriesModel> allCategoriesModelFromJson(String str) => List<AllCategoriesModel>.from(json.decode(str).map((x) => AllCategoriesModel.fromJson(x)));

String allCategoriesModelToJson(List<AllCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCategoriesModel {
  AllCategoriesModel({
    this.id,
    this.name,
    this.migrationId,
    this.level,
    this.pid,
    this.desc,
    this.icon,
    this.image,
    this.index,
    this.slug,
    this.showable,
    this.enabled,
    this.status,
    this.deleted,
    this.prefSup1,
    this.prefSup2,
    this.prefSup3,
    this.created,
    this.modified,
    this.createdBy,
    this.modifiedBy,
    this.pcount,
  });

  String ? id;
  String ? name;
  String ? migrationId;
  int ? level;
  String ? pid;
  String ? desc;
  dynamic icon;
  String ? image;
  int ? index;
  String ? slug;
  bool ? showable;
  bool ? enabled;
  String ? status;
  bool ? deleted;
  String ? prefSup1;
  String ? prefSup2;
  String ? prefSup3;
  String ? created;
  String ? modified;
  String ? createdBy;
  String ? modifiedBy;
  int ? pcount;

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) => AllCategoriesModel(
    id: json["id"],
    name: json["name"],
    migrationId: json["migrationId"],
    level: json["level"],
    pid: json["pid"],
    desc: json["desc"],
    icon: json["icon"],
    image: json["image"],
    index: json["index"],
    slug: json["slug"],
    showable: json["showable"],
    enabled: json["enabled"],
    status: json["status"],
    deleted: json["deleted"],
    prefSup1: json["prefSup1"],
    prefSup2: json["prefSup2"],
    prefSup3: json["prefSup3"],
    created: json["created"],
    modified: json["modified"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    pcount: json["pcount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "migrationId": migrationId,
    "level": level,
    "pid": pid,
    "desc": desc,
    "icon": icon,
    "image": image,
    "index": index,
    "slug": slug,
    "showable": showable,
    "enabled": enabled,
    "status": status,
    "deleted": deleted,
    "prefSup1": prefSup1,
    "prefSup2": prefSup2,
    "prefSup3": prefSup3,
    "created": created,
    "modified": modified,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "pcount": pcount,
  };
}
