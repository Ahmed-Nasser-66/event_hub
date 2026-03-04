import 'package:flutter/material.dart';

/// 1 ==> بعمل class
class AppLanguageProvider extends ChangeNotifier {
  /// 2 ==> بيشيل حاجتين
  /// 1 - data ==> البيانات
  /// 2- funcation ==> عشان هتسمع في اكتر من مكان
  String appLanguage = 'en'; // String ==> عشان Locale بياحد مني String

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
