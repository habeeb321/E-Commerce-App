import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/custom_textfield.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';

Future<dynamic> addAndEditBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formGlobalKey,
    EnumAddress addressScreenCheck,
    String addressId) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Get.find<CartController>().setAddressScreen(addressScreenCheck, addressId);
  });
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: GetBuilder<CartController>(
            builder: (controller) {
              return Form(
                key: formGlobalKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Get.find<CartController>().clearController();
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        )
                      ],
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return Get.find<CartController>().nameValidation(value);
                      },
                      labelText: 'Full Name',
                      controller: Get.find<CartController>().fullName,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return Get.find<CartController>()
                            .phoneNumberValidation(value);
                      },
                      labelText: 'Phone number',
                      controller: Get.find<CartController>().phone,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone_android_outlined,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormFieldCustom(
                            validator: (value) {
                              return Get.find<CartController>()
                                  .pincodeValidation(value);
                            },
                            labelText: 'Pincode',
                            controller: Get.find<CartController>().pincode,
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.pin_drop_outlined,
                          ),
                        ),
                        Flexible(
                          child: TextFormFieldCustom(
                            validator: (value) {
                              return Get.find<CartController>()
                                  .stateValidation(value);
                            },
                            labelText: 'state',
                            controller: Get.find<CartController>().state,
                            keyboardType: TextInputType.name,
                            prefixIcon: Icons.map_outlined,
                          ),
                        ),
                      ],
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return Get.find<CartController>()
                            .addressValidation(value);
                      },
                      labelText: 'Address',
                      controller: Get.find<CartController>().address,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.add_location_alt_outlined,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return Get.find<CartController>()
                            .placeValidation(value);
                      },
                      labelText: 'Place',
                      controller: Get.find<CartController>().place,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.location_city_outlined,
                    ),
                    TextFormFieldCustom(
                      validator: (value) {
                        return Get.find<CartController>()
                            .landMarkValidation(value);
                      },
                      labelText: 'Land Mark',
                      controller: Get.find<CartController>().landMark,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.emoji_flags_outlined,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      Get.find<CartController>().isSelected ==
                                              true
                                          ? themeColor
                                          : Colors.transparent,
                                  foregroundColor:
                                      Get.find<CartController>().isSelected ==
                                              true
                                          ? kWhitecolor
                                          : Colors.grey,
                                ),
                                onPressed: () {
                                  Get.find<CartController>().typeButtonSelect();
                                },
                                icon: const Icon(
                                  Icons.home,
                                ),
                                label: const Text(
                                  'Home',
                                ),
                              ),
                              kWidth10,
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      Get.find<CartController>().isSelected ==
                                              false
                                          ? themeColor
                                          : Colors.transparent,
                                  foregroundColor:
                                      Get.find<CartController>().isSelected ==
                                              false
                                          ? kWhitecolor
                                          : Colors.grey,
                                ),
                                onPressed: () {
                                  Get.find<CartController>().typeButtonSelect();
                                },
                                icon: const Icon(
                                  Icons.apartment_outlined,
                                ),
                                label: const Text(
                                  'Office',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .90,
                      child: OutlinedButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();
                            Get.find<CartController>().saveAddress(
                              addressScreenCheck,
                              addressId,
                            );
                          }
                        },
                        child: Get.find<CartController>().isLoding == true
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Save Address',
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
