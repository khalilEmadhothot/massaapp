import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      //Language
      String rout = SharedPrefController().loggedin
          ? '/BootomNaviagtionScreen'
          : '/Language';
      print("ROUTE: $rout");
      Navigator.pushReplacementNamed(context, rout);
// Navigator.pushReplacementNamed(context, '/Login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'images/Logo.png',
            fit: BoxFit.contain,
            width: double.infinity.w,
            height: 250.h,
          ),
        ],
      ),
    );
  }
}
