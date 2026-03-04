import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/l10n/app_localizations.dart';
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
            l10n.settingsTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.settingsDescription,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: Text(l10n.notifications),
            subtitle: Text(l10n.enableNotifications),
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
