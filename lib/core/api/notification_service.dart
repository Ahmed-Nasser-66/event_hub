import 'package:dio/dio.dart';

class NotificationService {
  final Dio dio;

  NotificationService(this.dio);

  // 🟢 GET: كل الإشعارات
  Future<Response> getNotifications() async {
    return await dio.get("notifications");
  }

  // 🔵 GET: حالة الإشعارات (on/off)
  Future<Response> getNotificationStatus() async {
    return await dio.get("notifications/status");
  }

  // 🟠 POST: تحديث حالة الإشعارات
  Future<Response> updateNotificationStatus(bool value) async {
    return await dio.post(
      "notifications/status",
      data: {
        "status": value,
      },
    );
  }
}
