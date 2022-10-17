import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../utils/helpers.dart';
import '../Widget/code_text_field.dart';

class VerifiedEmailScreen extends StatefulWidget {
  @override
  State<VerifiedEmailScreen> createState() => _VerifiedEmailScreenState();
}

class _VerifiedEmailScreenState extends State<VerifiedEmailScreen>
    with Helpers {
  String _code = '';

  // late TextEditingController _newPasswordTextController;
  // late TextEditingController _newPasswordConfirmationTextController;
  //
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  //
  // late TextEditingController _emailTextController;
  // late TextEditingController _passwordTextController;
  // late TextEditingController _passwordConfirmTextController;
  // late TextEditingController _codeTextController;
  //
  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  @override
  void initState() {
    super.initState();
    // _newPasswordTextController = TextEditingController();
    // _newPasswordConfirmationTextController = TextEditingController();
    //
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    //
    // _emailTextController = TextEditingController(text: widget.email);
    // _passwordTextController = TextEditingController();
    // _passwordConfirmTextController = TextEditingController();
    // _codeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // _newPasswordTextController.dispose();
    // _newPasswordConfirmationTextController.dispose();
    //
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            SizedBox(
              height: 100.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            Text(
              AppLocalizations.of(context)!.verifiedemail,
              style: TextStyle(
                color: Color(0xff6F15DE),
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              AppLocalizations.of(context)!.chcekemail,
              style: TextStyle(
                color: the == ThemeMode.light ? Colors.black : Colors.white,
                fontWeight: FontWeight.w300,
                height: 1.h,
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              SharedPrefController().email ?? 'Create Account First',
              style: TextStyle(
                color: the == ThemeMode.light ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(height: 70),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: CodeTextField(
                      textEditingController: _firstCodeTextController,
                      focusNode: _firstFocusNode,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _secondFocusNode.requestFocus();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: CodeTextField(
                    textEditingController: _secondCodeTextController,
                    focusNode: _secondFocusNode,
                    onChanged: (String value) {
                      value.isNotEmpty
                          ? _thirdFocusNode.requestFocus()
                          : _firstFocusNode.requestFocus();
                    },
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: CodeTextField(
                    textEditingController: _thirdCodeTextController,
                    focusNode: _thirdFocusNode,
                    // cursorColor: Colors.red,
                    onChanged: (String value) {
                      value.isNotEmpty
                          ? _fourthFocusNode.requestFocus()
                          : _secondFocusNode.requestFocus();
                    },
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: CodeTextField(
                    textEditingController: _fourthCodeTextController,
                    focusNode: _fourthFocusNode,
                    onChanged: (String value) {
                      if (value.isEmpty) {
                        _thirdFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ],
            ),
//           const SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
//             child: TextField(
//               //لاخفاء ما يدخل داخل الصندوق
// // textInputAction: TextInputAction.emergencyCall,
//               controller: _emailTextController,
//               keyboardType: TextInputType.visiblePassword,
//               obscureText: true,
//               obscuringCharacter: '#',
//
//               onTap: () {},
//               onChanged: (String value) {},
//               cursorColor: Colors.black,
//               cursorWidth: 1.3.w,
//               cursorRadius: Radius.circular(10).r,
//               enabled: true,
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.sp,
//                   color: Colors.black),
//               maxLength: 35,
//               decoration: InputDecoration(
//                   labelText: AppLocalizations.of(context)!.email,
//                   labelStyle: TextStyle(
//                       fontSize: 16.sp,
//                       fontStyle: FontStyle.italic,
//                       color: Color(0xff888888),
//                       fontWeight: FontWeight.w500),
//                   fillColor: Color(0xffFAFAFA),
//                   filled: true,
//                   helperMaxLines: 2,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Color(0xffc6cad4), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Color(0xff50535c), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   constraints: BoxConstraints(
//                     maxHeight: 372.h,
//                     minWidth: 53.w,
//                   )),
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Padding(
//             padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
//             child: TextField(
//               //لاخفاء ما يدخل داخل الصندوق
// // textInputAction: TextInputAction.emergencyCall,
//               controller: _passwordTextController,
//               keyboardType: TextInputType.visiblePassword,
//               obscureText: true,
//               obscuringCharacter: '#',
//
//               onTap: () {},
//               onChanged: (String value) {},
//               cursorColor: Colors.black,
//               cursorWidth: 1.3.w,
//               cursorRadius: Radius.circular(10).r,
//               enabled: true,
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.sp,
//                   color: Colors.black),
//               maxLength: 35,
//               decoration: InputDecoration(
//                   labelText:
//                   AppLocalizations.of(context)!.password,
//                   labelStyle: TextStyle(
//                       fontSize: 16.sp,
//                       fontStyle: FontStyle.italic,
//                       color: Color(0xff888888),
//                       fontWeight: FontWeight.w500),
//                   fillColor: Color(0xffFAFAFA),
//                   filled: true,
//                   helperMaxLines: 2,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide:
//                     BorderSide(color: Color(0xffc6cad4), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                     BorderSide(color: Color(0xff50535c), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   constraints: BoxConstraints(
//                     maxHeight: 372.h,
//                     minWidth: 53.w,
//                   )),
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Padding(
//             padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
//             child: TextField(
//               //لاخفاء ما يدخل داخل الصندوق
// // textInputAction: TextInputAction.emergencyCall,
//             controller: _passwordConfirmTextController,
//               keyboardType: TextInputType.visiblePassword,
//               obscureText: true,
//               obscuringCharacter: '#',
//
//               onTap: () {},
//               onChanged: (String value) {},
//               cursorColor: Colors.black,
//               cursorWidth: 1.3.w,
//               cursorRadius: Radius.circular(10).r,
//               enabled: true,
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.sp,
//                   color: Colors.black),
//               maxLength: 35,
//               decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context)!.writeconfirmpasswordhere,
//                   labelStyle: TextStyle(
//                       fontSize: 16.sp,
//                       fontStyle: FontStyle.italic,
//                       color: Color(0xff888888),
//                       fontWeight: FontWeight.w500),
//                   fillColor: Color(0xffFAFAFA),
//                   filled: true,
//                   helperMaxLines: 2,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Color(0xffc6cad4), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Color(0xff50535c), width: 1.w),
//                     borderRadius: BorderRadius.circular(27).r,
//                   ),
//                   constraints: BoxConstraints(
//                     maxHeight: 372.h,
//                     minWidth: 53.w,
//                   )),
//             ),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(height: 30.h),
            Spacer(),
            Align(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    _performVerifiedEmail();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.sendinformation,
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
                    minimumSize: Size(372.w, 53.h),
                    primary: Color(0xffFFB300),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Future<void> _performVerifiedEmail() async {
    if (checkData()) {
      await _verifiedEmail();
    }
  }

  bool checkData() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _firstCodeTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> _verifiedEmail() async {
    bool status = await AuthApiController().verifiedEmail(
        code:
            '${_firstCodeTextController.text}${_secondCodeTextController.text}${_thirdCodeTextController.text}${_fourthCodeTextController.text}');
    if (status) {
      Get.snackbar('Success', 'your email has been verified',
          backgroundColor: Colors.green.shade600, colorText: Colors.white);
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.pushNamed(context, '/Login');
        },
      );
    }
    Get.snackbar('error', 'your email has not been verified',
        backgroundColor: Colors.red.shade700, colorText: Colors.white);
  }

// bool _verifiedEmail() {
//   if (_newPasswordTextController.text.isNotEmpty &&
//       _newPasswordConfirmationTextController.text.isNotEmpty) {
//     if (_newPasswordTextController.text ==
//         _newPasswordConfirmationTextController.text) {
//       return true;
//     } else {
//       showSnackBar(context,
//           message: 'Password confirmation error!', error: true);
//       return false;
//     }
//   }
//   showSnackBar(context,
//       message: 'Enter Password & confirmation', error: true);
//   return false;
// }
//
// bool _checkCode() {
//   if (_firstCodeTextController.text.isNotEmpty &&
//       _secondCodeTextController.text.isNotEmpty &&
//       _thirdCodeTextController.text.isNotEmpty &&
//       _fourthCodeTextController.text.isNotEmpty) {
//     _getCode();
//     return true;
//   }
//   showSnackBar(context, message: 'Enter the verification code!', error: true);
//   return false;
// }
//
// void _getCode() {
//   _code = _firstCodeTextController.text +
//       _secondCodeTextController.text +
//       _thirdCodeTextController.text +
//       _fourthCodeTextController.text;
// }

// Future<void> _resetPassword() async {
//   ApiResponse apiResponse = await AuthApiController().resetPassword(
//       email: widget.email,
//       password: _newPasswordConfirmationTextController.text,
//       code: _code);
//   showSnackBar(context,
//       message: apiResponse.description, error: !apiResponse.success);
//   if (apiResponse.success) {
//     Navigator.pop(context);
//   }
// }

}
