import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/auth/signup_screen/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/signup_screen/service/signup_service/signup_service.dart';
import 'package:scotch/view/screens/address_screen/view/address_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';

class ProfileController extends GetxController {
  ProfileController() {
    getProfileUser();
  }
  BottomNavController bottomNavController = Get.put(BottomNavController());
  bool isLoading = false;

  SignUpModel? model;
  List<String>? userData;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  void logOut(context) async {
    isLoading = true;
    update();
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
    Get.offAll(LoginScreen());
    bottomNavController.currentIndex = 0;
    update();
    isLoading = false;
    update();
  }

  void getProfileUser() async {
    await SignupServices().getUser().then((value) {
      if (value != null) {
        model = value;
        update();
      }
    });
  }

  void goToAddressPage() {
    Get.to(const AddressScreen());
    update();
  }
}
