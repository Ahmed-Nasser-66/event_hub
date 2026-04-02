import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://mocki.io/v1/", // 👈 غيره
      headers: {"Content-Type": "application/json"},
    ),
  );

  /// 🔹 Send OTP
  Future<Response> sendOtp(String email) async {
    return await dio.post("/send-otp", data: {"email": email});
  }

  /// 🔹 Verify OTP
  Future<Response> verifyOtp(String email, String otp) async {
    return await dio.get("/verify-otp", data: {"email": email, "otp": otp});
  }

  /// 🔹 Reset Password
  Future<Response> resetPassword(String email, String newPassword) async {
    return await dio.post(
      "/reset-password",
      data: {"email": email, "password": newPassword},
    );
  }
}
