// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.success,
    this.description,
    this.data,
  });

  bool? success;
  String? description;
  Data? data;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
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
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.code,
    this.ipCode,
    this.phone,
    this.gender,
    this.premium,
    this.premiumDate,
    this.isBlocked,
    this.maxSizeAllowed,
    this.allowedSizeRemain,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? code;
  dynamic ipCode;
  dynamic phone;
  String? gender;
  int? premium;
  dynamic premiumDate;
  int? isBlocked;
  int? maxSizeAllowed;
  int? allowedSizeRemain;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        code: json["code"],
        ipCode: json["ip_code"],
        phone: json["phone"],
        gender: json["gender"],
        premium: json["premium"],
        premiumDate: json["premium_date"],
        isBlocked: json["is_blocked"],
        maxSizeAllowed: json["max_size_allowed"],
        allowedSizeRemain: json["allowed_size_remain"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "code": code,
        "ip_code": ipCode,
        "phone": phone,
        "gender": gender,
        "premium": premium,
        "premium_date": premiumDate,
        "is_blocked": isBlocked,
        "max_size_allowed": maxSizeAllowed,
        "allowed_size_remain": allowedSizeRemain,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
