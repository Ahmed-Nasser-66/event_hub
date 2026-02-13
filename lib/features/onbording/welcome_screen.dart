import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة للتحكم في المسافات بشكل Responsive [cite: 2025-11-14]
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.grey, // من الكلاس
      appBar: AppBar(
        backgroundColor: AppColors.grey, // من الكلاس
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "onboarding");
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // 1. اللوجو
              SizedBox(
                height: screenHeight * 0.12,
                child: Image.asset(AppAssets.event, fit: BoxFit.contain),
              ),

              const Spacer(flex: 1),

              // 2. الصورة الرئيسية
              Image.asset(
                AppAssets.login,
                height:
                    screenHeight * 0.32, // تقليل الارتفاع قليلاً لرفع ما تحته
                fit: BoxFit.contain,
              ),

              const Spacer(flex: 1),

              // 3. النص الترحيبي
              Text(
                "WELCOME!",
                textAlign: TextAlign.center,
                style: AppTextStyles.headingLarge.copyWith(
                  fontSize: 32,
                  color: AppColors.secondary, // من الكلاس
                ),
              ),

              // 4. تقليل الـ flex هنا لرفع الزرارين لفوق
              const Spacer(flex: 2),

              // 5. قسم الأزرار
              Column(
                children: [
                  CustomButtonAuth(
                    title: 'Login',
                    color: AppColors.orange, // من الكلاس
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButtonAuth(
                    title: 'Sign Up',
                    // استخدمنا AppColors.grey لأنه اللون المتاح في الكلاس بدلاً من Colors.white
                    color: AppColors.grey,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                  ),
                ],
              ),

              // مسافة مرنة في القاع لضمان عدم التصاق الأزرار بحافة الشاشة [cite: 2025-11-14]
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
