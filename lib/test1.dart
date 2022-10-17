import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Api/model/test.dart';
import 'package:massa_app/UI/Screens/video_details.dart';
import 'package:video_player/video_player.dart';

import 'Api/ApiSettings.dart';
import 'Storage/shared_pref_controller.dart';
import 'UI/Screens/image_details.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> with TickerProviderStateMixin {
  String videoUrl = '';
  bool isPlay = false;
  List<TestData> listImages = [];
  VideoPlayerController? _controller;
  late AnimationController _animationController;
  late List<_MyPictureData> _picturesData;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('');
    _controller!.initialize();
    // _controller!.setLooping(true);
    // _controller!.play();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _picturesData = _createPicturesData();
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: FetchAllFiles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && listImages.isNotEmpty ) {
                return Expanded(
                  child: Container(
                    child: WallLayout(
                      stones: _buildList(),
                      layersCount: 3,
                      // stonePadding: 12.0,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: Center(child: CircularProgressIndicator(
                  color: Color(0xff6F15DE),
                )));
              } else {
                return Expanded(child: Center(child: Text('No Data')));
              }
            },
          ),
        ],
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

  static Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
  }

  Future<Test?> FetchImage() async {
    // var url = Uri.parse(ApiSettings.getdimage);
    // String token = SharedPrefController().token;
    // final params = {'order_by': "desc", 'skip': 0, 'take': "10"};
    // // print("mmmmmmmm");
    // var url2 = Uri.parse(ApiSettings.getdimage);
    // var request = await http.MultipartRequest("POST", url2);
    // request.headers.addAll(header);
    // request.fields['order_by'] = "desc";
    // request.fields['skip'] = "0";
    // request.fields['take'] = "10";
    // var response2 = await request.send();
    // var responseBody = await http.Response.fromStream(response2);
    // // print("eeeeeeee ${jsonDecode(responseBody.body)}");
    // print(responseBody.statusCode);
    try {
      http.Response reaponas = await http.post(Uri.parse(ApiSettings.getdimage),
          headers: header,
          body: jsonEncode(<String, dynamic>{
            'order_by': 'desc',
            'skip': '0',
            'take': '10',
          }));
      if (reaponas.statusCode == 200) {
        //

        // Map<String, dynamic>
        // var list = convert.
        // jsonDecode(responseBody.body);
        // List<FetchImageModel> imageList =
        //     list.map((e) => FetchImageModel.fromJson(e)).tolist();
        var imageObj = jsonDecode(reaponas.body);
        // print('BODY: ${jsonEncode(imageObj)}');
        Test fetchImageModel = Test.fromJson(imageObj);

        // print('SUUCESS: ${jsonEncode(fetchImageModel)}');
        listImages.addAll(fetchImageModel.data!);
        // print('SUUCESS listImages: ${jsonEncode(listImages)}');
        return fetchImageModel;
      } else {
        print("ERROR ${jsonDecode(reaponas.body)}");
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  // Future<List<TestData>> FetchAllFiles() async {
  //   Uri uri = Uri.parse(ApiSettings.getfiles);
  //   var response = await http.post(uri,
  //       headers: headers, body: {"order_by": "desc", "skip": 0, "take": 10});
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     var jsonArray = jsonResponse['data'] as List;
  //     return jsonArray.map((e) => TestData.fromJson(e)).toList();
  //   }
  //   return [];
  // }

  Future<Test?> FetchAllFiles() async {
    // var url = Uri.parse(ApiSettings.getdimage);
    // String token = SharedPrefController().token;
    // final params = {'order_by': "desc", 'skip': 0, 'take': "10"};
    // // print("mmmmmmmm");
    // var url2 = Uri.parse(ApiSettings.getdimage);
    // var request = await http.MultipartRequest("POST", url2);
    // request.headers.addAll(header);
    // request.fields['order_by'] = "desc";
    // request.fields['skip'] = "0";
    // request.fields['take'] = "10";
    // var response2 = await request.send();
    // var responseBody = await http.Response.fromStream(response2);
    // // print("eeeeeeee ${jsonDecode(responseBody.body)}");
    // print(responseBody.statusCode);
    try {
      http.Response reaponas = await http.post(Uri.parse(ApiSettings.getfiles),
          headers: header,
          body: jsonEncode(<String, dynamic>{
            'order_by': 'desc',
            'skip': '0',
            'take': '10',
          }));
      if (reaponas.statusCode == 200) {
        //

        // Map<String, dynamic>
        // var list = convert.
        // jsonDecode(responseBody.body);
        // List<FetchImageModel> imageList =
        //     list.map((e) => FetchImageModel.fromJson(e)).tolist();
        var imageObj = jsonDecode(reaponas.body);
        // print('BODY: ${jsonEncode(imageObj)}');
        Test fetchImageModel = Test.fromJson(imageObj);

        // print('SUUCESS: ${jsonEncode(fetchImageModel)}');
        listImages.addAll(fetchImageModel.data!);
        // print('SUUCESS listImages: ${jsonEncode(listImages)}');
        return fetchImageModel;
      } else {
        print("ERROR ${jsonDecode(reaponas.body)}");
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void __swapLayout() {
    Navigator.of(context).popAndPushNamed("usecase2");
  }

  void __replayAnimation() {
    _animationController.forward(from: 0.0);
    setState(() {});
  }

  List<_MyPictureData> _createPicturesData() {
    final data = [
      {"name": "images/image_tg2.png", "width": 1, "height": 1},
      {"name": "images/image_home_modern.png", "width": 2, "height": 1},
      {"name": "images/image_home_modern.png", "width": 1, "height": 2},
      {"name": "images/Image_GrideView.png", "width": 2, "height": 2},
    ];
    double length = data.length.toDouble();
    final firstEnd = 0.35;
    return data.map((d) {
      final isFirst = data.indexOf(d) == 0;
      double pos = data.indexOf(d).toDouble();

      return _MyPictureData(
          name: d["name"].toString(),
          width: int.parse(d["width"].toString()),
          height: int.parse(d["height"].toString()),
          animatable: CurveTween(
            curve: Interval(
              isFirst ? 0.0 : (firstEnd + (pos / length) * (1.0 - firstEnd)),
              isFirst
                  ? firstEnd
                  : min(1.0,
                      firstEnd + ((pos + 1.0) / length) * (1.0 - firstEnd)),
              curve: isFirst ? Curves.elasticOut : Curves.easeOutBack,
            ),
          ));
    }).toList();
  }

  List<Stone> _buildList() {
    return listImages.map((element) {
      videoUrl = element.image!;
      List<int> listWidth = [1, 2, 3];
      List<int> listHeight = [2, 3, 1];
      int width = 0;
      int height = 0;
      listWidth.forEach((i) {
        width = i;
      });
      listHeight.forEach((i) {
        height = i;
      });
      return Stone(
        id: listImages.indexOf(element),
        width: element.id! == 2 ? width : height,
        height: element.id! % 2 == 0 ? width : 1,
        child: ScaleTransition(
          scale:
              CurveTween(curve: Interval(0.0, min(1.0, 0.25 + (2 * 1) / 6.0)))
                  .animate(_animationController),
          child: element.type == 'image'
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetails(
                          time: element.createdAt,
                          date: element.createdAt,
                          url: element.image,
                          comment: element.comment,
                          lat: element.lat,
                          long: element.long,
                        ),
                        //     Category(
                        //   time: element.createdAt,
                        //   date: element.createdAt,
                        //   url: element.image,
                        //   comment: element.comment,
                        //   lat: element.lat,
                        //   long: element.long,
                        // ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${ApiSettings.baseUrl}${element.image!}'),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                      IconButton(
                          icon: Icon(
                            _controller!.value.isPlaying == false
                                ? Icons.play_circle
                                : Icons.pause_circle,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return VideoDetails(
                                  time: element.createdAt,
                                  date: element.createdAt,
                                  url: element.image,
                                  comment: element.comment,
                                  lat: element.lat,
                                  long: element.long,
                                );
                              },
                            ));
                            // _playVideo(file: element.image);
                            // setState(() {
                            //   _controller!.value.isPlaying == true;
                            // });
                          }),
                    ],
                  ),
                ),
        ),
      );
    }).toList();
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller == null;
  }

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
}

class _MyPictureData {
  final String name;
  final int width;
  final int height;
  final Animatable animatable;

  _MyPictureData(
      {required this.name,
      required this.width,
      required this.height,
      required this.animatable});
}
