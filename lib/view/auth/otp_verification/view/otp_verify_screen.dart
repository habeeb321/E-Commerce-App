import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/signup_screen/model/signupmodel/signup_model.dart';
import 'package:scotch/view/auth/otp_verification/controller/otp_verify_controller.dart';
import 'package:scotch/view/auth/widgets/auth_elev_button.dart';
import 'package:scotch/view/auth/widgets/wave.dart';

class OtpVerifyScreen extends GetView<OtpVerifyController> {
  const OtpVerifyScreen({super.key, required this.model});

  final SignUpModel model;

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
                    GetBuilder<OtpVerifyController>(
                      builder: (controller) {
                        return OtpTextField(
                          textStyle: const TextStyle(color: Colors.black),
                          numberOfFields: 4,
                          borderColor: kBlackcolor,
                          enabledBorderColor: kBlackcolor,
                          borderRadius: BorderRadius.circular(12),
                          showFieldAsBox: true,
                          onSubmit: (String verificationCode) {
                            controller.onSubmitCode(verificationCode);
                          },
                        );
                      },
                    ),
                  ],
                ),
                kHeight20,
                GetBuilder<OtpVerifyController>(
                  builder: (controller) {
                    return AuthElevatedButton(
                      label: 'Verify',
                      onPressed: () {
                        controller.submitOtp(model, controller.code, context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
