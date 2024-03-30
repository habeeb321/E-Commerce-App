import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/login_screen/view/login_screen.dart';
import 'package:scotch/view/auth/signup_screen/controller/signup_controller.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: themeColor,
                          height: size.height * 0.40,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        color: themeColor,
                        height: size.height * 0.36,
                        alignment: Alignment.center,
                      ),
                    ),
                    const Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(logo),
                        ),
                        kHeight10,
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kWhitecolor),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Form(
                  key: formGlobalKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: GetBuilder<SignUpController>(builder: (controller) {
                    return Column(
                      children: [
                        AuthTextField(
                            controller: controller.fullNameController,
                            validator: (value) =>
                                controller.nameValidation(value),
                            label: 'FullName'),
                        kHeight10,
                        AuthTextField(
                            controller: controller.emailController,
                            validator: (value) =>
                                controller.emailValdation(value),
                            label: 'E-mail'),
                        kHeight10,
                        AuthTextField(
                            validator: (value) =>
                                controller.mobileValdation(value),
                            controller: controller.mobileController,
                            inputType: TextInputType.number,
                            label: 'Mobile Number'),
                        kHeight10,
                        AuthTextField(
                            controller: controller.passController,
                            validator: (value) =>
                                controller.passwordValdation(value),
                            obscureText: controller.obscureText,
                            suffix: IconButton(
                                onPressed: () => controller.visibility(),
                                icon: controller.icon),
                            inputType: TextInputType.visiblePassword,
                            label: 'Password'),
                        kHeight10,
                        AuthTextField(
                            controller: controller.confirmPassController,
                            validator: (value) =>
                                controller.passwordValdation(value),
                            obscureText: controller.obscureText,
                            suffix: IconButton(
                                onPressed: () => controller.visibility(),
                                icon: controller.icon),
                            inputType: TextInputType.visiblePassword,
                            label: 'Confirm Password'),
                      ],
                    );
                  }),
                ),
                kHeight10,
                GetBuilder<SignUpController>(builder: (controller) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AuthElevatedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          controller.signupUser(context);
                        }
                      },
                    ),
                  );
                }),
                kHeight10,
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: kBlackcolor),
                    children: <TextSpan>[
                      const TextSpan(text: "Already have an account yet?"),
                      TextSpan(
                        text: '   Sign in',
                        style: const TextStyle(color: themeColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(LoginScreen());
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
    );
  }
}
