import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter_screenutil/flutter_screenutiltp.dart' as http;
import 'package:intl/intl.dart';

import '../../../Api/ApiSettings.dart';
import '../../../Api/model/image_by_day.dart';
import '../../../Storage/shared_pref_controller.dart';
import '../image_details.dart';

class Date extends StatefulWidget {
  const Date({Key? key}) : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  List<Datum> listdate = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
              child: FutureBuilder<List<Datum>>(
                future: ImageDate(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff6F15DE),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    // return Column(
                    //   children: [
                    //     Column(
                    //       children: _buildList(),
                    //     ),
                    //   ],
                    // );
                    return Container(
                      height: Get.height,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDetails(
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff6F15DE),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat("dd-MM-yyyy").format(
                                          DateTime.parse(snapshot
                                              .data![index].createdAt!
                                              .toString())),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  // if (snapshot.connectionState == ConnectionState.done) {

                  // } else if (snapshot.connectionState ==
                  //     ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // } else {
                  //   return Text('${snapshot.error}');
                  // }
                },
              ),
              // child: Column(
              //   children: _buildList(),
              // ),
              // child: GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: 20,
              //     scrollDirection: Axis.vertical,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 10.w.h,
              //       mainAxisSpacing: 10.w,
              //       childAspectRatio: 80 / 40.w.h,
              //     ),
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: 116.w,
              //         height: 48.h,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10).r,
              //             color: Color(0xff6F15DE)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Icon(Icons.calendar_today, color: Colors.white),
              //             Text(
              //               'One Day',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //       );
              //     }),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return listdate.map((element) {
      // return InkWell(
      //   /
      //   child: Column(
      //     children: [
      //       Container(
      //         width: 116.w,
      //         height: 48.h,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10).r,
      //             color: Color(0xff6F15DE)),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Icon(Icons.calendar_today, color: Colors.white),
      //             Text(
      //               DateFormat("dd-MM-yyyy")
      //                   .format(DateTime.parse(element.createdAt!.toString())),
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 13.sp,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         width: 10.h,
      //       ),
      //     ],
      //   ),
      // );
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetails(
                time: element.createdAt.toString(),
                date: element.createdAt.toString(),
                url: element.name,
                comment: element.comment,
                lat: element.lat,
                long: element.long,
              ),
            ),
          );
        },
        child: Container(
          width: 700.w,
          height: 1200,
          child: GridView.builder(
              // shrinkWrap: true,
              itemCount: listdate.length,
              //int.parse(element.size.toString()),
              // scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w.h,
                mainAxisSpacing: 10.w,
                // childAspectRatio: 40 / 50.w.h,
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: 70.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: Color(0xff6F15DE)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white),
                      Text(
                        DateFormat("dd-MM-yyyy").format(
                            DateTime.parse(element.createdAt!.toString())),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
      return Container(
        child: Text(element.folder!.name!),
      );
    }).toList();
  }

  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().loggedin) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }

  Future<List<Datum>> ImageDate() async {
    var url = Uri.parse(ApiSettings.imagebydate);
    String token = SharedPrefController().token;
    final param = {"days": "30", "order_by": "desc", "skip": "0", "take": "10"};
    var response = await http.post(url, body: param, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var folderObj = jsonDecode(response.body);
      var jsonData = folderObj['data'] as List;
      print('ImageDate: ${jsonEncode(jsonData)}');
      return jsonData.map((e) => Datum.fromJson(e)).toList();
    }
    return [];
  }
}
