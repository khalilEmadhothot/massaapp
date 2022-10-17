import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  loggedIn, email, language
}

class SharedControllerLag {
  static final SharedControllerLag _instance = SharedControllerLag._();
  late SharedPreferences _sharedPreferences;

  factory SharedControllerLag() {
    return _instance;
  }

  SharedControllerLag._();

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required String email}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setString(PrefKeys.email.toString(), email);
  }

  bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;

  String get email => _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';

  Future<bool> changeLanguage(String language) async {
    return await _sharedPreferences.setString(PrefKeys.language.toString(), language);
  }

  String get language => _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';

  Future<bool> removeEmail() async {
    return await _sharedPreferences.remove(PrefKeys.email.toString());
  }

  Future<bool> remove({required String key}) async {
    if(_sharedPreferences.containsKey(key)){
      return await _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}

// class Shape {
//   // Shape shape  = Shape();
//   factory Shape() {
//     // return Shape();
//     return Circle();
//   }
// }
//
// class Circle extends Shape {}
