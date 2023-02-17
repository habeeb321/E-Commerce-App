import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';

class ForgotPasswordService {
  static Future<String?> getOtp(String email) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.verifyOtp,
        queryParameters: {"email": email},
      );
      log(response.statusCode.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return response.data["message"];
      }
    } on DioError catch (e) {
      log('catch');
      DioException().dioError(e);
    }
    return null;
  }
}
