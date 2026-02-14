import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:event_hub/features/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,

      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "login");
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
                    "Create new password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Create a strong password to secure your account.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "New password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,

                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),

              CustomTextForm(
                hinttext: "Enter password",
                mycontroller: password,
                isPassword: true,
                onChanged: (value) {
                  formState.currentState!.validate();
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter password";
                  }

                  if (val.length < 8) {
                    return "Password must be at least 8 characters";
                  }

                  if (RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return "Password cannot be numbers only";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10),
              const Text(
                "Confirm password",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 5),
              CustomTextForm(
                hinttext: "Confirm password",
                mycontroller: confirmPassword,
                isPassword: true,
                onChanged: (value) {
                  formState.currentState!.validate();
                },

                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Confirm password";
                  }

                  if (val != password.text) {
                    return "Passwords do not match";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              CustomButtonAuth(
                title: 'Rest password',
                color: AppColors.orange,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    Navigator.of(context).pushReplacementNamed("homepage");
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
