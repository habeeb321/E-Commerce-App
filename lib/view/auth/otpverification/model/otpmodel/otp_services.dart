import 'package:scotch/view/auth/otpverification/model/otpmodel/otp_enum.dart';
import 'package:scotch/view/auth/signupscreen/model/signupmodel/signup_model.dart';

class OtpModel {
  final SignUpModel model;
  final OtpEnum screenCheck;

  OtpModel({
    required this.model,
    required this.screenCheck,
  });
}
