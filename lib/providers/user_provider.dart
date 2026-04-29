import 'dart:io';
import 'package:event_hub/core/api/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _password = "";
  File? _image;

  String get name => _name;
  String get email => _email;
  File? get image => _image;
  String get password => _password;

  void registerUser(String name, String email, String password, String text) {
    _name = name;
    _email = email;
    _password = password;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  String? _token;

  String? get token => _token;
  Future<bool> login(String email, String password) async {
    try {
      final response = await ApiService().login(email, password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        final user = data["data"]["user"];
        final token = data["data"]["token"];

        _name = user["name"];
        _email = user["email"];
        _token = token;

        ApiService().setToken(_token!);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", _token!);
        await prefs.setString("name", _name);
        await prefs.setString("email", _email);

        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString("name") ?? "";
    _email = prefs.getString("email") ?? "";
    _token = prefs.getString("token");

    String? imagePath = prefs.getString("image_$_email");
    if (imagePath != null && File(imagePath).existsSync()) {
      _image = File(imagePath);
    } else {
      _image = null;
    }

    if (_token != null) {
      ApiService().setToken(_token!);
    }

    notifyListeners();
  }

  void setUser(String name, String email, String password, {File? newImage}) {
    _name = name;
    _email = email;
    _password = password;

    if (newImage != null) {
      _image = newImage;
    }

    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("name");
    await prefs.remove("email");

    _token = null;
    _name = "";
    _email = "";
    _password = "";
    _image = null;

    ApiService().clearToken();

    notifyListeners();
  }
}
