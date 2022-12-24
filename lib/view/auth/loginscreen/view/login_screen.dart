import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/forgotpasswordscreen/view/forgot_pass_screen.dart';
import 'package:scotch/view/auth/registerscreen/view/register_screen.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/auth_textfields.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Column(
                  children: [
                    AuthTextField(
                        controller: emailController,
                        label: 'Enter Your E-mail'),
                    kHeight20,
                    AuthTextField(
                        controller: emailController,
                        suffixIcon: const Icon(Icons.visibility_off),
                        label: 'Enter Your Password'),
                    kHeight10,
                    InkWell(
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Text('Forget Password?'),
                      ),
                      onTap: () {
                        Get.to(ForgotPassScreen());
                      },
                    ),
                  ],
                ),
                kHeight20,
                const AuthElevatedButton(label: 'Sign In'),
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/logo/GOOGLE.png'),
                        backgroundColor: kWhitecolor,
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/logo/Facebook.png'),
                        backgroundColor: kWhitecolor,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                kHeight10,
                const Text('Or'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet?"),
                    TextButton(
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
