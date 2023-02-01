import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/address_form_screen.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/popup_address_widget.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  final int index;
  final AddressController value;

  @override
  Widget build(BuildContext context) {
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
                          addressId: value.addressList[index].id,
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
                    value.addressList[index].fullName.toUpperCase(),
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
                              addressScreenCheck: EnumAddress.editAddressScreen,
                              addressId: value.addressList[index].id,
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
                value.addressList[index].address,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "PIN :${value.addressList[index].pin}, ",
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value.addressList[index].state,
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                value.addressList[index].place,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              kHeight10,
              Text(
                value.addressList[index].phone,
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
  }
}
