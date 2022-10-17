// To parse this JSON data, do
//
//     final fetchImageModel = fetchImageModelFromJson(jsonString);

import 'dart:convert';

FetchImageModel fetchImageModelFromJson(String str) =>
    FetchImageModel.fromJson(json.decode(str));

String fetchImageModelToJson(FetchImageModel data) =>
    json.encode(data.toJson());

class FetchImageModel {
  FetchImageModel({
    this.success,
    this.description,
    this.data,
  });

  bool? success;
  String? description;
  List<Datum>? data;

  factory FetchImageModel.fromJson(Map<String, dynamic> json) =>
      FetchImageModel(
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
  Type? type;
  dynamic? size;
  dynamic? lat;
  dynamic? long;
  String? comment;
  String? createdAt;
  String? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user: json["user"],
        folder: json["folder"] == null ? null : Folder.fromJson(json["folder"]),
        name: json["name"],
        type: typeValues.map[json["type"]],
        size: json["size"].toDouble(),
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        comment: json["comment"] == null ? null : json["comment"],
        createdAt: (json["created_at"]),
        updatedAt: (json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "folder": folder == null ? null : folder!.toJson(),
        "name": name,
        "type": typeValues.reverse[type],
        "size": size,
        "lat": lat,
        "long": long,
        "comment": comment == null ? null : comment,
        "created_at": createdAt,
        "updated_at": updatedAt!,
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

enum Type { IMAGE }

final typeValues = EnumValues({"image": Type.IMAGE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
