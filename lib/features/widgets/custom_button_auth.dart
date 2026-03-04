import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color color;
  const CustomButtonAuth({
    super.key,
    this.onPressed,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: 354,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      onPressed: onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,

          color: AppColors.secondary,
        ),
      ),
    );
  }
}
