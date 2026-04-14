import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  String status = "on";

  void setNotification(String value) {
    status = value;
    notifyListeners();
  }
}