import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const CustomBackButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: color, size: 24),
      onPressed: onPressed,
    );
  }
}
