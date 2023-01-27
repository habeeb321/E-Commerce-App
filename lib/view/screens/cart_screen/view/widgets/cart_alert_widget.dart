import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/view/screens/cart_and_order_controller/cart_and_order_controller.dart';

class CartAlertWidget extends StatelessWidget {
  const CartAlertWidget({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    CartAndOrderController cartAndOrderController =
        Get.put(CartAndOrderController());
    return GetBuilder<CartAndOrderController>(builder: (controller) {
      return AlertDialog(
        title: const Text(
          'Remove Item',
          style: TextStyle(
            fontFamily: "Montserrat",
            letterSpacing: 1,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure want to remove \n item from cart?',
          style: TextStyle(
            fontFamily: "Montserrat",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FittedBox(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cartAndOrderController.removeCart(cartAndOrderController
                        .cartList!.products[index].product.id);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
