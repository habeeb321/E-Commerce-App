import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/add_edit.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/show_alert.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
    CartController cartController = Get.put(CartController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getAllAddress();
    });
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
                cartController.isButtonVisbile = true;
              },
              icon: const Icon(
                CupertinoIcons.back,
              ),
            ),
            title: const Text('My Addresses'),
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              cartController.isVisible(notification);
              return true;
            },
            child: SingleChildScrollView(
                child: cartController.addressList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 10,
                        ),
                        child: Text(
                          'NO SAVED ADDRESS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kGreyColor,
                          ),
                        ),
                      )
                    : cartController.isLoding2 == true
                        ? const Center(
                            heightFactor: 20,
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  cartController.addressSelect(index);
                                  log(index.toString());
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    color: index == cartController.selectIndex
                                        ? const Color.fromARGB(
                                            255, 228, 240, 249)
                                        : kWhitecolor,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                cartController
                                                    .addressList[index].fullName
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              kWidth10,
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                    cartController
                                                        .addressList[index]
                                                        .title,
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          83, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              index ==
                                                      cartController.selectIndex
                                                  ? const Text(
                                                      "Defualt",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                          kHeight5,
                                          Text(
                                            '''${cartController.addressList[index].address},${cartController.addressList[index].place},
${cartController.addressList[index].state} - ${cartController.addressList[index].pin}
Land Mark - ${cartController.addressList[index].landMark}
''',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .phone_android_outlined,
                                                    color: Colors.black54,
                                                  ),
                                                  Text(
                                                    cartController
                                                        .addressList[index]
                                                        .phone,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      foregroundColor:
                                                          kRedColor,
                                                    ),
                                                    onPressed: () {
                                                      showCupertinoDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return ShowAlertWidget(
                                                            yesPress: () {
                                                              cartController.deleteAdderess(
                                                                  cartController
                                                                      .addressList[
                                                                          index]
                                                                      .id);
                                                            },
                                                            title:
                                                                'Remove Address',
                                                            contant:
                                                                'Are you sure want to delete this address?',
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .delete_outline_outlined,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Remove'),
                                                  ),
                                                  kWidth10,
                                                  OutlinedButton.icon(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      foregroundColor:
                                                          Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      addAndEditBottomSheet(
                                                        context,
                                                        formGlobalKey,
                                                        EnumAddress
                                                            .editAddressScreen,
                                                        cartController
                                                            .addressList[index]
                                                            .id,
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: cartController.addressList.length,
                            separatorBuilder: (context, index) {
                              return kHeight10;
                            },
                          )),
          ),
          bottomNavigationBar: Visibility(
            visible: cartController.isButtonVisbile,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .08,
              child: FloatingActionButton.extended(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: themeColor,
                onPressed: () {
                  addAndEditBottomSheet(
                    context,
                    formGlobalKey,
                    EnumAddress.addAddressScreen,
                    '',
                  );
                },
                label: const Text(
                  'Add new address',
                ),
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
