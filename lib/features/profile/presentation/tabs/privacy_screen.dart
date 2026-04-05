import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const String privacyText = """
This is the privacy policy of EventHub. We value your privacy and are committed to protecting your personal information. We collect and use your data in accordance with this policy. By using our app, you agree to the terms outlined in this privacy policy.

Terms and Conditions

By using this application, you agree to the following terms and conditions:

1. Use of the Application
You agree to use the application only for lawful purposes and not to misuse any of its services or content.

2. Privacy Policy
We respect users' privacy and may collect certain information such as name, email address, or phone number to improve user experience.

3. Data Protection
We are committed to protecting user data and will not share personal information with third parties without user consent.

4. User Responsibility
Users are responsible for the accuracy of the information they provide within the application.

5. Modifications
We reserve the right to modify these terms and conditions at any time. Continued use of the application indicates acceptance of any changes.

If you have any questions, please contact us via email.
""";
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
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            l10n.privacyPolicyTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.privacyPolicyText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
