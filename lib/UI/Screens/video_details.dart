import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:massa_app/Api/ApiSettings.dart';
import 'package:video_player/video_player.dart';

import 'google_map.dart';

class VideoDetails extends StatefulWidget {
  final String? date;
  final String? time;
  final String? url;
  final String? comment;
  final dynamic lat;
  final dynamic long;

  const VideoDetails(
      {this.date,
      this.time,
      this.url,
      this.comment,
      this.lat,
      this.long,
      Key? key})
      : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late VideoPlayerController _controller;

  // dynamic dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.date!));
  // dynamic date = DateFormat.jm().format(widget.date!);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('');
    _controller.initialize();
    print(widget.url);
    print('===========================================');
  }

  dynamic time = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: 100.h,
              left: 0,
              right: 0,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                          _controller == null ? _controller : _controller),
                    ),
                    Visibility(
                      visible: _controller.value.isPlaying != true,
                      child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying == false
                                ? Icons.play_circle
                                : Icons.pause_circle,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _playVideo(file: widget.url!);
                            setState(() {
                              _controller.value.isPlaying == true;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 100.h),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12.0),
            //       image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: NetworkImage('${ApiSettings.baseUrl}${widget.url!}'),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 120.h,
              left: 70.w,
              right: 70.w,
              child: Container(
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Color(0xffB0B0B0),
                  borderRadius: BorderRadius.circular(25).r,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    end: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                            size: 18.h,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(widget.date!)),
                            // widget.date!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.white,
                            size: 18.h,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            DateFormat("jm")
                                .format(DateTime.parse(widget.date!)),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, bottom: 35),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  width: double.infinity,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Color(0xff6F15DE),
                    borderRadius: BorderRadius.circular(35).r,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: 15, start: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 20),
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: 300.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30).r,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 20, end: 20),
                              child: Text(
                                widget.comment!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 40.w,
                        //   height: 40.h,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(30).r,
                        //     color: Color(0xffFFB300),
                        //   ),
                        //   child: Icon(
                        //     Icons.send,
                        //     size: 20.h,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/BootomNaviagtionScreen');
                          // Navigator.pushReplacementNamed(context, '/Home');
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 18.h,
                          color: Colors.black,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoogleMaps(
                            lat: widget.lat,
                            long: widget.long,
                          ),
                        ),
                      );
                    },
                    child: Container(
                        // margin: EdgeInsets.only(
                        //   top: 50.h,
                        // ),
                        width: 40.w,
                        height: 40.h,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: Color(0xffFFB300),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 22.h,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller == null;
  }

  Future<void> _playVideo({String? file}) async {
    print('FILE: $file');
    if (file != null) {
      VideoPlayerController controller =
          VideoPlayerController.network("${ApiSettings.baseUrl}${widget.url!}");
      _controller = controller;
      await controller.initialize();
      await controller.setLooping(false);
      _controller.value.isPlaying == false
          ? await controller.play()
          : await controller.pause();
    } else {
      print("Loading Video error");
    }
  }
}
