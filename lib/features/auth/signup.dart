import 'package:event_hub/core/api/auth_api_service.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/custom_logo_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
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
  void dispose() {
    pass.dispose();
    confirmpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                  const CustomLogoAuth(),
                  const SizedBox(height: 20),
                  Text(
                    l10n.signupNow,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.createAccount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.enterFullName,
                    mycontroller: username,
                    validator: (val) {
                      final value = val?.trim() ?? "";

                      if (val == null || val.isEmpty) {
                        return l10n.enterFullName;
                      }
                      if (val.length < 3) {
                        return l10n.fullNameMinLength;
                      }
                      if (!RegExp(
                        r'^[a-zA-Z\u0600-\u06FF\s]+$',
                      ).hasMatch(value)) {
                        return l10n.invalidName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.emailExample,
                    mycontroller: email,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.enterEmail;
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(val)) {
                        return l10n.enterValidEmail;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.password,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.enterPassword,
                    mycontroller: pass,
                    isPassword: true,
                    onChanged: (value) {
                      formState.currentState!.validate();
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.enterPassword;
                      }

                      if (val.length < 8) {
                        return l10n.passwordMinLength;
                      }

                      if (RegExp(r'^[0-9]+$').hasMatch(val)) {
                        return l10n.passwordNumbersOnly;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.confirmPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.confirmPassword,
                    mycontroller: confirmpass,
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.confirmPassword;
                      }

                      if (val != pass.text) {
                        return l10n.passwordsDoNotMatch;
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
              onChanged: (bool? newValue) {
                setState(() {
                  value = newValue!;
                });
              },
              title: RichText(
                text: TextSpan(
                  style: const TextStyle(color: AppColors.black),
                  children: [
                    TextSpan(
                      text: "${l10n.iAgree} ",
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: l10n.termsPrivacy,
                      style: const TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  l10n.termsPrivacy,
                                  style: const TextStyle(
                                    color: AppColors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "• ${l10n.policyPoint1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "• ${l10n.policyPoint2}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "• ${l10n.policyPoint3}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      l10n.close,
                                      style: const TextStyle(
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButtonAuth(
              title: l10n.signUpButton,
              color: AppColors.orange,
              onPressed: () async {
                if (!value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.agreePrivacyPolicy,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  return;
                }

                if (formState.currentState!.validate()) {
                  final api = ApiService();
                  try {
                    final response = await api.register(
                      username.text,
                      email.text,
                      pass.text,
                    );

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.accountCreated,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: AppColors.green,
                        ),
                      );

                      Navigator.of(context).pushReplacementNamed("login");
                    } else {
                      throw Exception("Register failed");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.signupFailed,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        backgroundColor: AppColors.red,
                      ),
                    );
                  }
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
                    text: "${l10n.alreadyHaveAccount} ",
                    style: const TextStyle(color: AppColors.secondary),
                    children: [
                      TextSpan(
                        text: l10n.login,
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Divider(color: AppColors.black, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    l10n.orLoginWith,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(color: AppColors.black, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/google.svg",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 20),
                SvgPicture.asset(
                  "assets/icon/facebook.svg",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 12),
                SvgPicture.asset("assets/icon/x.svg", width: 50, height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
