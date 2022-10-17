
import 'dart:io';

import 'package:massa_app/Storage/shared_pref_controller.dart';

import '../Api/model/api_response.dart';

mixin ApiHelper{

  Map<String,String> get headers{
    Map<String,String> headers=<String,String>{};
    headers[HttpHeaders.acceptHeader]='application/json';
    if(SharedPrefController().loggedin){
        headers[HttpHeaders.authorizationHeader]=SharedPrefController().token;
    }
    return headers;

  }
  ApiResponse<T> getGenericErrorResponse<T>() {
    return ApiResponse<T>(description: 'Something went wrong', success: false);
  }
  ApiResponse get errorServerResponse {
    return ApiResponse(description: 'Something went wrong', success: false);
  }


}