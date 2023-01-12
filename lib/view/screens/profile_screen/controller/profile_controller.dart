import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';

class ProfileController extends GetxController {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  bool isLoading = false;

  FlutterSecureStorage storage = const FlutterSecureStorage();
  void logOut(context) async {
    isLoading = true;
    update();
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
    Get.off(LoginScreen());
    bottomNavController.currentIndex = 0;
    update();
    isLoading = false;
    update();
  }
}
