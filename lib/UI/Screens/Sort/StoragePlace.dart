import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Api/model/folders_model.dart';
import 'package:massa_app/UI/Screens/BotoomNaviagtion/HomeScreen.dart';
import 'package:massa_app/UI/Screens/image_details.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../../Api/ApiSettings.dart';
import '../../../Api/model/sort_folder_model.dart';
import '../../../Storage/shared_pref_controller.dart';
import '../video_details.dart';

class StoragePlace extends StatefulWidget {
  const StoragePlace({Key? key}) : super(key: key);

  @override
  State<StoragePlace> createState() => _StoragePlaceState();
}

class _StoragePlaceState extends State<StoragePlace> {
  List<Datum> listForder = [];
  bool status = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           height: 40.h,
    //         ),
    //         SizedBox(
    //           //  height: 700.h,
    //           child: Padding(
    //             padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
    //             child: FutureBuilder(
    //               future: SortFolder(),
    //               builder: (context, snapshot) {
    //                 // if (snapshot.connectionState == ConnectionState.done) {
    //                 return Column(
    //                   children: _buildList(),
    //                 );
    //                 // } else if (snapshot.connectionState ==
    //                 //     ConnectionState.waiting) {
    //                 //   return Center(child: CircularProgressIndicator());
    //                 // } else {
    //                 //   return Text('${snapshot.error}');
    //                 // }
    //               },
    //               // builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //               //   return  GridView.builder(
    //               //     shrinkWrap: true,
    //               //     // itemCount: 10,
    //               //     scrollDirection: Axis.vertical,
    //               //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               //       crossAxisCount: 3,
    //               //       crossAxisSpacing: 10.w.h,
    //               //       mainAxisSpacing: 10.w,
    //               //       childAspectRatio: 40 / 50.w.h,
    //               //     ),
    //               //     itemBuilder: (context, index) {
    //               //       return Column(
    //               //         children: [
    //               //           Image.asset('images/Image_Sorage.png'),
    //               //           SizedBox(
    //               //             height: 10.h,
    //               //           ),
    //               //           Text(
    //               //             'رحلة غزة',
    //               //             style: TextStyle(
    //               //               color: Colors.black,
    //               //               fontWeight: FontWeight.bold,
    //               //               fontSize: 15.sp,
    //               //             ),
    //               //           ),
    //               //         ],
    //               //       );
    //               //     }
    //               //     );
    //               //     },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: Text("btn1"),
          backgroundColor: Color(0xff6F15DE),
          onPressed: () {
            Navigator.pushNamed(context, '/StartWithUs');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: FutureBuilder<List<Data>>(
            future: getFolders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color(0xff6F15DE),
                ));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w.h,
                      mainAxisSpacing: 10.w,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return HomeScreen(
                                id: snapshot.data![index].id.toString());
                          }));
                        },
                        child: Container(
                          width: 80.w,
                          height: 70.h,
                          child: Column(
                            children: [
                              Image.asset('images/Image_Sorage.png'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                snapshot.data![index].name.toString(),
                                style: TextStyle(
                                  color: the == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                // return Align(
                //
                //   alignment: AlignmentDirectional.center,
                //   child:
                //       Text(AppLocalizations.of(context)!.thereisnofoldersyet,style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w700,
                //         fontSize: 25,
                //       ),),
                // );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(AppLocalizations.of(context)!.thereisnofoldersyet,style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.h,
                        fontWeight: FontWeight.w700
                      ),),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  List<Widget> _buildList() {
    return listForder.map((element) {
      return InkWell(
        onTap: () {
          element.type == "image"
              ? Navigator.push(
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
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoDetails(
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
          width: 300.w,
          height: 1200,
          child: GridView.builder(
              itemCount: listForder.length,
              shrinkWrap: true,
              // itemCount: 10,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w.h,
                mainAxisSpacing: 10.w,
                // childAspectRatio: 40 / 50.w.h,
              ),
              itemBuilder: (context, index) {
                return
                    // Row(
                    // children: [
                    Container(
                  width: 80.w,
                  height: 70.h,
                  child: Column(
                    children: [
                      Image.asset('images/Image_Sorage.png'),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        element.folder!.name!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                );
                // SizedBox(
                //   width: 10.h,
                // ),
                //   ],
                // );
              }),
        ),
      );
      // return GridView.builder(
      //     // shrinkWrap: true,
      //     // itemCount: 10,
      //     // scrollDirection: Axis.vertical,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3,
      //       crossAxisSpacing: 10.w.h,
      //       mainAxisSpacing: 10.w,
      //       childAspectRatio: 40 / 50.w.h,
      //     ),
      //     itemBuilder: (context, index) {
      //
      //     });
      // return Container(
      //   child: Text(element.folder!.name!),
      // );
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

  Future<List<Data>> getFolders() async {
    var response = await http
        .get(Uri.parse('http://176.126.87.26/api/main-folders'), headers: {
      'Authorization': 'Bearer ${SharedPrefController().token}',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body)['data'] as List;
      return data.map((e) => Data.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<SortFolderModel?> SortFolder() async {
    try {
      var url = Uri.parse(ApiSettings.sortfolder);
      String token = SharedPrefController().token;
      final param = {
        "order_by": "desc",
        "skip": "0",
        "take": "10",
      };
      print("ddddd");
      var response = await http.post(url, body: param, headers: headers);
      print("gggggg");
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var folderObj = jsonDecode(response.body);
        SortFolderModel folderModel = SortFolderModel.fromJson(folderObj);
        listForder.addAll(folderModel.data!);
        return folderModel;
      } else {
        print("33333");
      }
    } catch (e) {
      print("eeeeeee $e");
      throw Exception();
    }
  }
}
