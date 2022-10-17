import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({
    Key? key, required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
      child: TextField(
        //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        obscuringCharacter: '#',

        onTap: () {},
        onChanged: (String value) {},
        cursorColor: Colors.black,
        cursorWidth: 1.3.w,
        cursorRadius: Radius.circular(10),
        enabled: true,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
        maxLength: 35,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
                color: Color(0xff888888),
                fontWeight: FontWeight.w500),
            fillColor: Color(0xffecedf0),
            filled: true,
            helperMaxLines: 2,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc6cad4), width: 1.w),
              borderRadius: BorderRadius.circular(27),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff50535c), width: 1.w),
              borderRadius: BorderRadius.circular(27),
            ),
            constraints: BoxConstraints(
              maxHeight: 372.h,
              minWidth: 53.w,
            )),
      ),
    );
  }
}
