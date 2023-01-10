import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (context) {
          return const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(logo),
            ),
          );
        },
      ),
    );
  }
}
