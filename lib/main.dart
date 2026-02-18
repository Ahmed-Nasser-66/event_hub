import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/auth/forgotpassword.dart';
import 'package:event_hub/features/auth/login.dart';
import 'package:event_hub/features/auth/restpassword.dart';
import 'package:event_hub/features/auth/signup.dart';
import 'package:event_hub/features/auth/varification_otp.dart';
import 'package:event_hub/features/home/presentation/Homepage.dart';
import 'package:event_hub/features/onbording/onbording_screen.dart';
import 'package:event_hub/features/onbording/welcome_screen.dart';
import 'package:event_hub/features/splash/splach_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.grey,
          titleTextStyle: TextStyle(
            color: AppColors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.orange),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "homepage": (context) => Homepage(),
        "onboarding": (context) => OnBoarding(),
        "welcome": (context) => WelcomeScreen(),
        "forgotpassword": (context) => Forgotpassword(),
        "varification": (context) => VarificationOtp(),
        "restpassword": (context) => RestPassword(),
      },
    );
  }
}
