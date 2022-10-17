import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Api/model/GetAuth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TT extends StatefulWidget {
  const TT({Key? key})
      : super(
          key: key,
        );

  @override
  State<TT> createState() => _TTState();
}

class _TTState extends State<TT> {
  late GetAuth user;
  late TextEditingController _namecontroller;
  late TextEditingController _emailcontroller;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/Login');
                      },
                      child: Icon(
                        // CupertinoIcons.arrow_left,
                        Icons.arrow_back_ios,
                        color: Colors.black, size: 20.h,
                      ))),
              SizedBox(
                width: 125.w,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  AppLocalizations.of(context)!.profile,
                  style: TextStyle(
                    color: Color(0xff6F15DE),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
          ),
          // 'images/circule.png'
          CircleAvatar(
            radius: (52).r,
            backgroundColor: Color(0xff6F15DE),
            child: Image.asset('images/Image_circual.png'),
          ),

          SizedBox(
            height: 15.h,
          ),
          Column(
            children: [
              Text(
                user.name!,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: Container(
                  width: 400.w,
                  height: 320.h,
                  decoration: BoxDecoration(
                    color: Color(0xffFFB300),
                    borderRadius: BorderRadius.circular(12).r,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 15),
                            child: Text(
                             AppLocalizations.of(context)!.data,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 10.r,
                        endIndent: 10.r,
                        color: Color(0xffCBCBCB),
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 30, end: 30),
                        child: TextField(
                          controller: _namecontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabled: true,
                            hintText: 'Khalil Emad HotHot ',
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100, width: 1.w),
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 420.w,
                              maxHeight: 60.h,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 30, end: 30),
                        child: TextField(
                          controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabled: true,
                            hintText: ' hm122qa@gmail.com',
                            filled: true,
                            fillColor: Color(0xffF6F6F6),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100, width: 1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 420.w,
                              maxHeight: 60.h,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
