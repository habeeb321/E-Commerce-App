import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/registerscreen/controller/signup_controller.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                            height: size.height * 0.46,
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 50),
                          color: themeColor,
                          height: size.height * 0.42,
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
                            'Reset Password',
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
                    const Text(
                        'Set the new password for your account so you can login and access all the features.'),
                    kHeight20,
                    AuthTextField(
                      controller: emailController,
                      suffix: IconButton(
                          onPressed: () => signUpController.visibility(),
                          icon: signUpController.icon),
                      label: 'Enter Your Password',
                    ),
                    kHeight20,
                    AuthTextField(
                      controller: emailController,
                      suffix: IconButton(
                          onPressed: () => signUpController.visibility(),
                          icon: signUpController.icon),
                      label: 'Confirm Your Password',
                    ),
                  ],
                ),
                kHeight20,
                AuthElevatedButton(
                  label: 'Reset Password',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
