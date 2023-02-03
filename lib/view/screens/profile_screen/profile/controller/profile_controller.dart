import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/controller/login_controller.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/auth/signup_screen/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/signup_screen/service/signup_service/signup_service.dart';
import 'package:scotch/view/screens/profile_screen/address/view/address_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/profile_screen/profile/model/user_model.dart';
import 'package:scotch/view/screens/profile_screen/profile/service/user_profile_service.dart';

class ProfileController extends GetxController {
  ProfileController() {
    getProfileUser();
  }
  FlutterSecureStorage storage = const FlutterSecureStorage();
  BottomNavController bottomNavController = Get.put(BottomNavController());
  final LoginController signInProvider = LoginController();
  bool isLoading = false;
  UserModel? userDetials;

  void getUser() async {
    isLoading = true;
    update();
    final email = await storage.read(key: 'email');
    await UserProfileService().getUserDetials(email.toString()).then((value) {
      if (value != null) {
        isLoading = false;
        update();
        userDetials = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
  }

  SignUpModel? model;
  List<String>? userData;
  void logOut() async {
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
