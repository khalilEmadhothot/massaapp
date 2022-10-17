import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/Api/controller/auth_api_controller.dart';
import 'package:massa_app/Api/model/api_response.dart';

import '../../utils/helpers.dart';
import '../Widget/code_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with Helpers {
  String _code = '';
  late TextEditingController _newPasswordTextController;
  late TextEditingController _newPasswordConfirmationTextController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  @override
  void initState() {
    super.initState();
    _newPasswordTextController = TextEditingController();
    _newPasswordConfirmationTextController = TextEditingController();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordTextController.dispose();
    _newPasswordConfirmationTextController.dispose();

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(
            height: 100.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
         AppLocalizations.of(context)!.forgotpassword,
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
            AppLocalizations.of(context)!.enteremailtoreceiveresetcode,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              height: 1.h,
              fontSize: 16.sp,
            ),
          ),
          const SizedBox(height: 70),
          Row(
            children: [
              Expanded(
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
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
            child: TextField(
              //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,

              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: '#',

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
                  labelText:        AppLocalizations.of(context)!.writenewpasswordhere,
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
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
            child: TextField(
              //لاخفاء ما يدخل داخل الصندوق
// textInputAction: TextInputAction.emergencyCall,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: '#',

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
                  labelText:        AppLocalizations.of(context)!.writeconfirmpasswordhere,
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
          const SizedBox(height: 10),
          SizedBox(height: 30.h),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
              child: ElevatedButton(
                onPressed: () async {
                  _performResetPassword();
                  Navigator.pushReplacementNamed(context, '/Login');
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
    );
  }

  Future<void> _performResetPassword() async {
    if (checkData()) {
      await _resetPassword();
    }
  }

  bool checkData() {
    if (_checkCode() && _checkPassword()) {
      return true;
    }
    return false;
  }

  bool _checkPassword() {
    if (_newPasswordTextController.text.isNotEmpty &&
        _newPasswordConfirmationTextController.text.isNotEmpty) {
      if (_newPasswordTextController.text ==
          _newPasswordConfirmationTextController.text) {
        return true;
      } else {
        showSnackBar(context,
            message: AppLocalizations.of(context)!.passwordconfirmationerror, error: true);
        return false;
      }
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.enterPasswordandconfirmation, error: true);
    return false;
  }

  bool _checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _fourthCodeTextController.text.isNotEmpty) {
      _getCode();
      return true;
    }
    showSnackBar(context, message: AppLocalizations.of(context)!.enterresetcode, error: true);
    return false;
  }

  void _getCode() {
    _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }

  Future<void> _resetPassword() async {
    ApiResponse apiResponse = await AuthApiController().resetPassword(
        email: widget.email,
        password: _newPasswordConfirmationTextController.text,
        code: _code);
    showSnackBar(context,
        message: apiResponse.description, error: !apiResponse.success);
    if (apiResponse.success) {
      Navigator.pop(context);
    }
  }
}
