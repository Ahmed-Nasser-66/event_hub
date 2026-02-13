import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        backgroundColor: AppColors.grey,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "login");
          },
        ),
      ),
    );
  }
}
