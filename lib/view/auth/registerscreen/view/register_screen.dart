import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/loginscreen/view/login_screen.dart';
import 'package:scotch/view/widgets/auth_elev_button.dart';
import 'package:scotch/view/widgets/auth_textfields.dart';
import 'package:scotch/view/widgets/wave.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

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
                      Column(
                        children: const [
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
                ),
                SizedBox(height: size.height * 0.03),
                Column(
                  children: [
                    AuthTextField(
                        controller: userNameController,
                        label: 'Enter Your FullName'),
                    kHeight10,
                    AuthTextField(
                        controller: emailController,
                        label: 'Enter Your E-mail'),
                    kHeight10,
                    AuthTextField(
                        controller: mobileController,
                        inputType: TextInputType.number,
                        label: 'Enter Your Mobile Number'),
                    kHeight10,
                    AuthTextField(
                        controller: passController,
                        suffixIcon: const Icon(Icons.visibility_off),
                        label: 'Enter Your Password'),
                    kHeight10,
                    AuthTextField(
                        controller: passController,
                        suffixIcon: const Icon(Icons.visibility_off),
                        label: 'Confirm Your Password'),
                  ],
                ),
                kHeight20,
                const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthElevatedButton(label: 'Sign Up'),
                ),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: const Text('Login'),
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
