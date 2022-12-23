import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/loginscreen/view/login_screen.dart';
import 'package:scotch/view/loginscreen/view/widgets/wave.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
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
                      SignUpField(
                          controller: userNameController,
                          label: 'Enter Your Username'),
                      kHeight10,
                      SignUpField(
                          controller: emailController,
                          label: 'Enter Your E-mail'),
                      kHeight10,
                      SignUpField(
                          controller: passController,
                          suffixIcon: const Icon(Icons.visibility_off),
                          label: 'Enter Your Password'),
                      kHeight10,
                      SignUpField(
                          controller: passController,
                          suffixIcon: const Icon(Icons.visibility_off),
                          label: 'Confirm Your Password'),
                      kHeight10,
                      const Align(
                          alignment: Alignment.topRight,
                          child: Text('Forget Password?')),
                    ],
                  ),
                  kHeight10,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(themeColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
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
      ),
    );
  }
}

class SignUpField extends StatelessWidget {
  const SignUpField({
    Key? key,
    required this.controller,
    required this.label,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(color: themeColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: themeColor),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
      ),
    );
  }
}
