import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/cart_screen/model/add_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';

class CartService {
  Future<String?> addToCart(AddToCartModel model) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
        data: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final cartResponse = response.data['message'];
          return cartResponse;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<CartModel?> getCart() async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final CartModel model = CartModel.fromJson(response.data);

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetSingelCartProduct>?> getSingleCart(
      String productId, String cartId) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.cart}/$cartId/product/$productId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetSingelCartProduct> model = (response.data as List)
              .map((e) => GetSingelCartProduct.fromJson(e))
              .toList();

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> removeFromCart(String id) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.patch(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
        data: {
          "product": id,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final cartRemove = response.data['message'];
        return cartRemove;
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
