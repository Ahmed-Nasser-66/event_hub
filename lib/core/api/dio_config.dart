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
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2V2ZW50aHViLmh1bWEtdm9sdmUuY29tL2FwaS92MS9hdXRoL3JlZ2lzdGVyIiwiaWF0IjoxNzc4MTQwMzU1LCJleHAiOjE3NzgxNDM5NTUsIm5iZiI6MTc3ODE0MDM1NSwianRpIjoiZnpBRVR2UFc1VVdDTE5iMiIsInN1YiI6IjgyIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.tjtUol6tPAzAT_Q9pvLczvxgru1WsphscdthGVqmiFA',
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
