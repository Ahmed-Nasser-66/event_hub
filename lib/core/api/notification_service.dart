import 'package:dio/dio.dart';

class NotificationService {
  final Dio dio;

  NotificationService(this.dio);

  Future<Response> getNotifications() async {
    return await dio.get("notifications");
  }

  Future<Response> getNotificationStatus() async {
    return await dio.get("notifications/status");
  }

  Future<Response> updateNotificationStatus(bool value) async {
    return await dio.post(
      "notifications/status",
      data: {
        "status": value,
      },
    );
  }
}
