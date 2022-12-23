import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/loginscreen/view/widgets/wave.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
                              'Login',
                              style: TextStyle(
                                  fontSize: 40,
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
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: themeColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Enter your E-mail',
                        ),
                      ),
                      kHeight20,
                      TextFormField(
                        controller: passController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.visibility_off,
                              color: kBlackcolor),
                          labelStyle: const TextStyle(color: themeColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: themeColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Enter your Password',
                        ),
                      ),
                      kHeight10,
                      const Align(
                          alignment: Alignment.topRight,
                          child: Text('Forget Password?')),
                    ],
                  ),
                  kHeight20,
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
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
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
                          backgroundImage:
                              AssetImage('assets/logo/Facebook.png'),
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
                        onPressed: () {},
                        child: const Text('Sign up'),
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
