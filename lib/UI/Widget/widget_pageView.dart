import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class widget_pageView extends StatelessWidget {
  const widget_pageView({
    Key? key,
    required this.title,
    required this.Imagee,
  }) : super(key: key);

  final String title;
  final String Imagee;
  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Column(
      children: [
        SizedBox(
          height: 160.h,
        ),
        Image.asset(
          Imagee,
          fit: BoxFit.contain,
          width: double.infinity,
          height: 250.h,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 40, start: 3),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color:
                      the == ThemeMode.light ? Color(0xff4E4E4E) : Colors.white,
                  height: 1.5.h),
            ),
          ),
        ),
      ],
    );
  }
}

// 'images/page_view.png'
// 'Want a walking group? Walk friends! It is a  \n community of thousands of members that \n connects girls to create walking groups.'
