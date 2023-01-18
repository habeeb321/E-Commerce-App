import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';

class AddToCartDesButton extends StatelessWidget {
  const AddToCartDesButton({
    Key? key,
    required this.homeCtr,
  }) : super(key: key);

  final ProductModel homeCtr;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return GetBuilder<CartController>(builder: (context) {
      return Expanded(
        child: InkWell(
          onTap: () {
            cartController.addToCart(homeCtr.id, homeCtr.size.toString());
            Get.to(const CartScreen());
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(0.8, 0),
                stops: const [
                  0,
                  0.6,
                ],
                tileMode: TileMode.clamp,
                colors: [
                  themeColor,
                  Colors.blue.shade500,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: kWhitecolor,
                  size: 25,
                ),
                Text(
                  'Add To Cart',
                  style: TextStyle(
                    color: kWhitecolor,
                    fontFamily: "Manrope",
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
