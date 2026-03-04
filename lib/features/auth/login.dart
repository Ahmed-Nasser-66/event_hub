import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/custom_logo_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    final l10n = AppLocalizations.of(context)!;

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
                  const CustomLogoAuth(),
                  const SizedBox(height: 20),

                  Text(
                    l10n.loginNow,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    l10n.signInToAccount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 10),

                  Text(
                    l10n.password,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  CustomTextForm(
                    hinttext: l10n.enterPassword,
                    mycontroller: pass,
                    isPassword: true,
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
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed("forgotpassword");
                  },
                  child: Text(
                    l10n.forgotPassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            CustomButtonAuth(
              title: l10n.login,
              color: AppColors.orange,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  context.read<UserProvider>().setUser(
                    email.text.split("@")[0], // اسم مؤقت من الإيميل
                    email.text,
                  );

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
                    text: "${l10n.noAccount} ",
                    style: const TextStyle(color: AppColors.secondary),
                    children: [
                      TextSpan(
                        text: l10n.signup,
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

            const SizedBox(height: 50),

            Text(
              "__________________  ${l10n.orLoginWith}  __________________",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 60),

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
