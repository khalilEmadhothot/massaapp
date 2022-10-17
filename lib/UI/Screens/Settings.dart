import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/language_provider.dart';
import '../../theme_notifier.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Uri _url = Uri.parse('whatsapp://send?phone=+972 598 113 864');
  TextEditingController _commentController = TextEditingController();
  ThemeManager mode = ThemeManager();
  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    // return Consumer<ThemeNotifier>(
    //   builder: (context, theme, _) => MaterialApp(
    //     theme: theme.getTheme() != null ? theme.getTheme() : theme.getTheme(),
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: 125.w,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    AppLocalizations.of(context)!.setting,
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
                  Navigator.pushReplacementNamed(context, '/EditProfial');
                },
                child: Container(
                    width: double.infinity,
                    height: 65.h,
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      // color: Colors.white,//1
                      color: the == ThemeMode.light
                          ? Colors.white
                          : Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/EditProfial');
                              },
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
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/EditProfial');
                                    },
                                    child: const Icon(
                                      Icons.photo_camera_front_rounded,
                                      color: Color(0xff6F15DE),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/EditProfial');
                              },
                              child: Text(
                                AppLocalizations.of(context)!.editProfile,
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
            SizedBox(
              height: 25.h,
            ),

            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/AppMode');
                },
                child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/AppMode');
                        },
                        child: Row(
                          children: [
                            Container(
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
                              child: const Icon(
                                Icons.change_circle,
                                color: Color(0xff6F15DE),
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Text(
                              AppLocalizations.of(context)!.applicationMode,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: the == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25.h,
            ),

            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: InkWell(
                onTap: () {
                  changeLanguage();
                },
                child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            changeLanguage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(10).r),
                                  child: const Icon(
                                    Icons.language,
                                    color: Color(0xff6F15DE),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.w,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.language,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: the == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: InkWell(
                onTap: () async {
                  _launchUrl();
                },
                child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10).r),
                            child: InkWell(
                                onTap: () async {
                                  _launchUrl();
                                },
                                child: const Icon(
                                  Icons.whatsapp,
                                  color: Color(0xff6F15DE),
                                )),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Text(
                            AppLocalizations.of(context)!.whatsApp,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: the == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: InkWell(
                onTap: () async {
                  logOut();
                },
                child: Container(
                  width: double.infinity,
                  height: 65.h,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    color:
                        the == ThemeMode.light ? Colors.white : Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              logOut();
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.h,
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                  onTap: () async {
                                    ApiResponse apiresponse =
                                        await AuthApiController().logout();
                                    if (apiresponse.success) {
                                      Navigator.pushReplacementNamed(
                                          context, '/Login');
                                    }
                                  },
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: Color(0xff6F15DE),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          InkWell(
                            onTap: () async {
                              logOut();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.logout,
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
                  ),
                ),
              ),
            ),

            //////////

            //////////
          ],
        ),
      ),
    );
    // ),
    // );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  void changeLanguage() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.changelanguage),
          content: Text(AppLocalizations.of(context)!
              .areyousureyouwanttochangethelanguage),
          actions: [
            CupertinoDialogAction(
                child: const Text("English"),
                onPressed: () async {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguageE();
                  Navigator.pushReplacementNamed(context, '/Settings');
                }),
            CupertinoDialogAction(
              child: const Text("العربية"),
              onPressed: () async {
                Provider.of<LanguageProvider>(context, listen: false)
                    .changeLanguage();
                Navigator.pushReplacementNamed(context, '/Settings');
              },
            )
          ],
        );
      },
    );
  }

  void logOut() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Logout "),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () async {
                  ApiResponse apiresponse = await AuthApiController().logout();
                  if (apiresponse.success) {
                    Navigator.pushReplacementNamed(context, '/Login');
                  }
                  //  Navigator.of(context).pop();
                }),
            CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  // void appMode() {
  //   showCupertinoDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (context) {
  //       return CupertinoAlertDialog(
  //         title: const Text("Application Mode "),
  //         content: const Text("choose your favouit made !"),
  //         actions: [
  //           CupertinoDialogAction(
  //               child: const Text("Dark"),
  //               onPressed: () async {
  //                 theme.setDarkMode();
  //                 Navigator.pushReplacementNamed(context, '/Login');
  //
  //                 //  Navigator.of(context).pop();
  //               }),
  //           CupertinoDialogAction(
  //             child: const Text("Light"),
  //             onPressed: () {
  //               theme.setLightMode();
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
