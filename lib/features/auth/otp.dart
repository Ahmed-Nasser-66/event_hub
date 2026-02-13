import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // 1. المتغير اللي هيشيل الكود [cite: 2025-11-14]
  String currentCode = "";

  // 2. Logic إضافة الأرقام [cite: 2025-11-14]
  void onKeyTap(String key) {
    setState(() {
      if (key == "backspace") {
        if (currentCode.isNotEmpty) {
          currentCode = currentCode.substring(0, currentCode.length - 1);
        }
      } else {
        if (currentCode.length < 4) {
          currentCode += key;
        }
      }
    });

    // لو كمل 4 أرقام ممكن نخليه يروح للـ Home أوتوماتيك [cite: 2025-11-14]
    if (currentCode.length == 4) {
      print("Code entered: $currentCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Please check your email",
                    style: AppTextStyles.headingMedium.copyWith(
                      fontSize: 26,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "We have sent code to example@gmail.com",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),

                  // مربعات الـ OTP المربوطة بالمتغير [cite: 2025-11-14]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      // لو المتغير فيه رقم في المكان ده، اعرضه، غير كدة سيبه فاضي
                      String digit = "";
                      if (currentCode.length > index) {
                        digit = currentCode[index];
                      }
                      return _buildOtpBox(digit);
                    }),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Didn’t receive a code? ",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.secondary,
                        ),
                        children: [
                          TextSpan(
                            text: "Resend Code",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildCustomKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(String digit) {
    return Container(
      width: 65,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // لو المربع فيه رقم، بنغير لون البوردر عشان اليوزر يعرف إنه كتب فيه [cite: 2025-11-14]
        border: Border.all(
          color: digit.isNotEmpty ? AppColors.orange : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          digit,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomKeypad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          _buildKeypadRow(["1", "2", "3"]),
          const SizedBox(height: 15),
          _buildKeypadRow(["4", "5", "6"]),
          const SizedBox(height: 15),
          _buildKeypadRow(["7", "8", "9"]),
          const SizedBox(height: 15),
          _buildKeypadRow(["", "0", "backspace"]),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => _buildKey(key)).toList(),
    );
  }

  Widget _buildKey(String key) {
    if (key.isEmpty) return const SizedBox(width: 90, height: 55);

    return Container(
      width: 90,
      height: 55,
      decoration: BoxDecoration(
        color: key == "backspace" ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: key == "backspace"
            ? []
            : [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.02),
                  blurRadius: 5,
                ),
              ],
      ),
      child: key == "backspace"
          ? IconButton(
              onPressed: () =>
                  onKeyTap("backspace"), // نداء للـ Logic [cite: 2025-11-14]
              icon: const Icon(
                Icons.backspace_outlined,
                color: AppColors.secondary,
              ),
            )
          : TextButton(
              onPressed: () =>
                  onKeyTap(key), // نداء للـ Logic [cite: 2025-11-14]
              child: Text(
                key,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
    );
  }
}
