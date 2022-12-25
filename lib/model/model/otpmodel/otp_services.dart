import 'package:scotch/model/model/otpmodel/otp_enum.dart';
import 'package:scotch/model/model/signupmodel/signup_model.dart';

class OtpModel {
  final SignUpModel model;
  final OtpEnum screenCheck;

  OtpModel({
    required this.model,
    required this.screenCheck,
  });
}
