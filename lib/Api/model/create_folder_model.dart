// To parse this JSON data, do
//
//     final createFolderModel = createFolderModelFromJson(jsonString);

import 'dart:convert';

CreateFolderModel createFolderModelFromJson(String str) =>
    CreateFolderModel.fromJson(json.decode(str));

String createFolderModelToJson(CreateFolderModel data) =>
    json.encode(data.toJson());

class CreateFolderModel {
  CreateFolderModel({
    this.success,
    this.description,
    this.data,
  });

  bool? success;
  String? description;
  Data? data;

  factory CreateFolderModel.fromJson(Map<String, dynamic> json) =>
      CreateFolderModel(
        success: json["success"],
        description: json["description"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "description": description,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.user,
    this.folder,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  dynamic name;
  dynamic user;
  dynamic folder;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        user: json["user"],
        folder: json["folder"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user": user,
        "folder": folder,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
