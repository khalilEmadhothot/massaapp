import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OneShot extends StatefulWidget {
  final String? date;
  final String? time;
  final String? url;
  final String? comment;
  final dynamic lat;
  final dynamic long;

  const OneShot(
      {this.date,
      this.time,
      this.url,
      this.comment,
      this.lat,
      this.long,
      Key? key})
      : super(key: key);

  @override
  State<OneShot> createState() => _OneShotState();
}

class _OneShotState extends State<OneShot> {
  // dynamic dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.date!));
  // dynamic date = DateFormat.jm().format(widget.date!);
  dynamic time = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Image.asset(
              'images/image_home_modern.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // child: Container(
            //   // margin: EdgeInsets.symmetric(vertical: 100.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12.0),
            //     image: DecorationImage(
            //       // fit: BoxFit.cover,
            //       image: AssetImage(
            //         'images/personal.jpg',
            //         // fit: BoxFit.cover,
            //         // width: double.infinity,
            //         // height: double.infinity,
            //       ),
            //       //NetworkImage('${ApiSettings.baseUrl}${widget.url!}'),
            //     ),
            //   ),
            // ),
            // child: Container(
            //   clipBehavior: Clip.antiAlias,
            //   width: double.infinity,
            //   height: 600.h,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20).r,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsetsDirectional.only(bottom: 80),
            //     child: Image.asset(
            //       'images/personal.jpg',
            //       fit: BoxFit.cover,
            //       width: double.infinity,
            //       height: double.infinity,
            //     ),
            //   ),
            // ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 520),
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
                           widget.date.toString(),
                            // DateFormat("dd-MM-yyyy")
                            //     .format(DateTime.parse(widget.date!)),
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
                            "3:40 PM",
                            // DateFormat("jm")
                            //     .format(DateTime.parse(widget.date!)),

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
            padding: const EdgeInsetsDirectional.only(top: 300),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 103.w,
                    height: 43.h,
                    decoration: BoxDecoration(
                      color: Color(0xffFFB300),
                      borderRadius: BorderRadius.circular(12).r,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 103.w,
                    height: 43.h,
                    decoration: BoxDecoration(
                      color: Color(0xff6F15DE),
                      borderRadius: BorderRadius.circular(12).r,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
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
                  padding: const EdgeInsetsDirectional.only(
                    end: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 20),
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: 330.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30).r,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Padding(
                            padding:
                                 EdgeInsetsDirectional.only(start: 20),
                            child: Text(
                              AppLocalizations.of(context)!.comment,
                              // widget.comment!,
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
