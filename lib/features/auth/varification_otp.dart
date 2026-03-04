import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

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
                children: [
                  Text(
                    l10n.checkEmail,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${l10n.codeSentTo} example@gmail.com",
                    style: const TextStyle(
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
                      text: " ${l10n.didNotReceiveCode} ",
                      style: const TextStyle(color: AppColors.secondary),
                      children: [
                        TextSpan(
                          text: l10n.resendCode,
                          style: const TextStyle(
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
              const Padding(padding: EdgeInsets.only(bottom: 50)),

              CustomButtonAuth(
                title: l10n.goToResetPassword,
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
