import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../Api/controller/ProfialApiController.dart';
import '../../Api/model/GetAuth.dart';

class Profial extends StatefulWidget {
  Profial({Key? key}) : super(key: key);

  @override
  State<Profial> createState() => _ProfialState();
}

class _ProfialState extends State<Profial> {
  late Future<List<GetAuth>> _future;
  GetAuth user = GetAuth.empty();

  @override
  void initState() {
    super.initState();

    // _future = UserApiController().readUsers();
  }

  Future<void> getUserData() async {
    print("getUserData TOKEN: ${SharedPrefController().token}");
    await ProfailApiController()
        .readUsers(token: SharedPrefController().token)
        .then((value) {
      if (value != null) {
        user = value.data!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.w,
                  ),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/BootomNaviagtionScreen');
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: the == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            size: 20.h,
                          ))),
                  SizedBox(
                    width: 125.w,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                        color: the == ThemeMode.light
                            ? Color(0xff6F15DE)
                            : Colors.white,
                        //  color: Color(0xff6F15DE),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              // 'images/circule.png'
              // CircleAvatar(
              //   radius: (52).r,
              //   backgroundColor: Color(0xff6F15DE),
              //   child: Image.asset('images/Image_circual.png'),
              // ),
              SizedBox(
                height: 15.h,
              ),
              FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 0, top: 15),
                      child: Column(
                        children: [
                          // Text(
                          //   user.name!,
                          //   style: TextStyle(
                          //     fontSize: 18.sp,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          //
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsetsDirectional.only(
                          //       start: 20, end: 20),
                          //   child: Container(
                          //     width: 400.w,
                          //     height: 320.h,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffFFB300),
                          //       borderRadius: BorderRadius.circular(12).r,
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //           height: 15.h,
                          //         ),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsetsDirectional.only(
                          //                   start: 15),
                          //               child: Text(
                          //                 AppLocalizations.of(context)!.data,
                          //                 style: TextStyle(
                          //                   fontSize: 18.sp,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.black,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         Divider(
                          //           indent: 10.r,
                          //           endIndent: 10.r,
                          //           color: Color(0xffCBCBCB),
                          //           thickness: 1,
                          //         ),
                          //         SizedBox(
                          //           height: 20.h,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsetsDirectional.only(
                          //               start: 30, end: 30),
                          //           child: TextField(
                          //             keyboardType: TextInputType.name,
                          //             decoration: InputDecoration(
                          //               enabled: true,
                          //               hintText: user.name!,
                          //               filled: true,
                          //               fillColor: Color(0xffF6F6F6),
                          //               hintStyle: TextStyle(
                          //                 color: Colors.grey,
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: Colors.grey.shade100,
                          //                     width: 1.w),
                          //                 borderRadius:
                          //                     BorderRadius.circular(12).r,
                          //               ),
                          //               constraints: BoxConstraints(
                          //                 maxWidth: 420.w,
                          //                 maxHeight: 60.h,
                          //               ),
                          //               focusedBorder: UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                   color: Colors.black,
                          //                   width: 1.w,
                          //                 ),
                          //               ),
                          //             ),
                          //             textDirection: TextDirection.rtl,
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 10.h,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsetsDirectional.only(
                          //               start: 30, end: 30),
                          //           child: TextField(
                          //             keyboardType: TextInputType.emailAddress,
                          //             decoration: InputDecoration(
                          //               enabled: true,
                          //               hintText: user.email!,
                          //               filled: true,
                          //               fillColor: Color(0xffF6F6F6),
                          //               hintStyle: const TextStyle(
                          //                 color: Colors.grey,
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: Colors.grey.shade100,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(12.r),
                          //               ),
                          //               constraints: BoxConstraints(
                          //                 maxWidth: 420.w,
                          //                 maxHeight: 60.h,
                          //               ),
                          //               focusedBorder: UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                   color: Colors.black,
                          //                   width: 1.w,
                          //                 ),
                          //               ),
                          //             ),
                          //             textDirection: TextDirection.rtl,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, end: 30),
                            child: Container(
                              width: double.infinity,
                              height: 65.h,
                              child: Card(
                                elevation: 5,
                                clipBehavior: Clip.antiAlias,
                                color: the == ThemeMode.light
                                    ? Colors.white
                                    : Colors.black26,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.fullName,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Color(0xff6F15DE),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Text(
                                        user.name!,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: the == ThemeMode.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, end: 30),
                            child: Container(
                              width: double.infinity,
                              height: 65.h,
                              child: Card(
                                elevation: 5,
                                clipBehavior: Clip.antiAlias,
                                color: the == ThemeMode.light
                                    ? Colors.white
                                    : Colors.black26,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.email,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Color(0xff6F15DE),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Text(
                                        user.email!,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: the == ThemeMode.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, end: 30),
                            child: Container(
                              width: double.infinity,
                              height: 65.h,
                              child: Card(
                                elevation: 5,
                                clipBehavior: Clip.antiAlias,
                                color: the == ThemeMode.light
                                    ? Colors.white
                                    : Colors.black26,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .phoneNumber,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Color(0xff6F15DE),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Text(
                                        user.phone!,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: the == ThemeMode.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, end: 30),
                            child: Container(
                              width: double.infinity,
                              height: 65.h,
                              child: Card(
                                elevation: 5,
                                clipBehavior: Clip.antiAlias,
                                color: the == ThemeMode.light
                                    ? Colors.white
                                    : Colors.black26,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.gender,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Color(0xff6F15DE),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Text(
                                        user.gender! == "1"
                                            ? AppLocalizations.of(context)!.male
                                            : AppLocalizations.of(context)!
                                                .female,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: the == ThemeMode.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
