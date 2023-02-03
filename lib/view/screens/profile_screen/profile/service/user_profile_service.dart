import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/profile_screen/profile/model/user_model.dart';

class UserProfileService {
  Future<UserModel?> getUserDetials(String email) async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dio.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.user + email,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UserModel userDetials = UserModel.fromJson(response.data);
        log(userDetials.fullname);
        return userDetials;
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }
}
