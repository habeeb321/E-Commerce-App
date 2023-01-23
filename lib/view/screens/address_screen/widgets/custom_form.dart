import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class CustomFormWidget extends StatelessWidget {
  const CustomFormWidget({
    Key? key,
    this.suffix,
    required this.controller,
    required this.validator,
    this.obscureText,
    required this.keyboard,
    this.onChanged,
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
  final TextInputType keyboard;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: keyboard,
        controller: controller,
        style: const TextStyle(color: kBlackcolor),
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: colorFill,
          suffixIcon: suffix,
          hintText: hintText,
          prefixIcon: preffix,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kWhitecolor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
