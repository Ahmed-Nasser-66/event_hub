import 'package:event_hub/core/api/auth_api_service.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
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
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                    l10n.forgotPassword,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.enterEmailDescription,
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
                l10n.email,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
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
              const SizedBox(height: 20),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              CustomButtonAuth(
                  title: l10n.sendCode,
                  color: AppColors.orange,
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      await ApiService().forgotPassword(email.text);
                      if (!context.mounted) return;
                      Navigator.pushReplacementNamed(
                        context,
                        "varification",
                        arguments: email.text,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
