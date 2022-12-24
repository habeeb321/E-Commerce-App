import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';

class DioException {
  void dioError(Object e, BuildContext context) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        Get.snackbar('Error', 'Invalid username or password',
            backgroundColor: kBlackcolor, colorText: kWhitecolor);
      } else if (e.response?.statusCode == 400) {
        Get.snackbar('Error', 'All fields required',
            backgroundColor: kBlackcolor, colorText: kWhitecolor);
      } else if (e.response?.statusCode == 403) {
        Get.snackbar('Error', 'Forbiden',
            backgroundColor: kBlackcolor, colorText: kWhitecolor);
      } else if (e.response?.statusCode == 500) {
        Get.snackbar('Error', 'Something went wrong',
            backgroundColor: kBlackcolor, colorText: kWhitecolor);
      } else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        Get.snackbar('Error', 'Failed please try again',
            backgroundColor: kBlackcolor, colorText: kWhitecolor);
      }
    }
    if (e is SocketException) {
      Get.snackbar('Error', 'No internet connection',
          backgroundColor: kBlackcolor, colorText: kWhitecolor);
    } else if (e is TimeoutException) {
      Get.snackbar('Error', 'Connection timedout',
          backgroundColor: kBlackcolor, colorText: kWhitecolor);
    }
  }
}
