import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
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
