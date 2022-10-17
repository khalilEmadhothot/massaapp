import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({
    Key? key,

    // required void Function(dynamic file) onFile,
  }) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final photos = <File>[];

  void openCamera() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (value) {
                    photos.add(value);
                    String fileName = value.path.split('/').last;
                    print("FILENAME: $fileName");
                    print("PATH: ${value.path}");
                    Navigator.pop(context);
                    setState(() {});
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Color(0xff6F15DE),
      //   title: Text(''),
      // ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: photos.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width,
            child: Image.file(
              photos[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        backgroundColor: Color(0xff6F15DE),
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
