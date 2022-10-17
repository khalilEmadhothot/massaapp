// import 'package:flutter/material.dart';
//
// import 'Storage/shared_pref_controller.dart';
//
// class ThemeNotifier with ChangeNotifier {
//   final darkTheme = ThemeData(
//     primarySwatch: Colors.grey,
//     primaryColor: Colors.black,
//     brightness: Brightness.dark,
//     backgroundColor: const Color(0xFF212121),
//     accentColor: Colors.white,
//     accentIconTheme: IconThemeData(color: Colors.black),
//     dividerColor: Colors.black12,
//   );
//
//   final lightTheme = ThemeData(
//     primarySwatch: Colors.grey,
//     primaryColor: Colors.white,
//     brightness: Brightness.light,
//     backgroundColor: const Color(0xFFE5E5E5),
//     accentColor: Colors.black,
//     accentIconTheme: IconThemeData(color: Colors.white),
//     dividerColor: Colors.white54,
//   );
//
//   ThemeData? _themeData;
//   ThemeData? getTheme() => _themeData;
//
//   ThemeNotifier() {
//     StorageManager.readData('themeMode').then((value) {
//       print('value read from storage: ' + value.toString());
//       var themeMode = value ?? 'light';
//       if (themeMode == 'light') {
//         _themeData = lightTheme;
//       } else {
//         print('setting dark theme');
//         _themeData = darkTheme;
//       }
//       notifyListeners();
//     });
//   }
//
//   void setDarkMode() async {
//     _themeData = darkTheme;
//     StorageManager.saveData('themeMode', 'dark');
//     notifyListeners();
//   }
//
//   void setLightMode() async {
//     _themeData = lightTheme;
//     StorageManager.saveData('themeMode', 'light');
//     notifyListeners();
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

class ThemeManager implements IThemeModeManager {
  @override
  Future<String?> loadThemeMode() async {
    final _prefs = await SharedPreferences.getInstance();
    print("ffffffffff");
    print("${await (_prefs.getString("THEME_PREF"))}");

    return await (_prefs.getString("THEME_PREF"));
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString("THEME_PREF", value);
  }
}
