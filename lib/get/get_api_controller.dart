import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:massa_app/Api/model/user_images.dart';

import '../Api/Images/images_api_controller.dart';
import '../Api/model/api_response.dart';

//يتم ترجمة كل الميثد الي هان ب كلاس الكنترول هان فقط المركزيه
// الان دوال الي بكلاس هاد بدي اقرأهم في بيئة ال ui الان هتبدأ تركب الجت علي التصميم
typedef UploadImageCallback = void Function(ApiResponse apiResponse);

class ImagesGetxController extends GetxController {
  static ImagesGetxController get to => Get.find();

  final ImagesApiController _apiController = ImagesApiController();

  RxBool loading = false.obs;
  RxList<UserImage> images = <UserImage>[].obs;

  @override
  void onInit() {
    readImages();
    super.onInit();
  }

  void readImages() async {
    loading.value = true;
    ApiResponse<UserImage> apiResponse = await _apiController.IndexImage();
    loading.value = false;
    if (apiResponse.success) images.value = apiResponse.data ?? [];
  }

  Future<void> uploadImage(context,
      {required File file,
      required UploadImageCallback uploadImageCallback}) async {
    StreamedResponse streamedResponse =
        await _apiController.UploadImage(file: file);
    Navigator.pushNamed(context, "/ImagesScreen");

    // streamedResponse.stream.transform(utf8.decoder).listen((String body){
    //   if (streamedResponse.statusCode == 201){
    //     var jsonResponse = jsonDecode(body);
    //     UserImage userimage =
    //     UserImage.fromJson(jsonResponse['object']);
    //     images.add(userimage);
    //     return uploadImageCallback(
    //       ApiResponse(description: jsonResponse['description'], success: jsonResponse['success']),
    //     );
    //   }else {
    //     print(body);
    //     print(streamedResponse.statusCode);
    //     uploadImageCallback(ApiResponse(description: 'Error',success: false));
    //   }
    // });
  }

  Future<ApiResponse> deleteImage({required int index}) async {
    ApiResponse apiResponse =
        await _apiController.deleteImage(id: images[index].id);
    if (apiResponse.success) {
      images.removeAt(index);
    }
    return apiResponse;
  }

  Future<dynamic> UploadImages(File file, String type, int size, double lat,
      double long, String comment) async {
    try {
      // Response response;
      final formData = {
        "file": file,
        "type": type,
        "size": size,
        "lat": lat,
        "long": long,
        "comment": comment,
      };
      // Response response = await http.post(
      //   "http://176.126.87.26/api/upload-files",
      //   body: formData,
      // );
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
