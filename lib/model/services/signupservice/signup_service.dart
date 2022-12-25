import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scotch/model/api/api_baseurl.dart';
import 'package:scotch/model/api/api_endpoints.dart';
import 'package:scotch/model/model/signupmodel/signup_model.dart';
import 'package:scotch/model/model/signupmodel/signup_token.dart';
import 'package:scotch/model/util/dio_exception.dart';

class SignupServices {
  Dio dio = Dio();

  Future<SignUpTokenModel?> signupUser(
      SignUpModel value, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.signUp,
        data: jsonEncode(
          value.toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final signupResponse = SignUpTokenModel.fromJson(response.data);
        log(response.data.toString());
        return signupResponse;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
