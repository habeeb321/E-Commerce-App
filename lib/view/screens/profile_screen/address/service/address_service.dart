import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/profile_screen/address/model/get_address_model.dart';
import 'package:scotch/view/screens/profile_screen/address/model/create_address_model.dart';

class AddressService {
  Future<String?> addAddress(CreateAddressModel model) async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.address,
        data: model.toJson(),
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetAddressModel>?> getAddress() async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dio.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.address,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetAddressModel> model = (response.data as List)
              .map((e) => GetAddressModel.fromJson(e))
              .toList();

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<GetAddressModel?> getSingleAddress(String addressId) async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dio.get(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetAddressModel model = GetAddressModel.fromJson(response.data);

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }

  Future<String?> updateAddress(
      CreateAddressModel model, String addressId) async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dio.patch(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
        data: model.toJson(),
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> deleteAddress(String addressId) async {
    Dio dio = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dio.delete(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(
        e,
      );
    }
    return null;
  }
}
