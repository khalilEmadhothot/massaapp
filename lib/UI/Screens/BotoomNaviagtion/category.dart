import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../Sort/Date.dart';
import '../Sort/StoragePlace.dart';
import '../search_screen/search_screen.dart';

class Category extends StatefulWidget {
  final String? date;
  final String? time;
  final String? url;
  final String? comment;
  dynamic lat;
  dynamic long;

  Category(
      {this.date,
      this.time,
      this.url,
      this.comment,
      this.lat,
      this.long,
      Key? key})
      : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // String textTabOne = "One Shot";
  // String textTabTwo = "";
  String textTabThree = "";
  String textTabFour = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 2, end: 13, top: 15),
                child: Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Home(),
                            //   ),
                            // );
                            Navigator.pushReplacementNamed(
                                context, '/BootomNaviagtionScreen');
                            // Navigator.pushReplacementNamed(context, '/Home');
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 18.h,
                            color: the == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          )),
                      Spacer(),
                      Container(
                          width: 38.w,
                          height: 38.h,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            color: Color(0xff6F15DE),
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                          child: Icon(
                            Icons.more_vert_sharp,
                            size: 19.h,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return SearchScreen();
                          }));
                        },
                        child: Container(
                            width: 38.w,
                            height: 38.h,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: Color(0xff6F15DE),
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            child: Icon(
                              Icons.search,
                              size: 18.h,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context)!.sortBy,
                  style: TextStyle(
                      color:
                          the == ThemeMode.light ? Colors.black : Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15),
                      child: ButtonsTabBar(
                        backgroundColor: const Color(0xff6F15DE),
                        unselectedBackgroundColor: const Color(0xffF2F2F2),
                        unselectedLabelStyle: const TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp),
                        tabs: [
                          // Tab(
                          //   icon: Container(
                          //     alignment: AlignmentDirectional.center,
                          //     width: 35,
                          //     height: 50,
                          //     child: Icon(
                          //       Icons.filter_none_outlined,
                          //       size: 25.h,
                          //     ),
                          //   ),
                          //   text: "$textTabOne",
                          // ),
                          // Tab(
                          //   icon: Container(
                          //     alignment: AlignmentDirectional.center,
                          //     width: 50,
                          //     height: 50,
                          //     child: Icon(
                          //       Icons.list,
                          //       size: 25.h,
                          //     ),
                          //   ),
                          //   text: "$textTabTwo",
                          // ),
                          Tab(
                            icon: Container(
                              alignment: AlignmentDirectional.center,
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.access_time_outlined,
                                size: 25.h,
                              ),
                            ),
                            text: "$textTabThree",
                          ),
                          Tab(
                            icon: Container(
                              alignment: AlignmentDirectional.center,
                              width: 35,
                              height: 50,
                              child: Icon(
                                Icons.folder_outlined,
                                size: 25.h,
                              ),
                            ),
                            text: "$textTabFour",
                          ),
                        ],
                        onTap: (index) {
                          print("onTap: $index");
                          // if (index == 0) {
                          //   setState(() {
                          //     // textTabOne = "One Shot";
                          //     // textTabTwo = "";
                          //     textTabThree = "";
                          //     textTabFour = "";
                          //   });
                          // } else if (index == 1) {
                          //   setState(() {
                          //     textTabOne = "";
                          //     textTabTwo = "List";
                          //     textTabThree = "";
                          //     textTabFour = "";
                          //   });
                          // } else
                          if (index == 0) {
                            setState(() {
                              // textTabOne = "";
                              // textTabTwo = "";
                              textTabThree = AppLocalizations.of(context)!.data;
                              textTabFour = "";
                            });
                          } else if (index == 1) {
                            setState(() {
                              // textTabOne = "";
                              // textTabTwo = "";
                              textTabThree = "";
                              textTabFour = AppLocalizations.of(context)!.data;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => GoogleMaps(
                    //           lat: widget.lat,
                    //           long: widget.long,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //       width: 40.w,
                    //       height: 40.h,
                    //       alignment: AlignmentDirectional.center,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffFFB300),
                    //         borderRadius: BorderRadius.circular(10).r,
                    //       ),
                    //       child: Icon(
                    //         Icons.location_on,
                    //         size: 22.h,
                    //         color: Colors.white,
                    //       )),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    // OneShot(
                    //   time: widget.time,
                    //   date: widget.date,
                    //   url: widget.url,
                    //   comment: widget.comment,
                    //   lat: widget.lat,
                    //   long: widget.long,
                    // ),
                    // OneShot(),
                    // Test1(),
                    Date(),
                    StoragePlace(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
