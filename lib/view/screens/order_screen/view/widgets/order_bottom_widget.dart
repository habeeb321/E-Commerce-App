import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/address_screen/view/address_screen.dart';
import 'package:scotch/view/screens/cart_and_order_controller/cart_and_order_controller.dart';
import 'package:scotch/view/screens/order_placed_screen/view/order_placed_screen.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/payment/controller/payment_controller.dart';

class OrderBottomWidget extends StatelessWidget {
  const OrderBottomWidget({
    Key? key,
    required this.screenCheck,
  }) : super(key: key);

  final OrderScreenEnum screenCheck;

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    PaymentController paymentController = Get.put(PaymentController());
    CartAndOrderController cartAndOrderController =
        Get.put(CartAndOrderController());
    return Material(
      elevation: 10,
      child: GetBuilder<CartAndOrderController>(builder: (context) {
        return Row(
          children: [
            SizedBox(
              height: Get.size.height * 0.06,
              width: Get.size.width / 2,
              child: Center(
                child: cartAndOrderController.isLoading == true
                    ? const CircularProgressIndicator()
                    : Text(
                        screenCheck == OrderScreenEnum.normalOrderScreen
                            ? "₹${(cartAndOrderController.cartList!.totalPrice - cartAndOrderController.cartList!.totalDiscount).round()}"
                            : "₹${(cartAndOrderController.cartModel[0].product.price - cartAndOrderController.cartModel[0].product.discountPrice).round()}",
                        style: const TextStyle(
                          color: kBlackcolor,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            addressController.addressList.isNotEmpty
                ? SizedBox(
                    height: Get.size.height * 0.06,
                    width: Get.size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        paymentController.openCheckout(
                          screenCheck == OrderScreenEnum.normalOrderScreen
                              ? int.parse(
                                  (cartAndOrderController.cartList!.totalPrice -
                                          cartAndOrderController
                                              .cartList!.totalDiscount)
                                      .round()
                                      .toString())
                              : int.parse(
                                  (cartAndOrderController.cartModel[0].price -
                                          cartAndOrderController
                                              .cartModel[0].discountPrice)
                                      .round()
                                      .toString()),
                        );
                        Get.to(const OrderPlacedScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: kWhitecolor,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: Get.size.height * 0.06,
                    width: Get.size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const AddressScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text(
                        'Add Adrress',
                        style: TextStyle(
                          color: kWhitecolor,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
