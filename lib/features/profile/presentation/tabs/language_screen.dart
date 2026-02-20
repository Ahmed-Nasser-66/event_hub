import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
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
            "Language",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '''This is the language settings page. Here you can select your preferred language for the EventHub app. We currently support English and Arabic.
Please select your language from the options below.''',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            title: Text(
              isArabic ? "العربية" : "English",
              style: TextStyle(
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
              setState(() {
                isArabic = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
