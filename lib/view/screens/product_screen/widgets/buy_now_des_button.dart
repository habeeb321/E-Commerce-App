import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';

class BuyNowDesButton extends StatelessWidget {
  const BuyNowDesButton({
    Key? key,
    required this.id,
    required this.size,
  }) : super(key: key);

  final String id;
  final List<String> size;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return GetBuilder<CartController>(builder: (controller) {
      return Expanded(
        child: InkWell(
          onTap: () {
            cartController.addToCart(id, size.toString());
            Get.toNamed(OrderScreen.routeName, arguments: id);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(0.8, 0),
                stops: const [0.3, 0.9],
                tileMode: TileMode.clamp,
                colors: [
                  Colors.blue.shade500,
                  themeColor,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: kWhitecolor,
                  size: 25,
                ),
                Text(
                  'Buy Now',
                  style: TextStyle(
                    color: kWhitecolor,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
