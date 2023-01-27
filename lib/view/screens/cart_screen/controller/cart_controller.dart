import 'dart:developer';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/cart_screen/model/add_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class CartController extends GetxController with OrdersController {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  CartController() {
    getCart();
    startLoading();
  }

  @override
  bool isLoading = false;
  CartModel? cartList;
  List<String> cartItemsId = [];
  int quantity = 1;
  int totalproductCount = 1;
  @override
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
}
