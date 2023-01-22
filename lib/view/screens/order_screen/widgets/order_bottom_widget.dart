import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/address_screen/view/address_screen.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';
import 'package:scotch/view/screens/payment_screen/view/payment_screen.dart';

class OrderBottomWidget extends StatelessWidget {
  const OrderBottomWidget({
    Key? key,
    required this.homeCtr,
    required this.payableAmount,
  }) : super(key: key);

  final ProductModel homeCtr;
  final int payableAmount;

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    return GetBuilder<AddressController>(builder: (controller) {
      return Material(
        elevation: 10,
        child: Row(
          children: [
            SizedBox(
              height: Get.size.height * 0.06,
              width: Get.size.width / 2,
              child: Center(
                child: Text(
                  "₹${(homeCtr.price - homeCtr.discountPrice).round()}",
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
                        Get.to(const PaymentScreen());
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
                          fontFamily: "Manrope",
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AddressScreen();
                            },
                          ),
                        );
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
                          fontFamily: "Manrope",
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
