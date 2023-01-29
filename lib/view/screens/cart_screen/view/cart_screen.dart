import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_widget.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CoaController coaController = Get.put(CoaController());
    Size size = Get.size;
    return Scaffold(
      backgroundColor: kGreyColor.shade200,
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
      bottomNavigationBar: GetBuilder<CoaController>(
        builder: (controller) {
          return coaController.cartList == null ||
                  coaController.cartList!.products.isEmpty
              ? SizedBox(
                  height: size.height * 0.78,
                  child: const Center(
                    child: Text('Cart is Empty'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                  color: kBlackcolor,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${coaController.totalSave}',
                                style: const TextStyle(
                                  color: kRedColor,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              const OrderScreen(
                                  cartId: "",
                                  productId: "",
                                  screenCheck:
                                      OrderScreenEnum.normalOrderScreen),
                            );
                            coaController.isLoadingo = false;
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                              color: kWhitecolor,
                              fontFamily: 'Montserrat',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
