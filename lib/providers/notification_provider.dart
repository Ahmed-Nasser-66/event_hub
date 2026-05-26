import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_hub/core/api/notification_service.dart';
import 'package:event_hub/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://eventhub.huma-volve.com/api/v1/",
    headers: {"Content-Type": "application/json"},
  ));

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;

  bool get isLoading => _isLoading;

  bool _status = false;

  bool get status => _status;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      final service = NotificationService(_dio);
      final response = await service.getNotifications();

      final List data = response.data['data'] ?? [];

      _notifications = data.map((e) => NotificationModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("❌ Notification Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNotificationStatus() async {
    try {
      final service = NotificationService(_dio);
      final response = await service.getNotificationStatus();

      _status = response.data['status'] ?? false;

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Status Error: $e");
    }
  }

  Future<void> setNotification(bool value) async {
    try {
      _status = value;
      notifyListeners();

      final service = NotificationService(_dio);
      await service.updateNotificationStatus(value);
    } catch (e) {
      debugPrint("❌ Update Status Error: $e");
    }
  }

  void addLocalNotification(
    String title,
    String body, {
    String? image,
  }) {
    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      body: body,
      time: DateTime.now().toIso8601String(),
      image: image,
    );

    _notifications.insert(0, newNotification);

    notifyListeners();
  }

  // 1. التعديل الأول: استقبال الـ userEmail لجعل الـ Key ديناميكي لكل حساب
  Future<void> saveNotifications(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();

    final notificationJson = _notifications.map((notification) {
      return {
        'id': notification.id,
        'title': notification.title,
        'body': notification.body,
        'time': notification.time,
        'image': notification.image,
      };
    }).toList();

    await prefs.setString(
      "notifications_$userEmail",
      jsonEncode(notificationJson),
    );
  }

  // 2. التعديل الثاني: استقبال الـ userEmail ونقل الـ clear خارج الشرط لتصفير الـ RAM
  Future<void> loadNotifications(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString("notifications_$userEmail");

    _notifications.clear(); // مسح القائمة فوراً لتجهيزها للمستخدم الجديد

    if (notificationsJson != null && notificationsJson.isNotEmpty) {
      try {
        final List decoded = jsonDecode(notificationsJson);

        for (var item in decoded) {
          _notifications.add(NotificationModel(
            id: item['id'] ?? 0,
            title: item['title'] ?? '',
            body: item['body'] ?? '',
            time: item['time'] ?? '',
            image: item['image'],
          ));
        }
      } catch (e) {
        debugPrint("❌ Error loading notifications: $e");
      }
    }

    notifyListeners();
  }

  // 3. التعديل الثالث: ميثود لتنظيف الذاكرة المؤقتة فوراً عند الـ Logout
  void clearNotificationsOnLogout() {
    _notifications.clear();
    notifyListeners();
  }
}
