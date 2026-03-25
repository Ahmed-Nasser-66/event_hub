import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _buildFlagCircle(String imagePath) {
    return ClipOval(
      child: SvgPicture.asset(
        imagePath,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "onboarding");
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(AppAssets.event, height: 80, fit: BoxFit.contain),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 29),
                  child: Image.asset(
                    AppAssets.login,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),

                Text(
                  l10n.welcome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 30),

                CustomButtonAuth(
                  title: l10n.login,
                  color: AppColors.orange,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("login");
                  },
                ),

                const SizedBox(height: 12),

                CustomButtonAuth(
                  title: l10n.signup,
                  color: AppColors.grey,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                ),

                Center(
                  child: AnimatedToggleSwitch<String>.rolling(
                    current: languageProvider.appLanguage,
                    values: const ['en', 'ar'],
                    iconList: [
                      _buildFlagCircle('assets/icon/LR.svg'),
                      _buildFlagCircle('assets/icon/EG.svg'),
                    ],
                    onChanged: (newVal) {
                      languageProvider.changeLanguage(newVal);
                    },
                    style: const ToggleStyle(
                      backgroundColor: Colors.white10,
                      borderColor: AppColors.orange,
                      indicatorColor: AppColors.orange,
                    ),
                    height: 45,
                    indicatorSize: const Size(40, 40),
                  ),
                ),

                const SizedBox(height: 10),

                ///        متنساش تمسحو
                CustomButtonAuth(
                  title: l10n.home,
                  color: const Color.fromARGB(255, 248, 207, 0),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("homepage");
                  },
                ),
                //     لحد هنا
              ],
            ),
          ),
        ),
      ),
    );
  }
}
