import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio dio;

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://eventhub.huma-volve.com/api/v1/",
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  void clearToken() {
    dio.options.headers.remove("Authorization");
  }

  Future<Response> login(String email, String password) async {
    return await dio.post("/auth/login", data: {
      "email": email,
      "password": password,
    });
  }

  Future<Response> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await dio.post(
      "auth/register",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "role": "attendee",
      },
    );

    return response;
  }

  Future<Response> forgotPassword(String email) async {
    return await dio.post("/auth/forgot-password", data: {
      "email": email,
    });
  }

  Future<Response> verifyOtp(String email, String code) async {
    return await dio.post(
      "/auth/verify-otp",
      data: {
        "email": email,
        "code": code,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": null,
        },
      ),
    );
  }

  Future<Response> resetPassword(
      String email, String code, String password) async {
    return await dio.post(
      "/auth/reset-password",
      data: {
        "email": email,
        "code": code,
        "password": password,
        "password_confirmation": password,
      },
      options: Options(
        headers: {
          "Authorization": null,
        },
      ),
    );
  }

  Future<Response> updateProfile({
    required String name,
    required String email,
    String? password,
    File? image,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      if (password != null && password.isNotEmpty) "password": password,
      if (password != null && password.isNotEmpty)
        "password_confirmation": password,
      if (image != null)
        "profile_picture": await MultipartFile.fromFile(image.path),
    });

    return await dio.post("/profile/update", data: formData);
  }
}
