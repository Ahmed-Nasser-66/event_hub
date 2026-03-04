import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/features/widgets/text_form_field.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
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
                  Text(
                    l10n.editProfileTitle,
                    style: const TextStyle(
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
                        l10n.changePicture,
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
                    hinttext: l10n.fullName,
                    mycontroller: username,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.enterFullName;
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
                    l10n.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.enterPhoneNumber,
                    mycontroller: phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.enterPhoneNumber;
                      }
                      if (!RegExp(r'^[0-9]{11}$').hasMatch(val)) {
                        return l10n.phoneMustBe11Digits;
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
                    l10n.retypePassword,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextForm(
                    hinttext: l10n.retypePasswordHint,
                    mycontroller: confirmpass,
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return l10n.retypePasswordError;
                      }
                      if (val != pass.text) {
                        return l10n.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonAuth(
                          title: l10n.cancel,
                          color: AppColors.grey,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomButtonAuth(
                          title: l10n.save,
                          color: AppColors.orange,
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              context.read<UserProvider>().setUser(
                                username.text,
                                email.text,
                              );
                              Navigator.pop(context);
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
