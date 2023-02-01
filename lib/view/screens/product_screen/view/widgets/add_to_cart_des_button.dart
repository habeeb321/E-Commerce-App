import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';

class AddToCartDesButton extends StatelessWidget {
  const AddToCartDesButton({
    Key? key,
    required this.id,
    required this.productId,
    required this.size,
  }) : super(key: key);

  final String id;
  final String productId;
  final List<String> size;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    BottomNavController bottomNavController = Get.put(BottomNavController());
    return GetBuilder(
        init: bottomNavController,
        builder: (controller) {
          return GetBuilder(
            init: cartController,
            builder: (controller) {
              return cartController.cartItemsId.contains(id)
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          cartController.gotToCartFromProduct();
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
                                'Go To Cart',
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
                    )
                  : Expanded(
                      child: InkWell(
                        onTap: () {
                          cartController.addToCart(id, size.toString());
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
            },
          );
        });
  }
}
