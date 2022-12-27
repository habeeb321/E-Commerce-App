import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/signupscreen/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/otpverification/service/otpservice/send_otp_service.dart';
import 'package:scotch/view/auth/signupscreen/service/signupservice/signup_service.dart';
import 'package:scotch/view/auth/otpverification/view/otp_verify_screen.dart';

class SignUpController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  SignupServices signupServices = SignupServices();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isLoading = false;
  Future<void> signupUser(BuildContext context) async {
    isLoading = true;
    update();
    final model = SignUpModel(
      email: emailController.text,
      password: passController.text,
      phone: mobileController.text,
      fullName: fullNameController.text,
    );

    SendOtpServices().sendOtp(model.email, context).then((value) {
      if (value != null) {
        Get.to(() => OtpVerifyScreen(model: model));
        disposeTextfield();
      } else {
        return;
      }
    });
    isLoading = false;
    update();
  }

  void disposeTextfield() {
    fullNameController.clear();
    emailController.clear();
    passController.clear();
    mobileController.clear();
    confirmPassController.clear();
  }

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the fullname';
    } else {
      return null;
    }
  }

  String? usernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the username';
    } else if (value.length < 2) {
      return 'Too short username';
    } else {
      return null;
    }
  }

  String? emailValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Invalid email , please enter correct email';
    } else {
      return null;
    }
  }

  String? mobileValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length < 10) {
      return 'Invalid mobile number,make sure your entered 10 digits';
    } else {
      return null;
    }
  }

  String? passwordValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must have atleast 8 character';
    } else if (value.length > 8) {
      return 'Password exceeds 8 character';
    }
    return null;
  }

  String? confirmpasswordValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value.length < 8) {
      return 'Password must have atleast 8 character';
    } else if (value != passController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  bool obscureText = true;
  Icon icon = const Icon(
    Icons.visibility_off,
    color: kBlackcolor,
  );

  void visibility() {
    if (obscureText == false) {
      icon = const Icon(
        Icons.visibility_off,
        color: kBlackcolor,
      );
      obscureText = true;
      update();
    } else {
      icon = const Icon(
        Icons.visibility,
        color: kBlackcolor,
      );
      obscureText = false;
      update();
    }
  }
}
