import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/common/api/api_endpoints.dart';
import 'package:scotch/util/dio_exception.dart';
import 'package:scotch/util/dio_interceptor.dart';
import 'package:scotch/view/screens/order_screen/model/get_order_model.dart';
import 'package:scotch/view/screens/order_screen/model/order_model.dart';

class OrderService {
  Future<String?> placeOrder(OrdersModel model) async {
    final Dio dios = await ApiInterceptor().getApiUser();

    try {
      final Response response = await dios.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.orders,
        data: model.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel order =
              GetOrderModel.fromJson(response.data['order']);
          log(order.toString());
          return order.id;
        }
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetOrderModel>?> getAllOrders() async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.orders,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetOrderModel> model = (response.data as List)
              .map((e) => GetOrderModel.fromJson(e))
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

  Future<GetOrderModel?> getSingleOrders(String orderId) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel model = GetOrderModel.fromJson(response.data);

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

  Future<String?> cancelOrder(orderId) async {
    try {
      final Dio dios = await ApiInterceptor().getApiUser();
      final Response response = await dios.patch(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final order = response.data['message'];
          log(order.toString());
          return order;
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message.toString());
      DioException().dioError(e);
    }
    return null;
  }
}
