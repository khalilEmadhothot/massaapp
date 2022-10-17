import 'package:flutter/material.dart';

mixin Helpers {

  void showSnackBar(BuildContext context, {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(message),
        backgroundColor:error? Colors.red : Color(0xff6F15DE),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}