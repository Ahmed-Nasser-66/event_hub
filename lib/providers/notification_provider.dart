import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_hub/core/api/auth_api_service.dart';
import 'package:event_hub/core/api/notification_service.dart';
import 'package:event_hub/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  final Dio _dio = ApiService().dio;

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;

  bool get isLoading => _isLoading;

  bool _status = false;

  bool _hasUnreadNotifications = false;

  bool get hasUnreadNotifications => _hasUnreadNotifications;

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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notification_status', value);

      notifyListeners();

      final service = NotificationService(_dio);
      await service.updateNotificationStatus(value);
    } catch (e) {
      debugPrint("❌ Update Status Error: $e");
    }
  }

  Future<void> loadNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();

    _status = prefs.getBool('notification_status') ?? true;

    notifyListeners();
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
      isRead: false,
    );
    _notifications.insert(0, newNotification);

    _hasUnreadNotifications = true;

    notifyListeners();
  }

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

  Future<void> loadNotifications(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString("notifications_$userEmail");

    _notifications.clear();

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

  void markNotificationsAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }

    _hasUnreadNotifications = false;
    notifyListeners();
  }

  void markAllAsRead() {
    _hasUnreadNotifications = false;
    notifyListeners();
  }

  void clearNotificationsOnLogout() {
    _notifications.clear();
    notifyListeners();
  }
}
