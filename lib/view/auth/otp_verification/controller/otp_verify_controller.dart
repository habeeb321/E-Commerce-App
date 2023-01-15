import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/signup_screen/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/otp_verification/service/otp_service/verify_otp_service.dart';
import 'package:scotch/view/auth/signup_screen/service/signup_service/signup_service.dart';
import 'package:scotch/view/screens/bottom_nav_bar/view/bottom_nav_bar.dart';

class OtpVerifyController extends GetxController {
  VerifyOtpService verifyOtpService = VerifyOtpService();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  bool isLoading = false;
  String code = '';

  void onSubmitCode(String submitCode) {
    log(submitCode);
    code = submitCode;
    update();
  }

  void submitOtp(SignUpModel model, code, context) {
    if (code.length != 4) {
      Get.snackbar(
        'OTP',
        'Please enter the otp',
        backgroundColor: kBlackcolor,
        colorText: kWhitecolor,
      );
    } else {
      isLoading = true;
      update();
      verifyOtpService.verifyOtp(model.email, code, context).then(
        (value) {
          if (value != null) {
            SignupServices().signupUser(model, context).then((value) {
              if (value != null) {
                storage.write(key: 'token', value: value.accessToken);
                storage.write(key: 'refreshToken', value: value.refreshToken);
                Get.offAll(const BottomNavBar());
                isLoading = false;
                update();
              }
            });
          }
        },
      );
    }
  }
}
