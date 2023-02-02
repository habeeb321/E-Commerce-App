import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_widget.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    OrdersController ordersController = Get.put(OrdersController());
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'My Cart',
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Manrope",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                kHeight20,
                CartWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder(
          init: ordersController,
          builder: (controller) {
            return GetBuilder(
              init: cartController,
              builder: (controller) {
                return cartController.cartList == null ||
                        cartController.cartList!.products.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          Material(
                            elevation: 10,
                            child: SizedBox(
                                height: Get.size.height * 0.07,
                                width: Get.size.width / 2,
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
                                        color: kRedColor,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: Get.size.height * 0.07,
                            width: Get.size.width / 2,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const OrderScreen(
                                        cartId: "",
                                        productId: "",
                                        screenCheck:
                                            OrderScreenEnum.normalOrderScreen,
                                      );
                                    },
                                  ),
                                );
                                ordersController.isLoading = false;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  elevation: 1,
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
            );
          }),
    );
  }
}
