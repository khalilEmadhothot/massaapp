import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/UI/Auth/verified_email_screen.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../utils/helpers.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    // _emailTextController.text = 'www@gmail.com';
    // _passwordTextController.text = '12345678';
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/Language');
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: the == ThemeMode.light ? Colors.black : Colors.white,
                    size: 22.sp,
                  ),
                )),
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                // 'Login',
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                  color: Color(0xff6F15DE),
                  fontWeight: FontWeight.bold,
                  fontSize: 27.sp,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Align(
                alignment: AlignmentDirectional.center,
                child: Image.asset(
                  'images/Logo.png',
                  height: 160.h,
                )),
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
                cursorRadius: Radius.circular(10).r,
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
                      borderRadius: BorderRadius.circular(27).r,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff50535c), width: 1.w),
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
                obscureText: _isObscure,
                textInputAction: TextInputAction.go,
                onSubmitted: (String value) async {
                  await _performLogin();
                },
                controller: _passwordTextController,
                keyboardType: TextInputType.visiblePassword,
                // obscureText: true,
                // obscuringCharacter: '#',
                onTap: () {},
                onChanged: (String value) {},
                cursorColor: Colors.black,
                cursorWidth: 1.3.w,
                cursorRadius: Radius.circular(10).r,
                enabled: true,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.black),

                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
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
                      borderRadius: BorderRadius.circular(27).r,
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
              height: 0.h,
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ForgotPassword');
                },
                child: Text(
                  AppLocalizations.of(context)!.forgotpassword,
                  style: TextStyle(
                    color: the == ThemeMode.light
                        ? Color(0xff4E4E4E)
                        : Colors.white,
                    // color: Color(0xff4E4E4E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    _performLogin();
                  },
                  child: Text(
                    '  CONTINUE',
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
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/SingUp');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.createanaccount,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: the == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                      indent: 5,
                      endIndent: 5),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return VerifiedEmailScreen();
                          },
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.verifiedemail,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: the == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performLogin() async {
    if (checkData()) {
      await _login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.enterrequireddata, error: true);
    return false;
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().login(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    showSnackBar(context,
        message: apiResponse.description, error: !apiResponse.success);

    if (apiResponse.success) {
      Navigator.pushReplacementNamed(context, '/StartWithUs');
    }
  }
}
