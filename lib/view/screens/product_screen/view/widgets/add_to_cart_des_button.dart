import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_controller/cart_and_order_controller.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';

class AddToCartDesButton extends StatelessWidget {
  const AddToCartDesButton({
    Key? key,
    required this.homeCtr,
  }) : super(key: key);

  final ProductModel homeCtr;

  @override
  Widget build(BuildContext context) {
    CartAndOrderController cartAndOrderController =
        Get.put(CartAndOrderController());
    return GetBuilder<CartAndOrderController>(
      builder: (context) {
        return cartAndOrderController.cartItemsId.contains(homeCtr.id)
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    cartAndOrderController.gotToCartFromProduct();
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
                    cartAndOrderController.addToCart(
                        homeCtr.id, homeCtr.size.toString());
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
  }
}
