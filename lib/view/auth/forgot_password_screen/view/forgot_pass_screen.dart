import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/forgot_password_screen/view/forgot_pass_otp_screen.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
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
                    const Column(
                      children: [
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
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Column(
                  children: [
                    const Text(
                        'Enter the E-mail associated with your account and we will send an email with instructions to reset your password.'),
                    kHeight20,
                    AuthTextField(
                      controller: emailController,
                      label: 'E-mail',
                    ),
                  ],
                ),
                kHeight20,
                AuthElevatedButton(
                  label: 'Continue',
                  onPressed: () => Get.to(const ForgotPassOtpScreen()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
