import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/view/auth/login_screen/model/loginmodel/login_model.dart';
import 'package:scotch/view/auth/login_screen/model/loginmodel/login_token.dart';
import 'package:scotch/util/dio_exception.dart';

class LoginService {
  Dio dio = Dio();
  Future<LoginTokenModel?> loginUser(
      LoginModel value, BuildContext context) async {
    try {
      Response response = await dio.post(
          ApiBaseUrl().baseUrl + ApiEndPoints.logIn,
          data: jsonEncode(value.toJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginModel = LoginTokenModel.fromJson(response.data);
        log(response.data.toString());
        return loginModel;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, );
    }
    return null;
  }
}
