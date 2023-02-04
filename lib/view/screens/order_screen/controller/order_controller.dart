import 'dart:developer';
import 'package:get/get.dart';
import 'package:scotch/view/screens/profile_screen/address/model/get_address_model.dart';
import 'package:scotch/view/screens/profile_screen/address/service/address_service.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/order_screen/model/get_order_model.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/services/order_service.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';
import 'package:share_plus/share_plus.dart';

class OrdersController extends GetxController {
  OrdersController() {
    startLoading();
    getAllOrders();
  }

  bool isLoading = false;
  List<GetOrderModel>? ordersList = [];
  GetOrderModel? singleModel;
  GetAddressModel? addressModel;
  List<GetSingelCartProduct> cartModel = [];
  int? totalSave;
  String? deliveryDate;
  List<String> productIds = [];

  void startLoading() {
    isLoading = true;
    update();
  }

  void getAllOrders() async {
    isLoading = true;
    update();
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        ordersList = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
    return null;
  }

  void getSingleOrder(String orderId) async {
    isLoading = true;
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        singleModel = value;
        update();
        deliveryDate = formatDate(singleModel!.deliveryDate.toString());
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
  }

  Future<void> cancelOrder(String orderId) async {
    isLoading = true;
    update();

    await OrderService().cancelOrder(orderId).then((value) {
      if (value != null) {
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
  }

  void getSingleAddress(String addressId) async {
    isLoading = false;
    update();
    await AddressService().getSingleAddress(addressId).then((value) {
      if (value != null) {
        log("message");
        addressModel = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
    return null;
  }

  void getSingleCart(String productId, String cartId) async {
    await CartService().getSingleCart(productId, cartId).then((value) {
      if (value != null) {
        cartModel = value;
        update();
        totalSave = (cartModel[0].price - cartModel[0].discountPrice).round();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    });
    return null;
  }

  void toOrderScreen(productId, cartId) {
    getSingleCart(
      productId,
      cartId,
    );
    update();
    Get.to(
      OrderScreen(
        cartId: cartId,
        productId: productId,
        screenCheck: OrderScreenEnum.buyOneProductOrderScreen,
      ),
    );
  }

  void sendOrderDetials() {
    Share.share(
        "ShoeCart Order -Order Id:${singleModel!.id},Total Products:${singleModel!.products.length},Total Price:${singleModel!.totalPrice},Delivery Date:$deliveryDate");
  }

  String? formatDate(String date) {
    final a = date.split(' ');
    return a[0];
  }

  String? formatCancelDate(String? date) {
    if (date != null) {
      final a = date.split('T');
      return a[0];
    } else {
      return null;
    }
  }
}
