import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class AppMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: Column(
        children: [
          SizedBox(
            height: 70.h,
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
                width: 80.w,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  AppLocalizations.of(context)!.applicationMode,
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
            height: 54.h,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: InkWell(
              onTap: () {
                ThemeModeHandler.of(context)!.saveThemeMode(ThemeMode.light);
              },
              child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    // color: Colors.white,//1
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              width: 40.w,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10).r),
                              child: InkWell(
                                  child: const Icon(
                                Icons.change_circle,
                                color: Color(0xff6F15DE),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          InkWell(
                            child: Text(
                              AppLocalizations.of(context)!.lightMode,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: the == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          // InkWell(
          //   onTap: () => {
          //     print('Set Light theme'),
          //     ThemeModeHandler.of(context)!.saveThemeMode(ThemeMode.light),
          //     // theme.setLightMode(),
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 22),
          //     child: Row(
          //       children: [
          //         Container(
          //           width: 40.w,
          //           height: 40.sp,
          //           decoration: BoxDecoration(
          //               shape: BoxShape.rectangle,
          //               color: Colors.white,
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.5),
          //                   blurRadius: 7,
          //                   offset: Offset(0, 3), // changes position of shadow
          //                 ),
          //               ],
          //               borderRadius: BorderRadius.circular(10).r),
          //           child: const Icon(
          //             Icons.change_circle,
          //             color: Color(0xff6F15DE),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 20.w,
          //         ),
          //         Text(
          //           AppLocalizations.of(context)!.lightMode,
          //           style: TextStyle(
          //             fontSize: 18.sp,
          //             fontWeight: FontWeight.w400,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: InkWell(
              onTap: () {
                ThemeModeHandler.of(context)!.saveThemeMode(ThemeMode.dark);
              },
              child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    // color: Colors.white,//1
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              width: 40.w,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10).r),
                              child: InkWell(
                                  child: const Icon(
                                Icons.change_circle,
                                color: Color(0xff6F15DE),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          InkWell(
                            child: Text(
                              AppLocalizations.of(context)!.darkMode,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: the == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          // InkWell(
          //   onTap: () => {
          //     print('Set Dark theme'),
          //     ThemeModeHandler.of(context)!.saveThemeMode(ThemeMode.dark),
          //     // theme.setDarkMode(),
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 22),
          //     child: Row(
          //       children: [
          //         Container(
          //           width: 40.w,
          //           height: 40.sp,
          //           decoration: BoxDecoration(
          //               shape: BoxShape.rectangle,
          //               color: Colors.white,
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.5),
          //                   blurRadius: 7,
          //                   offset: Offset(0, 3), // changes position of shadow
          //                 ),
          //               ],
          //               borderRadius: BorderRadius.circular(10).r),
          //           child: const Icon(
          //             Icons.change_circle,
          //             color: Color(0xff6F15DE),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 20.w,
          //         ),
          //         Text(
          //           AppLocalizations.of(context)!.darkMode,
          //           style: TextStyle(
          //             fontSize: 18.sp,
          //             fontWeight: FontWeight.w400,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    // home: Scaffold(
    //   appBar: AppBar(
    //     title: Text('Hybrid Theme'),
    //   ),
    //   body: Row(
    //     children: [
    //       Container(
    //         child: FlatButton(
    //           onPressed: () => {
    //             print('Set Light Theme'),
    //             theme.setLightMode(),
    //           },
    //           child: Text('Set Light Theme'),
    //         ),
    //       ),
    //       Container(
    //         child: FlatButton(
    //           onPressed: () => {
    //             print('Set Dark theme'),
    //             theme.setDarkMode(),
    //           },
    //           child: Text('Set Dark theme'),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    //   ),
    // );
  }
}
