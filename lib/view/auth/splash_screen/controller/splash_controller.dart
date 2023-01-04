import 'dart:async';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/auth/starting_screen/view/starting_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/view/bottom_nav_bar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () => Get.to(const StartingScreen()));
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? onboardValue;
  String? signinCheck;

  void splashTimer(context) {
    Timer(
      const Duration(seconds: 3),
      () async {
        onboardValue = await storage.read(key: 'onboard');
        signinCheck = await storage.read(key: 'token');
        log(signinCheck.toString());
        if (signinCheck != null) {
          Get.offAll(BottomNavBar());
        } else {
          if (onboardValue != null) {
            Get.offAll(LoginScreen());
          } else {
            Get.offAll(const StartingScreen());
          }
        }
      },
    );
  }
}
