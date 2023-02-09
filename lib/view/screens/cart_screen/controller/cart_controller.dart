import 'dart:developer';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:scotch/view/screens/cart_screen/model/add_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class CartController extends GetxController {
  CartController() {
    getCart();
  }

  BottomNavController bottomNavController = Get.put(BottomNavController());

  bool isLoading = false;
  int quantity = 1;
  int totalproductCount = 1;
  int? totalSave;
  String size = "5 inch";
  CartModel? model;
  CartService service = CartService();
  List<String> cartList = [];
  List<String> cartItemsId = [];
  List<String> cartitemsPayId = [];

  void getCart() async {
    isLoading = true;
    update();
    await service.getCart().then(
      (value) {
        if (value != null) {
          model = value;
          update();
          cartItemsId = model!.products.map((e) => e.product.id).toList();
          cartitemsPayId = model!.products.map((e) => e.id).toList();
          cartList = model!.products.map((e) => e.product.id).toList();
          totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
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

  void addToCart(String productId) async {
    isLoading = true;
    update();
    final AddToCartModel model = AddToCartModel(
      size: size,
      quantity: quantity,
      productId: productId,
    );
    await service.addToCart(model).then((value) {
      if (value != null) {
        getCart();
      }
      if (value == "product added to cart successfully") {
        Get.snackbar(
          'Cart',
          'Product Added To Cart Successfully',
          colorText: kWhitecolor,
          backgroundColor: kBlackcolor,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        isLoading = false;
        update();
        null;
      }
    });
  }

  void removeCart(productId) {
    log('get in to remove controller');
    service.removeFromCart(productId).then(
      (value) {
        if (value != null) {
          getCart();
          log(totalSave.toString());
          pop();
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
    dynamic count = 0;
    for (var i = 0; i < model!.products.length; i++) {
      count = count + model!.products[i].qty;
    }
    totalproductCount = count;
    update();
  }

  Future<void> incrementOrDecrementQuantity(int qty, String productId,
      String productSize, int productquantity) async {
    final AddToCartModel addToCartModel = AddToCartModel(
      productId: productId,
      quantity: qty,
      size: productSize.toString(),
    );
    if (qty == 1 && productquantity >= 1 || qty == -1 && productquantity > 1) {
      await CartService().addToCart(addToCartModel).then((value) async {
        if (value != null) {
          await CartService().getCart().then((value) {
            if (value != null) {
              model = value;
              update();
              totalProductCount();
              update();
              cartItemsId = model!.products.map((e) => e.product.id).toList();
              update();
              totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
              update();
            } else {
              null;
            }
          });
        } else {
          null;
        }
      });
    } else {
      null;
    }
  }

  void gotToCartFromProduct() {
    Get.to(const BottomNavBar());
    bottomNavController.currentIndex = 1;
    update();
  }

  void toProductScreen(index) {
    Get.toNamed(ProductScreen.routeName, arguments: cartItemsId[index]);
  }

  void pop() {
    Get.back();
    update();
  }
}
