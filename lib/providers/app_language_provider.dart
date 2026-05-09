import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  static const String languageKey = 'language';

  String appLanguage = 'en';

  
  Future<void> loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString(languageKey) ?? 'en';
    notifyListeners();
  }

  
  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;

    appLanguage = newLanguage;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, newLanguage);

    notifyListeners();
  }
}
