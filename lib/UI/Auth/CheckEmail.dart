import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/UI/Widget/Button.dart';
class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
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
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: InkWell(
                      onTap: (){

                        Navigator.pushReplacementNamed(context, '/Login');
                      },
                      child: Icon(Icons.arrow_back_ios,color: Color(0xff6F15DE),size: 22.h,))),
            ),
            SizedBox(
              height: 108.h,
            ),
            Align(
                alignment: AlignmentDirectional.center,
                child: Image.asset(
                  'images/Logo.png',
                  height: 160.h,
                )),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text('Check your email',style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff6F15DE),

              ),),
            ),
            SizedBox(
              height: 25.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text('We have sent password recovery instructions to \n your email.',style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.3.h

              ),),
            ),
            SizedBox(
              height: 80.h,
            ),
            Button(TexT: 'Open the email'),
            SizedBox(
              height: 24.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text('Skip , I  ll confirm later',style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,

              ),),
            ),
            SizedBox(
              height: 63.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text('Did you receive the email? Check your spam filter,',style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),),
            ),
            SizedBox(
              height: 3.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(' try another email address',style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff6F15DE),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
