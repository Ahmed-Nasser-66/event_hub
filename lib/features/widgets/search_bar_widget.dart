import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Searchbarwidget extends StatelessWidget {
  final TextEditingController controller;

  final Function(String)? onChanged;

  const Searchbarwidget({
    super.key,
    required this.controller,
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.findEvent,
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 20, top: 12),
        ),
      ),
    );
  }
}
