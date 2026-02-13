import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFormAdd extends StatelessWidget {
  final String hinttext;
  final Widget? prefixIcon;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;

  const CustomTextFormAdd({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        prefixIcon: prefixIcon,
        prefixStyle: TextStyle(fontSize: 14, color: AppColors.grey),
        hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color(0xffE9ECEF)),
        ),
      ),
    );
  }
}
