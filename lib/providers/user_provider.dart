import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = "";
  String email = "";

  void setUser(String userName, String userEmail) {
    name = userName;
    email = userEmail;
    notifyListeners();
  }
}
