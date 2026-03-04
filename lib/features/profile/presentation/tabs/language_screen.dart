import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<AppLanguageProvider>();
    final l10n = AppLocalizations.of(context)!;

    final bool isArabic = languageProvider.appLanguage == 'ar';

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
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            l10n.language,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.languageDescription,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 20),

          SwitchListTile(
            title: Text(
              isArabic ? l10n.arabic : l10n.english,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
            value: isArabic,
            activeTrackColor: AppColors.orange,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.secondary,
            onChanged: (value) {
              if (value) {
                context.read<AppLanguageProvider>().changeLanguage('ar');
              } else {
                context.read<AppLanguageProvider>().changeLanguage('en');
              }
            },
          ),
        ],
      ),
    );
  }
}
