import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:flutter/material.dart';

class VarificationOtp extends StatefulWidget {
  const VarificationOtp({super.key});

  @override
  State<VarificationOtp> createState() => _VarificationOtpState();
}

class _VarificationOtpState extends State<VarificationOtp> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,

      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "forgotpassword");
          },
        ),
      ),
      body: Form(
        key: formState,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Please check your email",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We have sent code to example@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("varification");
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: " Didn’t receive a code? ",
                      children: [
                        TextSpan(
                          text: "Resend Code",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(padding: EdgeInsets.only(bottom: 50)),
              CustomButtonAuth(
                title: 'Go to reset password',
                color: AppColors.orange,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    Navigator.of(context).pushReplacementNamed("restpassword");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
