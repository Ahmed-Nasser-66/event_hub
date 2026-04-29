import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/profile/presentation/tabs/privacy_screen.dart';
import 'package:event_hub/features/profile/presentation/widget/change_language.dart';
import 'package:event_hub/features/profile/presentation/widget/change_notification.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/tabs/support_screen.dart';
import 'presentation/widget/profile_header.dart';
import 'presentation/widget/profile_option_item.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>();

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
                Text(
                  l10n.account,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                ProfileHeader(name: user.name, email: user.email),
                const SizedBox(height: 10),
                Text(
                  l10n.settings,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                ProfileOptionItem(
                  title: l10n.notifications,
                  icon: Icons.notifications_none,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (_) => const NotificationSheet(),
                    );
                  },
                ),
                ProfileOptionItem(
                  title: l10n.language,
                  icon: Icons.language_outlined,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (_) => const ChangeLanguageSheet(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.support,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                ProfileOptionItem(
                  title: l10n.helpSupport,
                  icon: Icons.headset_mic_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SupportScreen()),
                    );
                  },
                ),
                ProfileOptionItem(
                  title: l10n.termsPrivacy,
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
                  title: l10n.logout,
                  color: AppColors.orange,
                  onPressed: () async {
                    await context.read<UserProvider>().logout();

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "login",
                      (route) => false,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
