import 'package:event_hub/core/theme/app_assets.dart';
import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
      ),
    );
  }
}
