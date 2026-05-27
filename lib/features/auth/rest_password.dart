import 'package:event_hub/core/api/auth_api_service.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final email = args["email"];
    final code = args["code"];

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
                children: [
                  Text(
                    l10n.createNewPassword,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.createStrongPasswordDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                l10n.newPassword,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextForm(
                hinttext: l10n.enterPassword,
                mycontroller: password,
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
                mycontroller: confirmPassword,
                isPassword: true,
                onChanged: (value) {
                  formState.currentState!.validate();
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return l10n.confirmPassword;
                  }

                  if (val != password.text) {
                    return l10n.passwordsDoNotMatch;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              CustomButtonAuth(
                  title: l10n.resetPassword,
                  color: AppColors.orange,
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        final response = await ApiService().resetPassword(
                            email, code.toString(), password.text);

                        if (response.data["success"] == true) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.passwordUpdatedSuccessfully),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pushReplacementNamed(context, "login");
                        } else {
                          throw Exception(response.data["message"]);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.invalidOtp),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
