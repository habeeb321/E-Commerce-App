import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';

class AddressAlertWidget extends StatelessWidget {
  const AddressAlertWidget({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    return GetBuilder<AddressController>(builder: (controller) {
      return AlertDialog(
        title: const Text(
          'Remove Item',
          style: TextStyle(
            fontFamily: "Manrope",
            letterSpacing: 1,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure want to delete address?',
          style: TextStyle(
            fontFamily: "Manrope",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FittedBox(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addressController.deleteAddress(
                      addressController.addressList[index].id,
                    );
                    Get.back();
                    Get.snackbar(
                      'Address',
                      'Address Removed Successfully',
                      colorText: kWhitecolor,
                      backgroundColor: kBlackcolor,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    addressController.getAllAddress();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
