import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:event_hub/features/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool value = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  void dispose() {
    pass.dispose();
    confirmpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "profile");
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(AppAssets.lama),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Change Picture",
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Full Name",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Lama Yousef",
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "example@gmail.com",
                    mycontroller: email,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter email";
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(val)) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter phone number",
                    mycontroller: phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter phone number";
                      }

                      if (!RegExp(r'^[0-9]{11}$').hasMatch(val)) {
                        return "Phone number must be exactly 11 digits";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Enter password",
                    mycontroller: pass,
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
                    "Retype Password",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: "Retype Password",
                    mycontroller: confirmpass,
                    isPassword: true,
                    onChanged: (value) {
                      formState.currentState!.validate();
                    },

                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Retype password";
                      }

                      if (val != pass.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonAuth(
                          title: 'Cancel',
                          color: AppColors.grey,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: CustomButtonAuth(
                          title: 'Save',
                          color: AppColors.orange,
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed("profile");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
