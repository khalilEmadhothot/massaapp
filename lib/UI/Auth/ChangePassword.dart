import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/UI/Widget/Button.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h,
            ),
            Row(
              children: [
                SizedBox(width: 25.w,),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: InkWell(
                        onTap: (){

                          Navigator.pushReplacementNamed(context, '/Login');
                        },
                        child: Icon(Icons.arrow_back_ios,color: Color(0xff6F15DE),size: 22.h,))),
                SizedBox(width: 70.w,),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    ' Change Password',
                    style: TextStyle(
                      color: Color(0xff6F15DE),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ),


              ],
            ),
            SizedBox(
              height: 150.h,
            ),
            Padding(
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
                    labelText: '  write old password here',
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
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
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
                    labelText: '  write new password here',
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
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
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
                    labelText: '  write confirm password here',
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
            ),
            SizedBox(
              height: 100.h,
            ),
            Button(TexT: 'Open the email'),
          ],
        ),
      ),
    );
  }
}
