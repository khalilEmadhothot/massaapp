import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/UI/Screens/search_screen/search_screen.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../../test1.dart';
import '../../../theme_notifier.dart';
import '../Sort/ScreenVideo.dart';
import '../Sort/gride_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeManager mode = ThemeManager();

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    print("lllllllllll");
    print("$the");
    print("${mode.loadThemeMode().toString()}");
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      // mode.loadThemeMode() == "light" ? Colors.white : Color(0xff322D2B),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 13, end: 13, top: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/Settings');
                        },
                        child: Container(
                          width: 100.w,
                          height: 45.h,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            color: Color(0xff6F15DE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp,
                            ),
                          ),
                        ),
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
                              size: 18.sp,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15, top: 33),
                child: Text(
                  AppLocalizations.of(context)!.myFiles,
                  style: TextStyle(
                      color:
                          the == ThemeMode.light ? Colors.black : Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonsTabBar(
                    height: 65,
                    backgroundColor: const Color(0xffFFB300),
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: const TextStyle(
                        color: Color(0xffD1D1D1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(
                        icon: Container(
                            alignment: AlignmentDirectional.topStart,
                            width: 10,
                            height: 50,
                            child: const Icon(
                              Icons.add,
                              color: Colors.transparent,
                            )),
                        text: "    All      ",
                      ),
                      Tab(
                        icon: Icon(
                          Icons.image,
                        ),
                        text: AppLocalizations.of(context)!.image,
                      ),
                      Tab(
                        icon: Icon(Icons.videocam),
                        text: AppLocalizations.of(context)!.video,
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Test1(),
                    GrideView(),
                    ScreenVideo(),
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
