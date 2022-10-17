import 'dart:convert';
import 'dart:io';
import 'package:massa_app/Api/ApiSettings.dart';
import 'package:massa_app/Api/model/search_model.dart';
import 'package:http/http.dart' as http;
import '../../Storage/shared_pref_controller.dart';

class SearchApiController {
  Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      // HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Future<List<SearchModel>> getSearchResult({required String comment}) async {
    Uri uri = Uri.parse(ApiSettings.searchApi);
    var response = await http.post(uri,
        headers: header,
        body: json.encode({
          "order_by": "desc",
          "skip": 0,
          "take": 10,
          "comment": comment,
        }));
    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(jsonArray);
      return jsonArray
          .map((jsonObject) => SearchModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
}
