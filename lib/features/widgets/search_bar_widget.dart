import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Searchbarwidget extends StatelessWidget {
  /// TextEditingController => بستخدمه في
  /// 1- تخزين الكلام ==> Controller.text
  /// 2- يمسح الكلمه ==> Controller.Clear();
  /// 3-  او التحقق من الادخال بيبحث علطول عن طريق ==> Controller.addListener((){print(Controller.text);});
  final TextEditingController controller;

  /// required this.controller => بستخدمه عشان
  /// 1- استقبل الكنترولر
  const Searchbarwidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// BoxDecoration ==> الشكل من برا
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),

      /// عشان اربط الكنترولر
      child: TextField(
        controller: controller,

        /// BoxDecoration ==> بتحكم في الخواص اللي جوة
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.findEvent,

          border: InputBorder.none, // لاني متحكم فشكله فوق اصلا
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(left: 15, top: 10),
        ),
      ),
    );
  }
}
