import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/view/address_screen.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';
import 'package:scotch/view/screens/order_placed_screen/view/order_placed_screen.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';

class OrderBottomWidget extends StatelessWidget {
  const OrderBottomWidget({
    Key? key,
    required this.screenCheck,
  }) : super(key: key);

  final OrderScreenEnum screenCheck;

  @override
  Widget build(BuildContext context) {
    CoaController coaController = Get.put(CoaController());
    return GetBuilder<CoaController>(builder: (controller) {
      return Material(
        elevation: 10,
        child: Row(
          children: [
            SizedBox(
              height: Get.size.height * 0.06,
              width: Get.size.width / 2,
              child: Center(
                child:
                    // coaController.isLoadingo == true
                    //     ? const CircularProgressIndicator()
                    //     :
                    Text(
                  screenCheck == OrderScreenEnum.normalOrderScreen
                      ? "₹${(coaController.cartList!.totalPrice - coaController.cartList!.totalDiscount).round()}"
                      : "₹${(coaController.cartModel[0].product.price - coaController.cartModel[0].product.discountPrice).round()}",
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
            coaController.addressList.isNotEmpty
                ? SizedBox(
                    height: Get.size.height * 0.06,
                    width: Get.size.width / 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        await coaController.openCheckout(
                          screenCheck == OrderScreenEnum.normalOrderScreen
                              ? int.parse((coaController.cartList!.totalPrice -
                                      coaController.cartList!.totalDiscount)
                                  .round()
                                  .toString())
                              : int.parse((coaController.cartModel[0].price -
                                      coaController.cartModel[0].discountPrice)
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
        ),
      );
    });
  }
}
