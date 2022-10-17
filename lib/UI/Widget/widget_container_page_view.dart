import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class widget_container_page_view extends StatelessWidget {
  const widget_container_page_view({
    Key? key,
    required this.selected,
    required this.title,
  }) : super(key: key);

  final bool selected;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width:30.w
      ,
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15).r,
        color: selected ? const Color(0xFF6F15DE) : Colors.grey.shade400,
      ),
      child: Text(title,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
      ),),
    );
  }
}