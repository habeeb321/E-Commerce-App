import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/loginscreen/model/loginmodel/login_model.dart';
import 'package:scotch/view/auth/loginscreen/service/loginservice/login_service.dart';
import 'package:scotch/view/screens/bottomnavbar/view/bottom_nav_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  LoginService loginService = LoginService();
  bool isLoading = false;
  void logIn(BuildContext context) {
    isLoading = true;
    update();
    final LoginModel loginModel = LoginModel(
      email: emailController.text,
      password: passController.text,
    );
    loginService.loginUser(loginModel, context).then(
      (value) {
        if (value != null) {
          storage.write(key: 'token', value: value.accessToken);
          storage.write(key: 'refreshToken', value: value.refreshToken);
          Get.offAll(BottomNavBar());
          disposeTextfield();
        } else {
          return;
        }
      },
    );
    isLoading = false;
    update();
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

  void disposeTextfield() {
    emailController.clear();
    passController.clear();
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
}
