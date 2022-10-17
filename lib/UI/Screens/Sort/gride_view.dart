import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Storage/shared_pref_controller.dart';

import '../../../Api/ApiSettings.dart';
import '../../../Api/model/test.dart';
import '../image_details.dart';

class GrideView extends StatefulWidget {
  const GrideView({Key? key}) : super(key: key);

  @override
  State<GrideView> createState() => _GrideViewState();
}

class _GrideViewState extends State<GrideView> with TickerProviderStateMixin {
  List<TestData> listImages = [];
  late AnimationController _animationController;
  late List<_MyPictureData> _picturesData;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _picturesData = _createPicturesData();
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: FetchImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  listImages.isNotEmpty) {
                return Expanded(
                  child: WallLayout(
                    stones: _buildList(),
                    layersCount: 3,
                    scrollDirection: Axis.vertical,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff6F15DE),
                  )),
                );
              } else {
                return Expanded(child: Center(child: Text('No Data')));
              }
            },
          ),
        ],
      ),
    );
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
          child: InkWell(
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
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage('${ApiSettings.baseUrl}${element.image!}'),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
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
    try {
      http.Response reaponas = await http.post(Uri.parse(ApiSettings.getdimage),
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
        return fetchImageModel;
      } else {
        print("ERROR ${jsonDecode(reaponas.body)}");
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
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
