import 'package:dio/dio.dart';
import 'package:event_hub/model/event_details_model.dart';

class EventsService {
  final Dio dio;

  EventsService(this.dio) {
    dio.options.baseUrl = "https://eventhub.huma-volve.com/api/v1/";
  }

  // 🟢 تجيب كل الفعاليات
  Future<Response> getAllEvents() async {
    return await dio.get("events");
  }

  // 🟢 تجيب بيانات الصفحة الرئيسية
  Future<Response> getAppHome() async {
    return await dio.get("app/home");
  }

  // 🔥 تجيب تفاصيل Event (المهم عندك)
  Future<EventDetailsModel> getEventDetails(int id) async {
    try {
      final response = await dio.get("events/$id");
      return EventDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to load event details",
      );
    }
  }

  // 🆕 🔥 تجيب events حسب category (tech / education / sport)
  Future<Response> getEventsByCategory(String slug) async {
    return await dio.get("events?slug=$slug");
  }
}
