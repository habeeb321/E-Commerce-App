import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';

class CartAlertWidget extends StatelessWidget {
  const CartAlertWidget({Key? key, required this.index, required this.cart})
      : super(key: key);

  final CartController cart;
  final int index;
  @override
  Widget build(BuildContext context) {
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
                  cart.removeCart(cart.cartList!.products[index].product.id);
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
  }
}
