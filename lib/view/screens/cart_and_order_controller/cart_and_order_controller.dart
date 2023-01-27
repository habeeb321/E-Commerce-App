import 'dart:developer';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/get_address_model.dart';
import 'package:scotch/view/screens/address_screen/service/address_service.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/cart_screen/model/add_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/order_screen/model/get_order_model.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/services/order_service.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class CartAndOrderController extends GetxController {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  CartAndOrderController() {
    getCart();
    startLoading();
  }

  bool isLoading = false;
  CartModel? cartList;
  List<String> cartItemsId = [];
  int quantity = 1;
  int totalproductCount = 1;
  int? totalSave;
  CartService service = CartService();

  void getCart() async {
    isLoading = true;
    update();
    await service.getCart().then(
      (value) {
        if (value != null) {
          cartList = value;
          update();
          cartItemsId = cartList!.products.map((e) => e.product.id).toList();
          totalSave = (cartList!.totalPrice - cartList!.totalDiscount).toInt();
          totalProductCount();
          update();
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
        return null;
      },
    );
  }

  void addToCart(String productId, String size) async {
    isLoading = true;
    update();
    final AddToCartModel model = AddToCartModel(
      size: size.toString(),
      quantity: quantity,
      productId: productId,
    );
    await service.addToCart(model).then((value) {
      if (value != null) {
        getCart();
        if (value == "product added to cart successfully") {
          Get.snackbar(
            'Cart',
            'Product Added To Cart Successfully',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        null;
      }
    });
  }

  void removeCart(productId) {
    service.removeFromCart(productId).then(
      (value) {
        if (value != null) {
          getCart();
          log(totalSave.toString());
          Get.back();
          update();
          Get.snackbar(
            'Cart',
            'Product removed from cart successfully',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
          update();
        } else {
          return;
        }
      },
    );
  }

  void totalProductCount() {
    int count = 0;
    for (var i = 0; i < cartList!.products.length; i++) {
      count = count + cartList!.products[i].qty;
    }
    totalproductCount = count;
    update();
  }

  Future<void> incrementDecrementQty(
      int qty, String productId, int productQuantity, String size) async {
    final AddToCartModel model = AddToCartModel(
      size: size.toString(),
      quantity: quantity,
      productId: productId,
    );
    if (qty == 1 && productQuantity >= 1 || qty == -1 && productQuantity > 1) {
      await CartService().addToCart(model).then(
        (value) async {
          if (value != null) {
            await CartService().getCart().then(
              (value) {
                if (value != null) {
                  cartList = value;
                  update();
                  totalProductCount();
                  cartItemsId =
                      cartList!.products.map((e) => e.product.id).toList();
                  update();
                  totalSave =
                      (cartList!.totalPrice - cartList!.totalDiscount).toInt();
                  update();
                } else {
                  null;
                }
              },
            );
          } else {
            null;
          }
        },
      );
    } else {
      null;
    }
  }

  void gotToCartFromProduct() {
    getCart();
    Get.to(const CartScreen());
  }

  void toProductScreen(index) {
    Get.toNamed(ProductScreen.routeName, arguments: cartItemsId[index]);
  }

  //-----------------------------------------------order controller---------------------------------//

  void startLoading() {
    isLoading = true;
    update();
  }

  List<GetOrderModel> orderList = [];
  GetOrderModel? getSingleOrder;
  GetAddressModel? addressModel;
  List<GetSingelCartProduct> cartModel = [];

  void getAllOrders() async {
    isLoading = true;
    update();
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        orderList = value;
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

  void getSingleOrders(String orderId) async {
    isLoading = true;
    update();
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        getSingleOrder = value;
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

  void cancelOrders(String orderId) async {
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
    return null;
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
}
