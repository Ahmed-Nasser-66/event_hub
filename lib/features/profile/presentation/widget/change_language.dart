import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeLanguageSheet extends StatefulWidget {
  const ChangeLanguageSheet({super.key});

  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  String selectedLang = "en";

  @override
  void initState() {
    super.initState();
    selectedLang = context.read<AppLanguageProvider>().appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.changeLanguage,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            RadioGroup<String>(
              groupValue: selectedLang,
              onChanged: (value) {
                setState(() {
                  selectedLang = value!;
                });
              },
              child: Column(
                children: [
                  buildOption(l10n.arabic, "ar"),
                  const SizedBox(height: 10),
                  buildOption(l10n.english, "en"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AppLanguageProvider>().changeLanguage(
                      selectedLang,
                    );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                l10n.confirm,
                style: const TextStyle(color: AppColors.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String title, String lang) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLang = lang;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selectedLang == lang
              ? AppColors.orange.withValues(alpha: 0.1)
              : AppColors.grey.withValues(alpha: 1),
          border: Border.all(
            color: selectedLang == lang
                ? AppColors.orange
                : AppColors.black.withValues(alpha: 0.7),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight:
                    selectedLang == lang ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Radio<String>(value: lang, activeColor: AppColors.orange),
          ],
        ),
      ),
    );
  }
}
