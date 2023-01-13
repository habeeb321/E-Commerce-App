import 'package:get/get.dart';
import 'package:scotch/view/auth/login_screen/controller/login_controller.dart';
import 'package:scotch/view/auth/otp_verification/controller/otp_verify_controller.dart';
import 'package:scotch/view/auth/signup_screen/controller/signup_controller.dart';
import 'package:scotch/view/auth/splash_screen/controller/splash_controller.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';

class AllBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
