import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:massa_app/Api/ApiSettings.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/Api/model/fetch_image_model.dart';
import 'package:massa_app/Api/model/user_images.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:massa_app/utils/ApiHelper.dart';

import '../model/fetch_image_model.dart';

class ImagesApiController with ApiHelper {
  Future<http.StreamedResponse> UploadImage({required File file}) async {
    //Upload, Read, Delete
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', url);
//MultipartRequest
    //بياخد  Text  File headers
    var imageFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(imageFile);
    request.fields['type'] = 'image';
    request.fields['size'] = '123';
    request.fields['lat'] = '32.54545';
    request.fields['long'] = "32.54545";
    request.fields['comment'] = 'comment';
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;

    // request.fields['name'] = 'ABC';
    // request.fields['_method'] = 'PUT';

    //acceptHeader              acceptHeader  ارسل        authorizationHeader لما يكون
//authorizationHeader
    // ابتنبعت في كل ريكوست الي يطلب تنفيذه الوصول للبيانات الخاصه زي بياناتك ع غيس بوك الوصول لا الها لازم يكون صلاحية الفردنفسو
    var streamResponse = await request.send();
    var response = await streamResponse.stream.toBytes();
    var res = String.fromCharCodes(response);
    print("DATA: ${jsonDecode(res)}");
    if (response == 200) {
      // return response.;
    } else {
      // return null;
    }
    return await streamResponse;
  }

  Future<List<FetchImageModel>> FetchImage() async {
    try {
      var url = Uri.parse(ApiSettings.getdimage);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("aaaaaaaaaa");
        print(response.body);

        List<dynamic> list = convert.jsonDecode(response.body);

        List<FetchImageModel> imageList =
            list.map((e) => FetchImageModel.fromJson(e)).toList();

        // var imageObj = jsonDecode(response.body);
        // FetchImageModel fetchImageModel = FetchImageModel.fromJson(imageObj);

        return imageList;
      } else {
        throw Exception();
      }
    } catch (e) {
      print("eeeeeeee $e");
      throw Exception();
    }
  }

  Future<ApiResponse<UserImage>> IndexImage() async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}}', ''));
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonObject = jsonResponse['data'] as List;
        List<UserImage> images = jsonObject
            .map((jsonobject) => UserImage.fromJson(jsonobject))
            .toList();
        return ApiResponse<UserImage>.listResponse(
            description: jsonResponse['description'],
            success: jsonResponse['success'],
            data: images);
      }
      return ApiResponse(description: 'you must login again!', success: false);
    }
    return getGenericErrorResponse<UserImage>();
  }

  Future<ApiResponse> deleteImage({required int id}) async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          description: jsonResponse['message'],
          success: jsonResponse['status']);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      String message = response.statusCode == 404
          ? 'Selected image is not found'
          : 'Unauthorized access, login again';
      return ApiResponse(description: message, success: false);
    }
    return errorServerResponse;
  }

  Future<Map<String, dynamic>?> _uploadImage(File image) async {
    // final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse("uri"));

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(
      'half_body_image',
      image.path,
    );
    // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['name'] = "";
    imageUploadRequest.fields['email'] = "_email";
    imageUploadRequest.fields['contact_no'] = "_contact";

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      // _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
