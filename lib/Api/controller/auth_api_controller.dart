import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:massa_app/Api/ApiSettings.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/Api/model/modellogin.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:massa_app/utils/ApiHelper.dart';

import '../model/register.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var jsoinObject = body['data'];
      LoginData modelLogin = LoginData.fromJson(jsoinObject);
      await SharedPrefController.Save(loginData: modelLogin);
      print("TOKEN ${body['data']["token"]}");
      return ApiResponse(
          description: body['description'], success: body['success']);
    } else if (response.statusCode == 400) {
      var jsoinResonse = jsonDecode(response.body);
      return ApiResponse(
          description: jsoinResonse['description'],
          success: jsoinResonse['success']);
    } else {
      return ApiResponse(description: 'something went wrong', success: false);
    }
  }

  Future<ApiResponse> logout() async {
    var url = Uri.parse(ApiSettings.logout);
    var response = await http.post(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.body);
      var jsoinResonse = jsonDecode(response.body);
      unawaited(SharedPrefController().Clear());
      if (response.statusCode == 200) {
        return ApiResponse(
            description: jsoinResonse['description'],
            success: jsoinResonse['success']);
      } else {
        return ApiResponse(
            description: 'loggout out susccefully', success: true);
      }
    }
    return ApiResponse(description: 'somthing went worng', success: false);
  }

  Future<Register> register({required String phone,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "ip_code": "970",
          "phone": phone,
          "gender": "1"
        }));
    Register register = Register();

    if (response.statusCode == 200 /*|| response.statusCode == 400*/) {
      var jsonResponse = jsonDecode(response.body);
      Register register = Register.fromJson(jsonResponse);
      var jsoinObject = jsonResponse['data'];
      LoginData modelLogin = LoginData.fromJson(jsoinObject);
      await SharedPrefController.Save(loginData: modelLogin);
      print(jsonEncode(register));
      return register;
    } else {
      print("ERROR: ${response.body}");
      return register;
    }
  }

  Future<ApiResponse> forgetPassword({required String email}) async {
    var url = Uri.parse(ApiSettings.forget);
    var response = await http.post(url, body: {
      'email': email,
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) print(jsonResponse['code']);
      return ApiResponse(
          description: jsonResponse['description'],
          success: jsonResponse['success']);
    }
    print("ERROR: forgetPassword: ${response.statusCode}");
    return ApiResponse(description: 'somthing went worng', success: false);
  }

  Future<ApiResponse> resetPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    var url = Uri.parse(ApiSettings.reset);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          description: jsonResponse['description'],
          success: jsonResponse['success']);
    }
    return ApiResponse(description: 'somthing went worng', success: false);
  }

  Future<bool> sendVerifiedEamil() async {
    Uri uri = Uri.parse(ApiSettings.sendVerifiedEmail);
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verifiedEmail({required String code}) async {
    Uri uri = Uri.parse(ApiSettings.verifiedEmail);
    var response = await http.post(uri, headers: headers, body: {
      'code': code,
    });
    if (response.statusCode == 200) {
      return true;
    };
    return false;
  }
}
