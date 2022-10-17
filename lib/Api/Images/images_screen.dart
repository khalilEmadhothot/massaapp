import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/get/get_api_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:massa_app/utils/ApiHelper.dart';

import '../ApiSettings.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with ApiHelper {
  // ImagesGetxController _controller = Get.put(ImagesGetxController());
  ImagesGetxController _controller = Get.put(ImagesGetxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/UploadImages');
              },
              icon: Icon(
                // CupertinoIcons.camera,
                Icons.camera_alt,
                color: Colors.black,
              ))
        ],
      ),
      body: GetX<ImagesGetxController>(
        // init: ImagesGetxController(),
        // global: true,
        builder: (controller) {
          if (controller.loading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.images.isNotEmpty) {
            return GridView.builder(
              itemCount: controller.images.length,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        cacheKey: controller.images[index].name,
                        width: double.infinity,
                        imageUrl: ApiSettings.imageUrl +
                            controller.images[index].name,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          // CupertinoIcons.person,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.nodatanow),
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteImage({required int index}) async {
    ApiResponse response =
        await ImagesGetxController.to.deleteImage(index: index);
    // showSnackBar(context, message: response.description, error: !response.success);
  }
}
