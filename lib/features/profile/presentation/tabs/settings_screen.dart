import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

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
            "Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '''This is the settings page. Here you can customize your EventHub experience by adjusting various preferences and options. You can enable or disable notifications, and configure other app features to suit your needs.''',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),

          SwitchListTile(
            title: const Text("Notifications"),
            subtitle: const Text("Enable app notifications"),
            secondary: const Icon(Icons.notifications_outlined),
            value: notificationsEnabled,
            activeTrackColor: AppColors.orange,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.secondary,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
            },
          ),
        ],
      ),
    );
  }
}
