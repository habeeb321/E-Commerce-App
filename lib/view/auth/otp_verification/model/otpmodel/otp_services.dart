import 'package:scotch/view/auth/otp_verification/model/otpmodel/otp_enum.dart';
import 'package:scotch/view/auth/signup_screen/model/signupmodel/signup_model.dart';

class OtpModel {
  final SignUpModel model;
  final OtpEnum screenCheck;

  OtpModel({
    required this.model,
    required this.screenCheck,
  });
}
