import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:event_hub/features/widgets/customlogoauth.dart';
import 'package:event_hub/features/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey, // استبدلنا الشفاف بلون الخلفية الموحد
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () => Navigator.pushReplacementNamed(context, "welcome"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: screenHeight * 0.02),
              const CustomLogoAuth(),
              SizedBox(height: screenHeight * 0.03),

              Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log in Now",
                      style: AppTextStyles.headingLarge.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "sign in to your account",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary.withOpacity(0.6),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    _buildInputLabel("Email"),
                    _buildFieldShadow(
                      child: CustomTextForm(
                        hinttext: "example@gmail.com",
                        mycontroller: email,
                        validator: (val) =>
                            (val == null || val.isEmpty) ? "Enter email" : null,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildInputLabel("Password"),
                    _buildFieldShadow(
                      child: CustomTextForm(
                        hinttext: "••••••••",
                        mycontroller: pass,
                        isPassword: true,
                        validator: (val) => (val == null || val.isEmpty)
                            ? "Enter password"
                            : null,
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushReplacementNamed("forgotpassword"),
                  child: Text(
                    "Forgot Password?",
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              CustomButtonAuth(
                title: 'log in',
                color: AppColors.orange,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    Navigator.of(context).pushReplacementNamed("homepage");
                  }
                },
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodySmall,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).pushReplacementNamed("signup"),
                    child: Text(
                      "Sign up",
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),

              // رفعنا قسم السوشيال ميديا هنا
              SizedBox(height: screenHeight * 0.03),

              _buildSocialSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت الظل: سحبنا اللون من AppColors مع Opacity
  Widget _buildFieldShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 10),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: AppColors.secondary.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or log in with",
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: AppColors.secondary.withOpacity(0.1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15), // تقليل المسافة لرفع الأيقونات
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIconCircle("assets/icon/google.svg"),
            const SizedBox(width: 25),
            _buildSocialIconCircle("assets/icon/facebook.svg"),
            const SizedBox(width: 25),
            _buildSocialIconCircle("assets/icon/x.svg", isX: true),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIconCircle(String assetPath, {bool isX = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // اللون الأبيض ثابت لأنه خلفية الأيقونة
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SvgPicture.asset(assetPath, width: isX ? 35 : 30, height: 30),
    );
  }
}
