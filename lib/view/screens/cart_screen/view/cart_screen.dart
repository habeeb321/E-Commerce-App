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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              CartWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return cartController.cartList == null ||
                  cartController.cartList!.products.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
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
