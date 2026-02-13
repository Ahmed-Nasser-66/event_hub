import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomTextForm({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.mycontroller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? obscure : false,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xff343A40)),
        contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
        filled: true,
        fillColor: const Color(0xffffffff),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
