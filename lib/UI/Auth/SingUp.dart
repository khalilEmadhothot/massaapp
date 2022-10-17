import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Storage/shared_pref_controller.dart';
import 'package:massa_app/UI/Auth/verified_email_screen.dart';
import 'package:massa_app/utils/helpers.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../Api/model/register.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> with Helpers {
  String _gender = '1';
  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmpasswordTextController;
  late TextEditingController _phoneController;
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmpasswordTextController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmpasswordTextController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor:
          the == ThemeMode.light ? Colors.white : Color(0xff302A28),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    AppLocalizations.of(context)!.createanaccount,
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
              height: 40.h,
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
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
              child: IntlPhoneField(
                controller: _phoneController,
                cursorColor: Colors.black,
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  print('Country changed to: ' + country.name);
                },
                decoration: InputDecoration(
                    counterStyle: TextStyle(
                      color:
                          the == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                    fillColor: Color(0xffFAFAFA),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28).r,
                      borderSide: BorderSide(
                        width: 0.5.w,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28).r,
                      borderSide:
                          BorderSide(color: Color(0xffc6cad4), width: 1.w),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 372.h,
                      minWidth: 53.w,
                    )
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    // ),
                    ),
                initialCountryCode: 'IN',
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
              child: TextField(
                controller: _usernameTextController,
                //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,
                keyboardType: TextInputType.name,
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
                    labelText: AppLocalizations.of(context)!.fullName,
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
              height: 17.h,
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
                      borderRadius: BorderRadius.circular(27).r,
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
                controller: _passwordTextController,
                //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,
                keyboardType: TextInputType.visiblePassword,

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
                maxLength: 35,
                decoration: InputDecoration(
                    counterStyle: TextStyle(
                      color:
                          the == ThemeMode.light ? Colors.black : Colors.white,
                    ),
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
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
              child: TextField(
                obscureText: _isObscure2,
                controller: _confirmpasswordTextController,
                keyboardType: TextInputType.visiblePassword,
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
                maxLength: 35,
                decoration: InputDecoration(
                    counterStyle: TextStyle(
                      color:
                          the == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                    labelText: AppLocalizations.of(context)!.confirmpassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
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
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 40, end: 50),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      border: Border.all(
                        width: 1.w,
                        color: Color(0xffc6cad4),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocalizations.of(context)!.male,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          value: '1',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _gender = value;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocalizations.of(context)!.female,
                            style: TextStyle(
                              color: the == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          value: '0',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _gender = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Female
            Text(
              AppLocalizations.of(context)!
                  .bycreatinganaccountyouagreetoourTermsofServiceandPrivacyPolicy,
              style: TextStyle(
                color:
                    the == ThemeMode.light ? Color(0xff4E4E4E) : Colors.white,
                //  color: Color(0xff4E4E4E),
                fontWeight: FontWeight.w600,
                height: 1.5.h,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
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
                    AppLocalizations.of(context)!.complete,
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
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performLogin() async {
    if (checkData()) {
      await _register();
    }
  }

  bool checkData() {
    if (_usernameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _confirmpasswordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.enterrequireddata, error: true);
    return false;
  }

  Future<void> _register() async {
    String name = _usernameTextController.text;
    String email = _emailTextController.text;
    String phone = _phoneController.text;
    String password = _passwordTextController.text;
    String confirmPass = _confirmpasswordTextController.text;
    String gender = _gender;

    print(
        "REGISTER: $name / $email / $phone / $password / $confirmPass / $gender");

    AuthApiController()
        .register(
            phone: phone,
            email: email,
            name: name,
            gender: gender,
            password: password,
            confirmPassword: confirmPass)
        .then((register) {
      if (register != null) {
        if (register.success!) {
          SharedPrefController().setEmail(email: _emailTextController.text);
          _verifiedEmail();
        } else {
          showSnackBar(context,
              message: register.description!, error: !register.success!);
        }
      }
    });
  }

  Future<void> _verifiedEmail() async {
    bool status = await AuthApiController().sendVerifiedEamil();
    if (status) {
      Navigator.push(context, MaterialPageRoute(builder: (builder) {
        return VerifiedEmailScreen();
      }));
    }
  }

  User get user {
    // User user = User();
    // user.name = _usernameTextController.text;
    // user.password = _passwordTextController.text;
    // user.passwor dConfirmation = _confirmpasswordTextController.text;
    // user.email = _emailTextController.text;
    // user.gender = _gender;
    // user.phone = _phoneController.text;
    return user;
  }
}
