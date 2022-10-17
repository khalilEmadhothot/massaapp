import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/UI/Auth/ResetPasswordScreen.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../utils/helpers.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with Helpers {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _emailTextController.text = 'ahmet.mandil@gmail.com';
  }

  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
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
                          Icons.arrow_back_ios,
                          color: the == ThemeMode.light
                              ? Color(0xff6F15DE)
                              : Colors.white,
                          // color: Color(0xff6F15DE),
                          size: 22.h,
                        ))),
                SizedBox(
                  width: 70.w,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    AppLocalizations.of(context)!.forgotyourpassword,
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
              height: 85.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(
                AppLocalizations.of(context)!.passwordReset,
                style: TextStyle(
                  color: the == ThemeMode.light ? Colors.black : Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(
                AppLocalizations.of(context)!
                    .entertheemailassociatedwithyouraccountandwewillsendanemailwithinstructionstoresetyourpassword,
                style: TextStyle(
                  height: 1.3.h,
                  fontWeight: FontWeight.w400,
                  color: the == ThemeMode.light ? Colors.black : Colors.white,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
              child: TextField(
                controller: _emailTextController,
                //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,
                keyboardType: TextInputType.emailAddress,
// كل بداية كله حرف كبتل
// textCapitalization: TextCapitalization.words,
                onTap: () {},
                onChanged: (String value) {},
                cursorColor: Colors.black,
                cursorWidth: 1.3.w,
                cursorRadius: Radius.circular(10),
                enabled: true,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.black),

                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: TextStyle(
                        fontSize: 16.sp,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w500),
                    fillColor: Color(0xffFAFAFA),
                    filled: true,
                    helperMaxLines: 2,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffc6cad4), width: 1.w),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff50535c), width: 1.w),
                      borderRadius: BorderRadius.circular(27).r,
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 372.h,
                      minWidth: 53.w,
                    )),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    _performForgetPassword();
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
          ],
        ),
      ),
    );
  }

  Future<void> _performForgetPassword() async {
    if (checkData()) {
      await _ForgetPassword();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.enterrequireddata, error: true);
    return false;
  }

  Future<void> _ForgetPassword() async {
    ApiResponse apiResponse = await AuthApiController()
        .forgetPassword(email: _emailTextController.text);
    showSnackBar(context,
        message: apiResponse.description, error: !apiResponse.success);
    if (apiResponse.success) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ResetPasswordScreen(email: _emailTextController.text)));
    }
  }
}
