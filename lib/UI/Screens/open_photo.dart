import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class openphoto extends StatefulWidget {
  const openphoto({Key? key}) : super(key: key);

  @override
  State<openphoto> createState() => _openphotoState();
}

class _openphotoState extends State<openphoto> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Colors.white,
  body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h,),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 13,end: 13,top: 15),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w
                  ,
                  height: 45.h,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: Color(0xff6F15DE),
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Text('LOGO',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.sp,

                  ),),
                ),
                Container(
                    width: 38.w,
                    height: 38.h,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6F15DE),
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/BootomNaviagtionScreen');
                        },
                        child: Icon(Icons.arrow_forward_ios,size: 15.h,color: Colors.white,))
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 20),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              width:255.w ,
              height: 50.h ,
              decoration: BoxDecoration(
                color: Color(0xffFFB300),
                borderRadius: BorderRadius.circular(25).r,
              ),
              child:     Padding(
                padding: const EdgeInsetsDirectional.only(start: 10,end: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range,color: Colors.white,size: 18.h
                          ,),
                        SizedBox(width: 5.w,),
                        Text('5/8/2021',style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timelapse_sharp,color: Colors.white,size: 18.h,),
                        SizedBox(width: 5.w,),
                        Text('7:12 Pm',style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.w
          ,),
        Container(
          width: double.infinity,
          height: 200.h,
          child: Image.asset('images/map.png',fit: BoxFit.contain,width: double.infinity,height: double.infinity,),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 18,end: 18),
          child: Container(

            width: double.infinity,
            height: 360.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(62).r
                ,
              color: Color(0xffFAFAFA),
              border: Border.all(
                color: Color(0xffDADADA),
                width: 0.3.w

              )
            ),
            child: Stack(
              children: [
Image.asset('images/screen_image.png',height: 350.h
  ,width: double.infinity,),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 230),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:103.w
                          ,
                          height:43.h
                          ,
                          decoration: BoxDecoration(
                            color: Color(0xffFFB300),
                            borderRadius: BorderRadius.circular(12).r
                            ,
                          ),
                          child: Icon(Icons.arrow_back_ios,size: 18.h,color: Colors.white,),
                        ),
                        SizedBox(width: 10.w,),
                        Container(
                          width:103.w
                          ,
                          height:43.h
                          ,
                          decoration: BoxDecoration(
                            color: Color(0xff6F15DE),
                            borderRadius: BorderRadius.circular(12).r
                            ,
                          ),
                          child: Icon(Icons.arrow_forward_ios,size: 18.sp,color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 320),
                  child: Positioned(
                    bottom: 0,
                    child: Text('      ',style: TextStyle(
                      color: Color(0xff7B7B7B),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 85.h
          ,),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Card(
            elevation: 7,
            color: Colors.white,
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,

              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child:   Container(
                        alignment: AlignmentDirectional.centerStart,

                        width: 290.w
                        ,

                        height: 40.h
                        ,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30).r
                          ,

                          border: Border.all(

                              color: Color(0xffC6C6C6),

                              width: 1.w


                          ),

                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: Text(AppLocalizations.of(context)!.writeComment,style: TextStyle(
                              color: Color(0xff4E4E4E)
                          ),),
                        ),

                      ),
                    ),
                    Container(
                      width: 40.w
                      ,
                      height: 40.h
                      ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30).r
                        ,
                        color: Color(0xffFFB300),
                      ),
                      child: Icon(Icons.send,size: 20.h
                        ,color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}
