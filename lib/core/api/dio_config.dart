import 'package:dio/dio.dart';

import '../constants/app_keys.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppKeys.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  }
}
