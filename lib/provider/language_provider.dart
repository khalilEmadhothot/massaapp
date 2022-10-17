import 'package:flutter/material.dart';
import '../pref/SharedControllerLag.dart';

class LanguageProvider extends ChangeNotifier {
  String language = SharedControllerLag().language;

  void changeLanguage() {
    language = language == 'en' ? 'ar' : 'ar';
    SharedControllerLag().changeLanguage(language);
    notifyListeners();
  }
  void changeLanguageE() {
    language = language == 'en' ? 'en' : 'en';
    SharedControllerLag().changeLanguage(language);
    notifyListeners();
  }
}
