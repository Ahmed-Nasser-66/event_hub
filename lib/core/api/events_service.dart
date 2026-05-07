import 'package:dio/dio.dart';
import 'package:event_hub/model/event_details_model.dart';
import 'package:event_hub/core/api/auth_api_service.dart';

class EventsService {
  final Dio dio = ApiService().dio;
  // 🟢 تجيب كل الفعاليات
  Future<Response> getAllEvents({
    int page = 1,
  }) async {
    try {
      return await dio.get(
        "events",
        queryParameters: {
          "page": page,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to load events",
      );
    }
  }

  // 🟢 بيانات الصفحة الرئيسية
  Future<Response> getAppHome() async {
    try {
      return await dio.get("app/home");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to load home data",
      );
    }
  }

  // 🔥 تفاصيل Event
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

  // 🟣 Category Events
  Future<Response> getEventsByCategory(
    String slug,
  ) async {
    try {
      return await dio.get(
        "events",
        queryParameters: {
          "slug": slug,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to load category events",
      );
    }
  }

  // 🔍 Search Events
  Future<Response> searchEvents(
    String keyword,
  ) async {
    try {
      return await dio.get(
        "events",
        queryParameters: {
          "keyword": keyword,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to search events",
      );
    }
  }

  // 📍 Nearby Events
  Future<Response> getNearbyEvents({
    required double latitude,
    required double longitude,
  }) async {
    try {
      return await dio.get(
        "events",
        queryParameters: {
          "latitude": latitude,
          "longitude": longitude,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to load nearby events",
      );
    }
  }

  // 🟠 Filter Events
  Future<Response> filterEvents(
    String sort,
  ) async {
    try {
      return await dio.get(
        "events",
        queryParameters: {
          "sort": sort,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Failed to filter events",
      );
    }
  }
}
