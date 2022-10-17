import 'package:massa_app/Api/model/modellogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Prefkey { loggedin, token }

class SharedPrefController {
  //
  // static final SharedPrefController _instance = SharedPrefController();

  static late SharedPreferences _sharedPreferences;
//
//   factory SharedPrefController() {
//     return _instance;
//   }

  Future<void> initPreferrnces() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> Save({required LoginData loginData}) async {
    await _sharedPreferences.setBool(Prefkey.loggedin.toString(), true);
    await _sharedPreferences.setString(
        Prefkey.token.toString(), 'Bearer ${loginData.token!}');
  }


  setEmail({required String email}){
    _sharedPreferences.setString('email', email);
  }


  String? get email{
    return  _sharedPreferences.getString('email');
  }

  bool get loggedin =>
      _sharedPreferences.getBool(Prefkey.loggedin.toString()) ?? false;

  Future<bool> Clear() async => _sharedPreferences.clear();

  String get token =>
      _sharedPreferences.getString(Prefkey.token.toString()) ?? '';

  void changeLanguage(String language) {}
}

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }



  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
