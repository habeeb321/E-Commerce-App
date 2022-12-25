import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:scotch/model/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/otpverification/controller/otp_verify_controller.dart';
import 'package:scotch/view/auth/registerscreen/controller/signup_controller.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key, required this.model});

  final SignUpModel model;
  OtpVerifyController otpVerifyController = Get.put(OtpVerifyController());
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
                            'OTP Verification',
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
                SizedBox(height: size.height * 0.13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter 4 Digits Code',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    kHeight20,
                    OTPTextField(
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 50,
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) {
                        log("Completed: $pin");
                      },
                    ),
                  ],
                ),
                kHeight20,
                GetBuilder<OtpVerifyController>(builder: (controller) {
                  return AuthElevatedButton(
                    label: 'Verify',
                    onPressed: () {
                      otpVerifyController.submitOtp(
                          model, otpVerifyController.code, context);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
