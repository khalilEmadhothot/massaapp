import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../Storage/shared_pref_controller.dart';
import '../../provider/language_provider.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
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
          Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                'images/Logo.png',
                fit: BoxFit.contain,
                width: double.infinity.w,
                height: 250.h,
              )),
          SizedBox(
            height: 150.h,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage();
                  String rout = SharedPrefController().loggedin
                      ? '/BootomNaviagtionScreen'
                      : '/Login';
                  Navigator.pushReplacementNamed(context, rout);
                },
                child: Text(
                  'العربية',
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
            height: 35.h,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguageE();
                  String rout = SharedPrefController().loggedin
                      ? '/BootomNaviagtionScreen'
                      : '/Login';
                  Navigator.pushReplacementNamed(context, rout);
                },
                child: Text(
                  'English',
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
    );
  }
}
