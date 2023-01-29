import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';

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
    CoaController coaController = Get.put(CoaController());
    return GetBuilder<CoaController>(
      builder: (controller) {
        return coaController.cartItemsId.contains(id)
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    coaController.gotToCartFromProduct();
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
                    coaController.addToCart(id, size.toString());
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
