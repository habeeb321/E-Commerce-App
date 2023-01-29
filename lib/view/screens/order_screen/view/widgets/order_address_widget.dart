import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/address_form_screen.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/popup_address_widget.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({
    Key? key,
    required this.index,
    required value,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    CoaController coaController = Get.put(CoaController());
    return GetBuilder<CoaController>(builder: (controller) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
              color: kWhitecolor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Deliver to:',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          AddressFormScreen(
                            addressScreenCheck: EnumAddress.addAddressScreen,
                            addressId: coaController.addressList[index].id,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kWhitecolor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Change',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      coaController.addressList[index].fullName.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                              AddressFormScreen(
                                addressScreenCheck:
                                    EnumAddress.editAddressScreen,
                                addressId: coaController.addressList[index].id,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AddressAlertWidget(index: index);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: kRedColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  coaController.addressList[index].address,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "PIN :${coaController.addressList[index].pin}, ",
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      coaController.addressList[index].state,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  coaController.addressList[index].place,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                kHeight10,
                Text(
                  coaController.addressList[index].phone,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                kHeight10,
              ],
            ),
          ),
        ],
      );
    });
  }
}
