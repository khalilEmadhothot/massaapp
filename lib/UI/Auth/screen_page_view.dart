import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/widget_container_page_view.dart';
import '../Widget/widget_pageView.dart';

class ScreenPageView extends StatefulWidget {
  const ScreenPageView({Key? key}) : super(key: key);

  @override
  State<ScreenPageView> createState() => _ScreenPageViewState();
}

class _ScreenPageViewState extends State<ScreenPageView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
Expanded(
  child:   PageView(
    controller: _pageController,
    scrollDirection: Axis.horizontal,
    onPageChanged: (int page) {
      setState(() {
        _currentPage = page;
      });
    },
    children: [
widget_pageView(title: ' The memories  application saves the most beautiful \n memories of your beautiful travels, and there  are \n many advantages in this application. Register now', Imagee: 'images/Logo.png',),
      widget_pageView(title: ' The memories  application saves the most beautiful \n memories of your beautiful travels, and there  are \n many advantages in this application. Register now', Imagee: 'images/Logo.png',),
      widget_pageView(title: ' The memories  application saves the most beautiful \n memories of your beautiful travels, and there  are \n many advantages in this application. Register now', Imagee: 'images/Logo.png',),
    ],

  ),
),
          Visibility(

            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 40,end: 40,top: 700),
              child: ElevatedButton(
                onPressed: ()  {
                  Navigator.pushReplacementNamed(context, '/Language');
                },
                child: Text(
                  'CONTINUE',
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
                  minimumSize: Size(372.w
                      , 53.h),
                  primary: Color(0xffFFB300),
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsetsDirectional.only(top: 300,start: 117),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Row(

                children: [
                  widget_container_page_view(title: '1', selected: _currentPage == 0,),
                  SizedBox(width: 5.w,),
                  Container(
                    width: 20.w,
                    height: 2.h
                    ,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2).r,
                      border: Border.all(
                        width: 1.7.w

                        ,
                        color: Color(0xffF7F7F8),
                      )
                    ),
                  ),
                  SizedBox(width: 5.w

                    ,),
                  widget_container_page_view(title: '2',selected: _currentPage == 1,),
                  SizedBox(width: 5.w
                    ,),
                  Container(
                    width: 20.w
                    ,
                    height: 2.h
                    ,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2).r,
                        border: Border.all(
                          width: 1.7.w

                          ,
                          color: Color(0xffF7F7F8),
                        )
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  widget_container_page_view(title: '3', selected: _currentPage == 2,),
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}




