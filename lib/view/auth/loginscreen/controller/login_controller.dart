import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/model/model/loginmodel/login_model.dart';
import 'package:scotch/model/services/loginservice/login_service.dart';
import 'package:scotch/view/screens/home_screen.dart';
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
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (route) => false);
          disposeTextfield();
        } else {
          return;
        }
      },
    );
    isLoading = false;
    update();
  }

  void disposeTextfield() {
    emailController.clear();
    passController.clear();
  }
}
