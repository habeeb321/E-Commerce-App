import 'package:flutter/material.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';

class CartAlertWidget extends StatelessWidget {
  const CartAlertWidget({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  final CartController cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Remove Item',
        style: TextStyle(
          fontFamily: "Manrope",
          letterSpacing: 1,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure want to remove \n item from cart?',
        style: TextStyle(
          fontFamily: "Manrope",
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
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: "Manrope",
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
                    fontFamily: "Manrope",
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
