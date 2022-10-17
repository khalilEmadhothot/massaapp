import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.TexT,
  }) : super(key: key);
  final String TexT;

  @override
  Widget build(BuildContext context) {
    return
      Align(
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
        child: ElevatedButton(
          onPressed: () async {},
          child: Text(
            TexT,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27),
            ),
            minimumSize: Size(372.w, 53.h),
            primary: Color(0xffFFB300),
          ),
        ),
      ),
    );
  }
}
