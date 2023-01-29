import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({
    Key? key,
    required this.countNumber,
    required this.minusPressed,
    required this.plusPressed,
  }) : super(key: key);
  final String countNumber;
  final void Function() minusPressed;
  final void Function() plusPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: minusPressed,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeColor,
            ),
            child: const Icon(
              Icons.remove,
              size: 16,
              color: kWhitecolor,
            ),
          ),
        ),
        kWidth10,
        Text(
          countNumber,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        kWidth10,
        InkWell(
          onTap: plusPressed,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeColor,
            ),
            child: const Icon(
              Icons.add,
              size: 16,
              color: kWhitecolor,
            ),
          ),
        ),
      ],
    );
  }
}
