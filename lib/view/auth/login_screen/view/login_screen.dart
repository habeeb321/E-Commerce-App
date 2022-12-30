import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/forgot_password_screen/view/forgot_pass_screen.dart';
import 'package:scotch/view/auth/login_screen/controller/login_controller.dart';
import 'package:scotch/view/auth/signup_screen/controller/signup_controller.dart';
import 'package:scotch/view/auth/signup_screen/view/signup_screen.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());
  SignUpController signUpController = Get.put(SignUpController());
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formGlobalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              color: themeColor,
                              height: size.height * 0.42,
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 50),
                            color: themeColor,
                            height: size.height * 0.38,
                            alignment: Alignment.center,
                          ),
                        ),
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(logo),
                            ),
                            kHeight20,
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: kWhitecolor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Column(
                    children: [
                      GetBuilder<LoginController>(builder: (controller) {
                        return AuthTextField(
                            controller: loginController.emailController,
                            validator: (value) =>
                                loginController.emailValdation(value),
                            label: 'E-mail');
                      }),
                      kHeight20,
                      GetBuilder<LoginController>(builder: (controller) {
                        return AuthTextField(
                            controller: loginController.passController,
                            validator: (value) =>
                                loginController.passwordValdation(value),
                            suffix: IconButton(
                                onPressed: () => loginController.visibility(),
                                icon: loginController.icon),
                            obscureText: loginController.obscureText,
                            label: 'Password');
                      }),
                      kHeight10,
                      InkWell(
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Text('Forget Password?'),
                        ),
                        onTap: () {
                          Get.to(() => ForgotPassScreen());
                        },
                      ),
                    ],
                  ),
                  kHeight20,
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return AuthElevatedButton(
                        label: 'Sign In',
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            log('login');
                            formGlobalKey.currentState!.save();
                            loginController.logIn(context);
                          }
                        },
                      );
                    },
                  ),
                  kHeight20,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     InkWell(
                  //       child: const CircleAvatar(
                  //         radius: 20,
                  //         backgroundImage: AssetImage('assets/logo/GOOGLE.png'),
                  //         backgroundColor: kWhitecolor,
                  //       ),
                  //       onTap: () {},
                  //     ),
                  //     // InkWell(
                  //     //   child: const CircleAvatar(
                  //     //     radius: 20,
                  //     //     backgroundImage:
                  //     //         AssetImage('assets/logo/Facebook.png'),
                  //     //     backgroundColor: kWhitecolor,
                  //     //   ),
                  //     //   onTap: () {},
                  //     // ),
                  //   ],
                  // ),
                  const Text('Or'),
                  kHeight10,
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: kBlackcolor),
                      children: <TextSpan>[
                        const TextSpan(text: "Don't have an account yet?"),
                        TextSpan(
                          text: '   Sign up',
                          style: const TextStyle(color: themeColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(SignUpScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
