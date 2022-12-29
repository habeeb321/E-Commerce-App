import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';

class VerifyOtpService {
  Dio dio = Dio();
  Future<String?> verifyOtp(email, otpCode, context) async {
    try {
      final Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.verifyOtp,
        data: {
          'email': email,
          'otp': otpCode,
        },
      );
      log(response.toString(), name: 'otp responce');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusCode.toString());
        log('otp verified');
        return response.data['message'];
      }
    } on DioError catch (e) {
      log(e.message, name: 'status code');
      log('verification failed');
      DioException().dioError(e, context);
    }
    return null;
  }
}
