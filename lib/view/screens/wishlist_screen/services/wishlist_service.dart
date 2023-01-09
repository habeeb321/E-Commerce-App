import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/wishlist_screen/model/wishlist_model.dart';

class WishlistService {
  Future<int?> addToWishlist(context, productId) async {
    Dio dio = await ApiInterceptor().getApiUser(context);
    try {
      final Response response =
          await dio.post(ApiBaseUrl().baseUrl + ApiEndPoints.wishlist, data: {
        'product': productId,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 204) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

  Future<WishListModel?> getWishlist(context) async {
    Dio dio = await ApiInterceptor().getApiUser(context);
    try {
      final Response response = await dio.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.wishlist,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final WishListModel model = WishListModel.fromJson(response.data);
        return model;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
