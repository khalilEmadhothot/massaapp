import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Api/model/user_images.dart';
import 'package:massa_app/UI/Screens/image_details.dart';
import 'package:video_player/video_player.dart';

import '../../../Api/ApiSettings.dart';
import '../../../Api/model/sort_folder_model.dart';
import '../../../Storage/shared_pref_controller.dart';
import '../video_details.dart';

class HomeScreen extends StatefulWidget {
  final String id;

  HomeScreen({required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('');
    _controller!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    ///  all images by folder
    return Scaffold(
      body: FutureBuilder<List<Datum>?>(
        future: getImagesByFolders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          snapshot.data![index].type == "image"
                              ? Navigator.push(context,
                                  MaterialPageRoute(builder: (builder) {
                                  return ImageDetails(
                                    time: snapshot.data![index].createdAt
                                        .toString(),
                                    comment: snapshot.data![index].comment,
                                    url: snapshot.data![index].name,
                                    lat: snapshot.data![index].lat,
                                    long: snapshot.data![index].long,
                                    date: snapshot.data![index].createdAt
                                        .toString(),
                                  );
                                }))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoDetails(
                                      time: snapshot.data![index].createdAt
                                          .toString(),
                                      date: snapshot.data![index].createdAt
                                          .toString(),
                                      url: snapshot.data![index].name,
                                      comment: snapshot.data![index].comment,
                                      lat: snapshot.data![index].lat,
                                      long: snapshot.data![index].long,
                                    ),
                                  ),
                                );
                        },
                        child:
                            // must add here the condition which
                            // will check if file is image or video to open it,
                            snapshot.data![index].type == "image"
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          '${ApiSettings.baseUrl}${snapshot.data![index].name}',
                                          fit: BoxFit.fill,
                                          height: 200,
                                          width: Get.width,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                            ),
                                            child: Text(
                                              snapshot.data![index].comment
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 2,
                                          child: VideoPlayer(_controller!),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              _controller!.value.isPlaying ==
                                                      false
                                                  ? Icons.play_circle
                                                  : Icons.pause_circle,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  )
                        // here clone the code which open the video

                        );
                  }),
            );
          } else {
            return Text('this folder has no image or video yet');
          }
        },
      ),
    );
  }

  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().loggedin) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }

  String token = SharedPrefController().token;
  final param = {
    "order_by": "desc",
    "skip": "0",
    "take": "10",
  };

  Future<void> _playVideo({String? file}) async {
    print('FILE: $file');
    if (file != null) {
      VideoPlayerController controller =
          VideoPlayerController.network("${ApiSettings.baseUrl}${file} ");
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
      _controller = controller;
      await controller.initialize();
      await controller.setLooping(false);

      _controller!.value.isPlaying == false
          ? await controller.play()
          : await controller.pause();
    } else {
      print("Loading Video error");
    }
  }

  Future<List<Datum>?> getImagesByFolders() async {
    var url = Uri.parse('${ApiSettings.sortfolder}${widget.id}');
    print('${ApiSettings.sortfolder}${widget.id}');
    var response = await http.post(url, body: param, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body)['data'] as List;
      print(data);
      return data.map((e) => Datum.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
