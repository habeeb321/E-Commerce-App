import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/address_form_screen.dart';
import 'package:scotch/view/screens/address_screen/widgets/popup_address_widget.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    return GetBuilder<AddressController>(
      init: addressController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Addresses",
              style: TextStyle(
                fontFamily: "Manrope",
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddressFormScreen(
                      addressScreenCheck: EnumAddress.addAddressScreen,
                      addressId: "",
                    );
                  },
                ),
              );
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: kWhitecolor,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Container(
                        color: kWhitecolor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kHeight10,
                              Row(
                                children: [
                                  Text(
                                    addressController
                                        .addressList[index].fullName
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  kWidth10,
                                  Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Text(
                                      addressController.addressList[index].title
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                        color: kWhitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return AddressFormScreen(
                                                  addressScreenCheck:
                                                      EnumAddress
                                                          .editAddressScreen,
                                                  addressId: addressController
                                                      .addressList[index].id,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddressAlertWidget(
                                                  index: index);
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                addressController.addressList[index].address,
                                style: const TextStyle(
                                  fontFamily: "Manrope",
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "PIN : ${addressController.addressList[index].pin}, ",
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    addressController.addressList[index].state,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                addressController.addressList[index].landMark,
                                style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              kHeight10,
                              Text(
                                addressController.addressList[index].phone,
                                style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              kHeight10,
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return kHeight10;
                    },
                    itemCount: addressController.addressList.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}