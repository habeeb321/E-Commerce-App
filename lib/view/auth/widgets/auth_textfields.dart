import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.inputType,
    this.obscureText,
    this.validator,
    this.suffix,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputType? inputType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffix,
        labelStyle: const TextStyle(color: themeColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: themeColor),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
      ),
    );
  }
}
