// To parse this JSON data, do
//
//     final sortFolderModel = sortFolderModelFromJson(jsonString);

import 'dart:convert';

SortFolderModel sortFolderModelFromJson(String str) =>
    SortFolderModel.fromJson(json.decode(str));

String sortFolderModelToJson(SortFolderModel data) =>
    json.encode(data.toJson());

class SortFolderModel {
  SortFolderModel({
    this.success,
    this.description,
    this.data,
  });

  bool? success;
  String? description;
  List<Datum>? data;

  factory SortFolderModel.fromJson(Map<String, dynamic> json) =>
      SortFolderModel(
        success: json["success"],
        description: json["description"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "description": description,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.user,
    this.folder,
    this.name,
    this.type,
    this.size,
    this.lat,
    this.long,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? user;
  Folder? folder;
  String? name;
  String? type;
  dynamic? size;
  dynamic? lat;
  dynamic? long;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user: json["user"],
        folder: Folder.fromJson(json["folder"]),
        name: json["name"],
        type: json["type"],
        size: json["size"],
        lat: json["lat"],
        long: json["long"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "folder": folder!.toJson(),
        "name": name,
        "type": type,
        "size": size,
        "lat": lat,
        "long": long,
        "comment": comment,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Folder {
  Folder({
    this.id,
    this.user,
    this.folder,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? user;
  dynamic folder;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        id: json["id"],
        user: json["user"],
        folder: json["folder"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "folder": folder,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
