import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../Api/ApiSettings.dart';
import '../../Api/model/create_folder_model.dart';
import '../../Storage/shared_pref_controller.dart';

class StartWithUs extends StatefulWidget {
  const StartWithUs({Key? key}) : super(key: key);

  @override
  State<StartWithUs> createState() => _StartWithUsState();
}

class _StartWithUsState extends State<StartWithUs> {
  bool status = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, '/BootomNaviagtionScreen');
                }, icon:Icon(Icons.delete_forever, color: Color(0xff6F15DE),size: 30,))),
            SizedBox(
              height: 120.h,
            ),

            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                'Start With Us',
                style: TextStyle(
                  color: Color(0xff6F15DE),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            Align(
                alignment: AlignmentDirectional.center,
                child: Image.asset(
                  'images/Image_start_with.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                )),
            SizedBox(
              height: 90.h,
            ),
            InkWell(
              onTap: () {
                showDialog1();
                // setState(() {
                //   status = !status;
                // });
              },
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 78.w,
                  height: 78.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36).r,
                    border: Border.all(
                      width: 2.w,
                      color: Color(0xff6F15DE),
                    ),
                  ),
                  child: Image.asset(
                    'images/Image_file.png',
                    height: 35.h,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: status ? true : false,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextField(
                          controller: _nameController,
                          onTap: () {},
                          onChanged: (String value) {},
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(10).r,
                          enabled: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.black),
                          decoration: InputDecoration(
                              labelText: ' Folder Name..',
                              labelStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff888888),
                                  fontWeight: FontWeight.w500),
                              fillColor: Color(0xffFAFAFA),
                              filled: true,
                              helperMaxLines: 2,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffc6cad4), width: 1.w),
                                borderRadius: BorderRadius.circular(27).r,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff6F15DE), width: 1.w),
                                borderRadius: BorderRadius.circular(27),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 372.h,
                                minWidth: 53.w,
                              )),
                        ),
                      ),
                      // SizedBox(
                      //   width: 200,
                      //   child: TextField(
                      //     controller: _numberController,
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly
                      //     ],
                      //     onTap: () {},
                      //     onChanged: (String value) {},
                      //     cursorColor: Colors.black,
                      //     cursorRadius: Radius.circular(10).r,
                      //     enabled: true,
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: 16.sp,
                      //         color: Colors.black),
                      //     decoration: InputDecoration(
                      //         labelText: ' Folder Number..',
                      //         labelStyle: TextStyle(
                      //             fontSize: 16.sp,
                      //             fontStyle: FontStyle.italic,
                      //             color: Color(0xff888888),
                      //             fontWeight: FontWeight.w500),
                      //         fillColor: Color(0xffFAFAFA),
                      //         filled: true,
                      //         helperMaxLines: 2,
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Color(0xffc6cad4), width: 1.w),
                      //           borderRadius: BorderRadius.circular(27).r,
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Color(0xff6F15DE), width: 1.w),
                      //           borderRadius: BorderRadius.circular(27),
                      //         ),
                      //         constraints: BoxConstraints(
                      //           maxHeight: 372.h,
                      //           minWidth: 53.w,
                      //         )),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(end: 10, start: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_nameController.text == "") {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .nameAndNumbermustbenotempty, // message
                                toastLength: Toast.LENGTH_SHORT,
                                // length
                                backgroundColor: Colors.red,
                                gravity: ToastGravity.BOTTOM, // location
                                timeInSecForIosWeb: 3 // duration
                                );
                          }
                          CreateFolder(
                            _nameController.text,
                          );
                          _nameController.text = "";
                          _numberController.text = "";
                          Navigator.pushReplacementNamed(
                              context, '/BootomNaviagtionScreen');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.createafolder,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27).r,
                          ),
                          minimumSize: Size(372.w, 53.h),
                          primary: Color(0xffFFB300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
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

  Future<CreateFolderModel?> CreateFolder(
    String name,
  ) async {
    try {
      var url = Uri.parse(ApiSettings.createfolder);
      String token = SharedPrefController().token;
      final formdata = {'name': name};
      var response = await http.post(url, body: formdata, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        var folderObj = jsonDecode(response.body);
        CreateFolderModel folderModel = CreateFolderModel.fromJson(folderObj);
        return folderModel;
      } else {
        print("33333");
      }
    } catch (e) {
      print("eeeeeee $e");
      throw Exception();
    }
  }

  showDialog1() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          var the = ThemeModeHandler.of(context)!.themeMode;
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Container(
              //  color: the == ThemeMode.light ? Colors.white : Color(0xff302A28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Icon(Icons.arrow_back)),
                    ],
                  ),
                  Center(
                      child: Text(
                    AppLocalizations.of(context)!.createafolder,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: _nameController,
                          onTap: () {},
                          onChanged: (String value) {},
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(10).r,
                          enabled: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.black),
                          decoration: InputDecoration(
                              labelText: ' Folder Name..',
                              labelStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff888888),
                                  fontWeight: FontWeight.w500),
                              fillColor: Color(0xffFAFAFA),
                              filled: true,
                              helperMaxLines: 2,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffc6cad4), width: 1.w),
                                borderRadius: BorderRadius.circular(27).r,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff6F15DE), width: 1.w),
                                borderRadius: BorderRadius.circular(27),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 372.h,
                                minWidth: 53.w,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(end: 10, start: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_nameController.text == "") {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .nameAndNumbermustbenotempty, // message
                                toastLength: Toast.LENGTH_SHORT,
                                // length
                                backgroundColor: Colors.red,
                                gravity: ToastGravity.BOTTOM, // location
                                timeInSecForIosWeb: 3 // duration
                                );
                          }
                          CreateFolder(
                            _nameController.text,
                          );
                          _nameController.text = "";
                          _numberController.text = "";
                          Navigator.pushReplacementNamed(
                              context, '/BootomNaviagtionScreen');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.createafolder,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27).r,
                          ),
                          minimumSize: Size(372.w, 53.h),
                          primary: Color(0xffFFB300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
