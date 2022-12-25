import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:scotch/model/api/api_baseurl.dart';
import 'package:scotch/model/api/api_endpoints.dart';
import 'package:scotch/model/util/dio_exception.dart';

class VerifyOtpService extends GetxController {
  Dio dio = Dio();
  Future<String?> verifyOtp(email, otpCode, context) async {
    try {
      final response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.verifyOtp,
        data: {
          'email': email,
          'otp': otpCode,
        },
      );
      log(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('otp verified');
        return response.data['message'];
      }
    } on DioError catch (e) {
      log(e.message);
      log('verification faliled');
      DioException().dioError(e, context);
    }
    return null;
  }
}
