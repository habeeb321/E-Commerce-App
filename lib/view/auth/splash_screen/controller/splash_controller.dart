import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/auth/splash_screen/view/splash_screen.dart';
import 'package:scotch/view/auth/starting_screen/view/starting_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/view/bottom_nav_bar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () async {
      onboardValue = await storage.read(key: 'onboard');
      signinCheck = await storage.read(key: 'token');
      Get.to(const SplashScreen());
      if (signinCheck != null) {
        Get.offAll(const BottomNavBar());
      } else {
        if (onboardValue != null) {
          Get.offAll(LoginScreen());
        } else {
          Get.to(const StartingScreen());
        }
      }
    });
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? onboardValue;
  String? signinCheck;
}
