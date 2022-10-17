class Profile {
  bool? success;
  String? description;
  GetAuth? data;


  Profile(this.success, this.description, this.data);

  Profile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
    data = json['data'] != null ? GetAuth.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['description'] = this.description;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetAuth {
  int? id;
  String? name;
  String? email;
  dynamic? emailVerifiedAt;
  String? code;
  dynamic ipCode;
  dynamic phone;
  String? gender;
  int? premium;
  dynamic premiumDate;
  int? isBlocked;
  int? maxSizeAllowed;
  int? allowedSizeRemain;
  String? createdAt;
  String? updatedAt;


  GetAuth(
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
      this.updatedAt);

  GetAuth.empty();

  GetAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    code = json['code'];
    ipCode = json['ip_code'];
    phone = json['phone'];
    gender = json['gender'];
    premium = json['premium'];
    premiumDate = json['premium_date'];
    isBlocked = json['is_blocked'];
    maxSizeAllowed = json['max_size_allowed'];
    allowedSizeRemain = json['allowed_size_remain'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['code'] = this.code;
    data['ip_code'] = this.ipCode;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['premium'] = this.premium;
    data['premium_date'] = this.premiumDate;
    data['is_blocked'] = this.isBlocked;
    data['max_size_allowed'] = this.maxSizeAllowed;
    data['allowed_size_remain'] = this.allowedSizeRemain;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
