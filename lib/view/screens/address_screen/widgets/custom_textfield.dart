import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.suffix,
    required this.controller,
    required this.validator,
    this.obscureText,
    required this.keyboard,
    this.onChanged,
    required this.text,
    this.contentPadding,
    this.preffix,
    this.hintText,
    this.colorFill,
  }) : super(key: key);

  final Widget? suffix;
  final Widget? preffix;
  final String? hintText;
  final Color? colorFill;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool? obscureText;
  final String text;

  final TextInputType keyboard;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      keyboardType: keyboard,
      controller: controller,
      style: const TextStyle(color: kBlackcolor),
      validator: validator,
      decoration: InputDecoration(
        fillColor: colorFill,
        suffixIcon: suffix,
        hintText: hintText,
        prefixIcon: preffix,
        label: Text(
          text,
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontFamily: 'Manrope',
              fontWeight: FontWeight.bold),
        ),
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBlackcolor),
          borderRadius: BorderRadius.circular(20),
        ),
        enabled: true,
      ),
    );
  }
}
