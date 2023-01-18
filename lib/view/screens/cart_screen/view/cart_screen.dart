import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    Size size = Get.size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                CartWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return cartController.cartList == null ||
                  cartController.cartList!.products.isEmpty
              ? SizedBox(
                  height: size.height * 0.78,
                  child: const Center(
                    child: Text('Cart is Empty'),
                  ),
                )
              : Row(
                  children: [
                    SizedBox(
                        height: size.height * 0.07,
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Price',
                              style: TextStyle(
                                color: kBlackcolor,
                                fontSize: 15,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${cartController.totalSave}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: size.height * 0.07,
                      width: size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            shape: const RoundedRectangleBorder()),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            color: kWhitecolor,
                            fontFamily: 'Manrope',
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
