import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/address_form_screen.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/popup_address_widget.dart';
import 'package:scotch/view/screens/profile_screen/controller/profile_controller.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    AddressController addressController = Get.put(AddressController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addressController.getAllAddress();
    });
    return GetBuilder(
        init: profileController,
        builder: (controller) {
          return GetBuilder(
            init: addressController,
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "My Addresses",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          addressController.addressList.isEmpty
                              ? const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add Some Address',
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: kWhitecolor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 20.0,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            kHeight10,
                                            Row(
                                              children: [
                                                Text(
                                                  addressController
                                                      .addressList[index]
                                                      .fullName
                                                      .toUpperCase(),
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
                                                                EnumAddress
                                                                    .editAddressScreen,
                                                            addressId:
                                                                addressController
                                                                    .addressList[
                                                                        index]
                                                                    .id,
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit),
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
                                              addressController
                                                  .addressList[index].address,
                                              style: const TextStyle(
                                                fontFamily: "Montserrat",
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "PIN : ${addressController.addressList[index].pin}, ",
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  addressController
                                                      .addressList[index].state,
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              addressController
                                                  .addressList[index].landMark,
                                              style: const TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            kHeight10,
                                            Text(
                                              addressController
                                                  .addressList[index].phone,
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
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return kHeight20;
                                  },
                                  itemCount:
                                      addressController.addressList.length,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: themeColor,
                  onPressed: () {
                    Get.to(
                      AddressFormScreen(
                        addressScreenCheck: EnumAddress.addAddressScreen,
                        addressId: "",
                      ),
                    );
                  },
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: kWhitecolor,
                  ),
                ),
              );
            },
          );
        });
  }
}
