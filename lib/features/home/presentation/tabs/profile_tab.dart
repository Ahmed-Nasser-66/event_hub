import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/profile/presentation/tabs/settings_screen.dart';
import 'package:event_hub/features/profile/presentation/tabs/privacy_screen.dart';
import 'package:event_hub/features/widgets/custombuttonauth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/profile_header.dart';
import '../../../widgets/profile_option_item.dart';
import '../../../profile/presentation/tabs/support_screen.dart' ;
import '../../../profile/presentation/tabs/language_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                const ProfileHeader(),

                const SizedBox(height: 10),

                ProfileOptionItem(
                  title: "Settings",
                  icon: Icons.settings_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),

                ProfileOptionItem(
                  title: "Language",
                  icon: Icons.language_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LanguageScreen()),
                    );
                  },
                ),

                ProfileOptionItem(
                  title: "Help & Support",
                  icon: Icons.headset_mic_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SupportScreen()),
                    );
                  },
                ),

                ProfileOptionItem(
                  title: "Terms & Privacy",
                  icon: Icons.description_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: CustomButtonAuth(
                title: 'Log out',
                color: AppColors.orange,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
