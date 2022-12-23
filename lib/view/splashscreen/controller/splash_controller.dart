import 'dart:async';
import 'package:get/get.dart';
import 'package:scotch/view/startingscreen/view/starting_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () => Get.to(const StartingScreen()));
  }
}
