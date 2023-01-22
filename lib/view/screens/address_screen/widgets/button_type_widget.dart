import 'package:flutter/material.dart';

class AddressTypeButton extends StatelessWidget {
  const AddressTypeButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });

  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: borderColor),
        ),
      ),
      icon: Icon(
        icon,
        color: color,
      ),
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
