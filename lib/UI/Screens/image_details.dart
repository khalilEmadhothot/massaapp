import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../Api/ApiSettings.dart';
import 'google_map.dart';

class ImageDetails extends StatefulWidget {
  final String? date;
  final String? time;
  final String? url;
  final String? comment;
  final dynamic lat;
  final dynamic long;

  const ImageDetails(
      {this.date,
      this.time,
      this.url,
      this.comment,
      this.lat,
      this.long,
      Key? key})
      : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  // dynamic dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.date!));
  // dynamic date = DateFormat.jm().format(widget.date!);
  dynamic time = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
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
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 100.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${ApiSettings.baseUrl}${widget.url!}'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 570.h),
            child: Align(
              alignment: AlignmentDirectional.center,
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
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 30, end: 30, bottom: 35),
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
                  padding: const EdgeInsetsDirectional.only(
                    end: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 20,
                        ),
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: 310.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30).r,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20),
                            child: Text(
                             widget.comment != null ? widget.comment! : '',
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
        ],
      ),
    );
  }
}
