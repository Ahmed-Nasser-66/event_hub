import 'package:event_hub/core/api/api_service.dart';
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
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  bool isResending = false;

  /// 🔥 تخزين OTP
  List<String> otp = ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    /// 🔥 استلام الإيميل
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? "";

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
              /// 🔹 Title
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
                    "${l10n.codeSentTo} $email",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// 🔥 OTP INPUT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      cursorColor: AppColors.secondary,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.orange,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        otp[index] = value;

                        if (value.isNotEmpty) {
                          if (index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus(); // 👈 مهم
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              /// 🔹 Resend
              InkWell(
                onTap: isResending
                    ? null
                    : () async {
                        setState(() => isResending = true);

                        final api = ApiService();

                        try {
                          await api.sendOtp(email);

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.otpResentSuccess)),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.otpResendFailed)),
                          );
                        }

                        setState(() => isResending = false);
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

              const SizedBox(height: 40),

              /// 🔥 BUTTON
              CustomButtonAuth(
                title: l10n.goToResetPassword,
                color: AppColors.orange,

                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        String enteredOtp = otp.join();

                        if (enteredOtp.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.enterFullCode)),
                          );
                          setState(() => isLoading = false);
                          return;
                        }

                        final api = ApiService();

                        try {
                          final response = await api.verifyOtp(
                            email,
                            enteredOtp,
                          );
                          if (!context.mounted) return;

                          if (response.data["status"] == "success") {
                            Navigator.pushReplacementNamed(
                              context,
                              "restpassword",
                            );
                          } else {
                            throw Exception();
                          }
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.invalidOtp)),
                          );
                        }

                        setState(() => isLoading = false);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
