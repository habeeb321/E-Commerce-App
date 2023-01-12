import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.text,
    required this.ontap,
    this.icon,
    required this.trailIcon,
    required this.size,
  }) : super(key: key);
  final String text;
  final Function() ontap;
  final Widget? icon;
  final Widget trailIcon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 22,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.grey.shade300,
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "Manrope",
          fontSize: size,
        ),
      ),
      onTap: ontap,
      leading: icon,
      trailing: trailIcon,
    );
  }
}
