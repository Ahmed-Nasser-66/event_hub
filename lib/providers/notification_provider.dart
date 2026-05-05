import 'package:dio/dio.dart';
import 'package:event_hub/core/api/notification_service.dart';
import 'package:event_hub/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://eventhub.huma-volve.com/api/v1/",
    headers: {"Content-Type": "application/json"},
  ));

  // ================= API DATA =================
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;

  // ================= SERVER STATE =================
  bool _status = false;

  bool get status => _status;

  // ================= FETCH NOTIFICATIONS =================
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

  // ================= GET STATUS FROM API =================
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

  // ================= UPDATE STATUS =================
  Future<void> setNotification(bool value) async {
    try {
      // 🔥 Optimistic UI
      _status = value;
      notifyListeners();

      final service = NotificationService(_dio);
      await service.updateNotificationStatus(value);
    } catch (e) {
      debugPrint("❌ Update Status Error: $e");
    }
  }

  // ================= LOCAL (FAKE) NOTIFICATIONS =================
  void addLocalNotification(
    String title,
    String body, {
    String? image, // 🔥 الجديد
  }) {
    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      body: body,
      time: DateTime.now().toIso8601String(),
      image: image, // 🔥 هنا
    );

    _notifications.insert(0, newNotification);

    notifyListeners();
  }
}
