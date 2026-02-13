import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:event_hub/features/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "login");
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 10),

              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  'Enter your email address and we will send you a code to reset your password.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondary.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Email",
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 5),

              CustomTextForm(
                hinttext: "Enter your email",
                mycontroller: email,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter email";
                  }
                  return null;
                },
              ),

              const Spacer(),

              CustomButtonAuth(
                title: 'Send code',
                color: AppColors.orange,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    // التعديل هنا: الانتقال لشاشة الـ OTP
                    Navigator.pushNamed(context, "verification");
                    print("Validation Success: ${email.text}");
                  }
                },
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
