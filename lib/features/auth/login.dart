import 'package:event_hub/core/theme/app_color.dart';
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
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "welcome");
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLogoAuth(),
                  const SizedBox(height: 20),
                  const Text(
                    "Log in Now",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,

                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "sign to your account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "example@gmail.com",
                    mycontroller: email,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter password",
                    mycontroller: pass,
                    isPassword: true,
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
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed("forgotpassword");
                  },
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButtonAuth(
              title: 'Login',
              color: AppColors.orange,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  Navigator.of(context).pushReplacementNamed("homepage");
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign up",
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
            SizedBox(height: 50),
            Text(
              "__________________  Or log in with  __________________",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/google.svg",
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 20),
                SvgPicture.asset(
                  "assets/icon/facebook.svg",
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 12),
                SvgPicture.asset("assets/icon/x.svg", width: 50, height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
