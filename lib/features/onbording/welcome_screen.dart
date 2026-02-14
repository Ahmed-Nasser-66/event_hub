import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "onboarding");
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  AppAssets.event,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 29),
                child: Image.asset(
                  AppAssets.login,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                "WELCOME!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,

                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  CustomButtonAuth(
                    title: 'Login',
                    color: AppColors.orange,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButtonAuth(
                    title: 'Sign Up',
                    color: AppColors.grey,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
