import 'package:flutter/material.dart';

class RowOrderWidget extends StatelessWidget {
  const RowOrderWidget({
    Key? key,
    this.color,
    required this.text,
    required this.text2,
  }) : super(key: key);

  final Color? color;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(
          text2,
          // "₹${(provider.price - provider.discountPrice).round()}",
          style: TextStyle(
            fontFamily: "Manrope",
            color: color,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        )
      ],
    );
  }
}
