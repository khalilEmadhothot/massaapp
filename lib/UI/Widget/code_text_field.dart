import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    Key? key,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required Function(String value) onChanged,
  })  : _textEditingController = textEditingController,
        _focusNode = focusNode,
        _onChanged = onChanged,
        super(key: key);

  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final void Function(String value) _onChanged;

  @override
  Widget build(BuildContext context) {
    var the = ThemeModeHandler.of(context)!.themeMode;
    return TextField(
      cursorColor: Colors.black,
      cursorWidth: 1.3,
      controller: _textEditingController,
      focusNode: _focusNode,
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: the == ThemeMode.light ? Colors.black : Colors.white,
      ),
      onChanged: _onChanged,
      maxLength: 1,
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: the == ThemeMode.light ? Colors.grey : Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff50535c), width: 1),
          )),
    );
  }
}
