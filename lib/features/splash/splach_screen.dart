import 'dart:async';
import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    bool seenOnboarding = prefs.getBool("seenOnboarding") ?? false;

    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacementNamed(context, "homepage");
    } else if (seenOnboarding) {
      Navigator.pushReplacementNamed(context, "welcome");
    } else {
      Navigator.pushReplacementNamed(context, "onboarding");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(AppAssets.event, width: 200, height: 129)],
        ),
      ),
    );
  }
}
