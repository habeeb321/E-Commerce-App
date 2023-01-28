import 'dart:developer';
import 'package:get/get.dart';
import 'package:scotch/view/screens/address_screen/model/get_address_model.dart';
import 'package:scotch/view/screens/address_screen/service/address_service.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/order_screen/model/get_order_model.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/services/order_service.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';

mixin OrdersController on GetxController {
  // OrdersController() {
  //   startLoading();
  // }
  bool isLoadingo = false;
  void startLoading() {
    isLoadingo = true;
    update();
  }

  List<GetOrderModel> orderList = [];
  GetOrderModel? getSingleOrder;
  GetAddressModel? addressModel;
  List<GetSingelCartProduct> cartModel = [];
  int? totalSave;

  void getAllOrders() async {
    isLoadingo = true;
    update();
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        orderList = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void getSingleOrders(String orderId) async {
    isLoadingo = true;
    update();
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        getSingleOrder = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void cancelOrders(String orderId) async {
    isLoadingo = true;
    update();
    await OrderService().cancelOrder(orderId).then((value) {
      if (value != null) {
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void getSingleAddress(String addressId) async {
    isLoadingo = false;
    update();
    await AddressService().getSingleAddress(addressId).then((value) {
      if (value != null) {
        log("message");

        addressModel = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
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
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
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
}
