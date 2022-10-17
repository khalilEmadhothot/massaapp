import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/UI/Screens/Settings.dart';
import 'package:massa_app/UI/Screens/camera.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import '../profial.dart';
import 'Home.dart';
import 'category.dart';

class BootomNaviagtionScreen extends StatefulWidget {
  const BootomNaviagtionScreen({Key? key}) : super(key: key);

  @override
  State<BootomNaviagtionScreen> createState() => _BootomNaviagtionScreenState();
}

class _BootomNaviagtionScreenState extends State<BootomNaviagtionScreen> {
  int _currentIndex = 0;
  List<IconData> listIcoNS = [
    Icons.home,
    Icons.grid_view,
    Icons.person_outline_rounded,
    Icons.settings,
  ];
  final _screen = [
    Home(),
    Category(),
    Profial(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Color(0xffF5F5F5) : Color(0xff302A28),
      // backgroundColor: Color(0xffF5F5F5),
      body: _screen[_currentIndex], //destination screen
      floatingActionButton: InkWell(
        onTap: () {
          Camera();
        },
        child: FloatingActionButton(
          child: Icon(Icons.camera_alt_outlined),
          backgroundColor: Color(0xff6F15DE),
          onPressed: () {
            Navigator.pushNamed(context, '/UploadImages');
          },
          //params
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        // icons: listIcoNS,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Color(0xff6F15DE) : Color(0xff2F2F2F);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                listIcoNS[index],
                size: 26.sp,
                color: color,
              ),
              const SizedBox(height: 4),
            ],
          );
        },
        itemCount: listIcoNS.length,
        //other params
      ),
    );
  }
}
