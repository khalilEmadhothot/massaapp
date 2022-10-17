import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Api/model/test.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:massa_app/UI/Screens/video_details.dart';
import 'package:video_player/video_player.dart';

import '../../../Api/ApiSettings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ScreenVideo extends StatefulWidget {
  const ScreenVideo({Key? key}) : super(key: key);

  @override
  State<ScreenVideo> createState() => _ScreenVideoState();
}

class _ScreenVideoState extends State<ScreenVideo>
    with TickerProviderStateMixin {
  List<TestData> listImages = [];
  String videoUrl = '';
  bool isPlay = false;
  VideoPlayerController? _controller;

  late AnimationController _animationController;
  late List<_MyPictureData> _picturesData;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('');
    _controller!.initialize();
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

  static Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
  }

  Future<Test?> FetchVideo() async {
    try {
      http.Response reaponas = await http.post(Uri.parse(ApiSettings.getdvideo),
          headers: header,
          body: jsonEncode(<String, dynamic>{
            'order_by': 'desc',
            'skip': '0',
            'take': '10',
          }));
      if (reaponas.statusCode == 200) {
        var imageObj = jsonDecode(reaponas.body);
        Test fetchImageModel = Test.fromJson(imageObj);
        listImages.addAll(fetchImageModel.data!);
        print(reaponas.body);
        return fetchImageModel;
      } else {
        print("ERROR ${jsonDecode(reaponas.body)}");
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
    }
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
          child: Container(
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
      VideoPlayerController controller = VideoPlayerController.network(
          // VideoPlayerController.network("${ApiSettings.baseUrl}${file} ");
          "${ApiSettings.baseUrl}${file} ");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: FetchVideo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  listImages.isNotEmpty) {
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
                return Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: Color(0xff6F15DE),
                )));
              } else {
                return Expanded(
                    child: Center(child: Text( AppLocalizations.of(context)!.nodatanow)));
              }
            },
          ),
        ],
      ),
    );
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
