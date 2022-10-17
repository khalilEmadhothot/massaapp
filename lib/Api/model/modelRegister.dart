
class ModelRegister  {
late  String name;
 late String email;
 late String password;
  late String passwordConfirmation;
   late String ipCode;
late  String phone;
  late String gender;

ModelRegister ();

ModelRegister .fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    ipCode = json['ip_code'];
    phone = json['phone'];
    gender = json['gender'];
  }


 }
// class User {
//   late int id;
//   late  String name;
//   late  String email;
//   late String? emailVerifiedAt;
//  late  String code;
//   late String?  ipCode;
//   late String phone;
//   late String  gender;
//   late String  premium;
//   late String?  premiumDate;
//   late String password;
//   late String passwordConfirmation;
//   late String isBlocked;
//    late String maxSizeAllowed;
//    late String allowedSizeRemain;
//    late String createdAt;
//    late String updatedAt;
//
// User();
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     code = json['code'];
//     ipCode = json['ip_code'];
//     phone = json['phone'];
//     gender = json['gender'];
//     password = json['password'];
//     passwordConfirmation = json['password_confirmation'];
//     premium = json['premium'];
//     premiumDate = json['premium_date'];
//     isBlocked = json['is_blocked'];
//     maxSizeAllowed = json['max_size_allowed'];
//     allowedSizeRemain = json['allowed_size_remain'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//
// }