import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:event_hub/features/widgets/customlogoauth.dart';
import 'package:event_hub/features/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool agreeToPolicy = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.grey, // من الكلاس
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () => Navigator.pushReplacementNamed(context, "welcome"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // استبدلنا الـ ListView بـ Column لإلغاء السكرول
            children: [
              Expanded(
                // الجزء العلوي الذي يحتوي على الحقول
                child: SingleChildScrollView(
                  // أضفناه احتياطياً فقط في حال كانت الشاشة صغيرة جداً لمنع الـ Error
                  physics:
                      const NeverScrollableScrollPhysics(), // تعطيل السكرول اليدوي
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomLogoAuth(),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Sign up Now",
                          style: AppTextStyles.headingMedium.copyWith(
                            fontSize: 26,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          "create account",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.secondary.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildLabel("Full Name"),
                        _buildFieldShadow(
                          child: CustomTextForm(
                            hinttext: "Enter full name",
                            mycontroller: username,
                            validator: (val) => (val == null || val.isEmpty)
                                ? "Enter name"
                                : null,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        _buildLabel("Email"),
                        _buildFieldShadow(
                          child: CustomTextForm(
                            hinttext: "example@gmail.com",
                            mycontroller: email,
                            validator: (val) => (val == null || val.isEmpty)
                                ? "Enter email"
                                : null,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        _buildLabel("Password"),
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
                        SizedBox(height: screenHeight * 0.015),
                        _buildLabel("Confirm password"),
                        _buildFieldShadow(
                          child: CustomTextForm(
                            hinttext: "Confirm password",
                            mycontroller: confirmpass,
                            isPassword: true,
                            validator: (val) =>
                                (val != pass.text) ? "Not match" : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // الجزء السفلي (الزائد) الذي سيُدفع لأسفل الشاشة
              Column(
                children: [
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.orange,
                    contentPadding: EdgeInsets.zero,
                    value: agreeToPolicy,
                    title: Text(
                      "I agree with privacy & policy",
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                    onChanged: (newValue) =>
                        setState(() => agreeToPolicy = newValue!),
                  ),
                  CustomButtonAuth(
                    title: 'sign up',
                    color: AppColors.orange,
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        Navigator.of(context).pushReplacementNamed("login");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSocialSection(),
                  const SizedBox(height: 20), // مسافة أمان تحت الأيقونات
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // استخدام AppColors للظلال
  Widget _buildFieldShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 10),
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
              child: Divider(color: AppColors.secondary.withOpacity(0.1)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Or sign up with",
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Divider(color: AppColors.secondary.withOpacity(0.1)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIconCircle("assets/icon/google.svg"),
            const SizedBox(width: 20),
            _buildSocialIconCircle("assets/icon/facebook.svg"),
            const SizedBox(width: 20),
            _buildSocialIconCircle("assets/icon/x.svg", isX: true),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIconCircle(String assetPath, {bool isX = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SvgPicture.asset(assetPath, width: isX ? 30 : 25, height: 25),
    );
  }
}
