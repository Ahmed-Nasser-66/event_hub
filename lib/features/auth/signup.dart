import 'package:event_hub/core/theme/app_color.dart';
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
  bool value = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  CustomLogoAuth(),
                  const SizedBox(height: 20),
                  const Text(
                    "Sign up Now",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      height: 1.0,
                      letterSpacing: 0,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0,
                      color: AppColors.secondary,
                    ),
                  ),
                  const Text(
                    "Create account",
                    style: TextStyle(color: Color(0xffE9ECEF)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Full Name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter full name",
                    mycontroller: username,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter full name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter email",
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
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter password",
                    mycontroller: pass,
                    isPassword: true,
                    onChanged: (value) {
                      formState.currentState!.validate(); // يعيد فحص التأكيد
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
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Confirm password",
                    mycontroller: confirmpass,
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Confirm password";
                      }

                      if (val != pass.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.orange,
              contentPadding: EdgeInsets.zero,
              value: value,
              title: Text("I agree with privacy & policy"),
              onChanged: (bool? newValue) {
                setState(() {
                  value = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomButtonAuth(
              title: 'Sign Up',
              color: AppColors.orange,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  Navigator.of(context).pushReplacementNamed("login");
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "Have an account? ",
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "__________________  Or log in with  __________________",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 20),
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
                SizedBox(width: 20),
                SvgPicture.asset("assets/icon/x.svg", width: 50, height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
