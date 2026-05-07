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

          // 🔥 TOKEN
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2V2ZW50aHViLmh1bWEtdm9sdmUuY29tL2FwaS92MS9hdXRoL3JlZ2lzdGVyIiwiaWF0IjoxNzc4MTU3NDM0LCJleHAiOjE3NzgxNjEwMzQsIm5iZiI6MTc3ODE1NzQzNCwianRpIjoiZThtbkZ2Q0lWR0dic0JCOCIsInN1YiI6Ijg4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.iJuWXr6i-c2viEgh34z4oiv_wy7s8rp4JNLJVk6F7ZE',
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
