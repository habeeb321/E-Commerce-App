import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class AuthElevatedButton extends StatelessWidget {
  const AuthElevatedButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(themeColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: kWhitecolor),
        ),
      ),
    );
  }
}
