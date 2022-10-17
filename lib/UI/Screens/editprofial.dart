import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../Api/ApiSettings.dart';
import '../../Api/controller/ProfialApiController.dart';
import '../../Api/model/GetAuth.dart';
import '../../Api/model/update_profile_model.dart';
import '../../Storage/shared_pref_controller.dart';

class EditProfial extends StatefulWidget {
  const EditProfial({Key? key}) : super(key: key);

  @override
  State<EditProfial> createState() => _EditProfialState();
}

class _EditProfialState extends State<EditProfial> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryCodeController = TextEditingController();
  late Future<List<GetAuth>> _future;
  GetAuth user = GetAuth.empty();

  Future<void> getUserData() async {
    await ProfailApiController()
        .readUsers(token: SharedPrefController().token)
        .then((value) {
      if (value != null) {
        user = value.data!;
        // print("USER: ${jsonEncode(user)}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    print(user.name);
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/Login');
                          },
                          child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/Settings');
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: the == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                                size: 18.h,
                              )))),
                  SizedBox(
                    width: 125.w,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: TextStyle(
                        color: the == ThemeMode.light
                            ? Color(0xff6F15DE)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 65.h,
              ),

              /////////
              FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 300.h),
                          child: Text(
                            AppLocalizations.of(context)!.name,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Color(0xff4E4E4E)
                                  : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 20, start: 20),
                          child: TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            onTap: () {},
                            onChanged: (String value) {},
                            cursorColor: Colors.black,
                            cursorWidth: 1.3.w,
                            cursorRadius: Radius.circular(10),
                            enabled: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.black),
                            decoration: InputDecoration(
                                hintText: user.name == null ? "" : user.name!,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w500),
                                fillColor: Color(0xffecedf0),
                                filled: true,
                                helperMaxLines: 2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffc6cad4), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff50535c), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 372.h,
                                  minWidth: 53.w,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 300.h),
                          child: Text(
                            AppLocalizations.of(context)!.emailaddress,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Color(0xff4E4E4E)
                                  : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 20, start: 20),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onTap: () {},
                            onChanged: (String value) {},
                            cursorColor: Colors.black,
                            cursorWidth: 1.3.w,
                            cursorRadius: Radius.circular(10),
                            enabled: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.black),
                            decoration: InputDecoration(
                                hintText: user.email == null ? "" : user.email!,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w500),
                                fillColor: Color(0xffecedf0),
                                filled: true,
                                helperMaxLines: 2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffc6cad4), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff50535c), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 372.h,
                                  minWidth: 53.w,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 300.h),
                          child: Text(
                            AppLocalizations.of(context)!.phoneNumber,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Color(0xff4E4E4E)
                                  : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 20, start: 20),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            onTap: () {},
                            onChanged: (String value) {},
                            cursorColor: Colors.black,
                            cursorWidth: 1.3.w,
                            cursorRadius: Radius.circular(10).r,
                            enabled: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.black),
                            decoration: InputDecoration(
                                hintText: user.phone == null ? "" : user.phone!,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w500),
                                fillColor: Color(0xffecedf0),
                                filled: true,
                                helperMaxLines: 2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffc6cad4), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff50535c), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 372.h,
                                  minWidth: 53.w,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 300.h),
                          child: Text(
                            AppLocalizations.of(context)!.countrycode,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Color(0xff4E4E4E)
                                  : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 20, start: 20),
                          child: TextField(
                            controller: _countryCodeController,
                            keyboardType: TextInputType.number,
                            onTap: () {},
                            onChanged: (String value) {},
                            cursorColor: Colors.black,
                            cursorWidth: 1.3.w,
                            cursorRadius: Radius.circular(10).r,
                            enabled: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: Colors.black),
                            decoration: InputDecoration(
                                hintText:
                                    user.phone == null ? "" : user.ipCode!,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w500),
                                fillColor: Color(0xffecedf0),
                                filled: true,
                                helperMaxLines: 2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffc6cad4), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff50535c), width: 1.w),
                                  borderRadius: BorderRadius.circular(27).r,
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 372.h,
                                  minWidth: 53.w,
                                )),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  else
                    return Container(
                      child: Text(
                        AppLocalizations.of(context)!.nodatanow,
                      ),
                    );
                },
              ),

//////////

              SizedBox(
                height: 60.h,
              ),

              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      UpdateProfile(
                          _nameController.text == ""
                              ? user.name!
                              : _nameController.text,
                          _emailController.text == ""
                              ? user.email!
                              : _emailController.text,
                          _phoneController.text == ""
                              ? user.phone!
                              : _phoneController.text,
                          _countryCodeController.text == ""
                              ? user.ipCode!
                              : _countryCodeController.text);
                    },
                    child: Text(
                      '  Edit Profile',
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

  Future<UpdateProfileModel?> UpdateProfile(
    String name,
    String email,
    String phone,
    String countryCode,
  ) async {
    try {
      var url = Uri.parse(ApiSettings.updateprofile);
      String token = SharedPrefController().token;
      final param = {
        'name': name,
        'email': email,
        "phone": phone,
        "ip_code": countryCode,
      };
      var response = await http.post(url,
          body: param,
          headers:
              // {
              //   "Authorization": "Bearer 93|spPrEww5geKfukKnTfkdMcn4BDKxsH2SBpUBppeh"
              // }
              headers);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        var folderObj = jsonDecode(response.body);
        UpdateProfileModel folderModel = UpdateProfileModel.fromJson(folderObj);
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
