import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../ApiSettings.dart';
import '../model/GetAuth.dart';
class ProfailApiController{
  Future<Profile?> readUsers({required String token}) async {
    var url = Uri.parse(ApiSettings.getauth);
    var response = await http.get(url, headers: {"Authorization": token});

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Profile profile = Profile.fromJson(body);
      print("USER readUsers: ${jsonEncode(profile)}");
      return profile;
    }else{
      var body = jsonDecode(response.body);
      Profile auth = Profile.fromJson(body);
      print("ERROR: ${auth.description}");
      print("ERROR: ${response.body}");
      return null;
    }
  }
}