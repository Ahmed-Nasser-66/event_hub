import 'package:dio/dio.dart';
import 'package:event_hub/core/api/notification_service.dart';
import 'package:event_hub/model/notification_model.dart';
import 'package:flutter/material.dart';

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
}
