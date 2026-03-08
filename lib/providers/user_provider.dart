import 'dart:io';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _password = "";
  File? _image;

  String get name => _name;
  String get email => _email;
  File? get image => _image;

  void registerUser(String name, String email, String password) {
    _name = name;
    _email = email;
    _password = password;
    notifyListeners();
  }

  bool login(String email, String password) {
    return _email == email && _password == password;
  }
void setUser(
  String name,
  String email,
  String password, {
  File? newImage,
}) {
  _name = name;
  _email = email;
  _password = password;

  if (newImage != null) {
    _image = newImage;
  }

  notifyListeners();
}
}
