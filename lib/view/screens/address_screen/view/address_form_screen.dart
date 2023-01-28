import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/view/widgets/custom_form.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';

class AddressFormScreen extends StatelessWidget {
  AddressFormScreen(
      {super.key, required this.addressScreenCheck, required this.addressId});
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final EnumAddress addressScreenCheck;
  final String addressId;
  static const routeAddressName = '/address_form_screen';
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    cartController.setAddressScreen(addressScreenCheck, addressId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Addresse",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<CartController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formGlobalKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name', style: textfieldStyle),
                      CustomFormWidget(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        controller: cartController.nameController,
                        validator: (name) {
                          return cartController.fullNameValidation(name);
                        },
                        keyboard: TextInputType.name,
                        preffix: const Icon(Icons.person),
                      ),
                      Text('Phone Number', style: textfieldStyle),
                      CustomFormWidget(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        controller: cartController.phoneController,
                        validator: (phone) {
                          return cartController.mobileValdation(phone);
                        },
                        keyboard: TextInputType.name,
                        preffix: const Icon(Icons.phone),
                      ),
                      Text('PIN', style: textfieldStyle),
                      Row(
                        children: [
                          Flexible(
                            child: CustomFormWidget(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              controller: cartController.pinController,
                              validator: (pin) {
                                return cartController.pincodeValdation(pin);
                              },
                              keyboard: TextInputType.name,
                              preffix: const Icon(Icons.pin),
                            ),
                          ),
                          kWidth15,
                          Flexible(
                            child: CustomFormWidget(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              controller: cartController.stateController,
                              validator: (state) {
                                return cartController.stateValidation(state);
                              },
                              keyboard: TextInputType.name,
                              preffix: const Icon(Icons.public),
                            ),
                          ),
                        ],
                      ),
                      Text('Place', style: textfieldStyle),
                      CustomFormWidget(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        controller: cartController.placeController,
                        validator: (place) {
                          return cartController.placeValidation(place);
                        },
                        keyboard: TextInputType.name,
                        preffix: const Icon(Icons.location_on),
                      ),
                      Text('Address', style: textfieldStyle),
                      CustomFormWidget(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        controller: cartController.addressController,
                        validator: (address) {
                          return cartController.addressValidation(address);
                        },
                        keyboard: TextInputType.name,
                        preffix: const Icon(
                          Icons.contact_mail,
                        ),
                      ),
                      Text('Landmark', style: textfieldStyle),
                      CustomFormWidget(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        controller: cartController.landmarkController,
                        validator: (land) {
                          return cartController.landmarkValidation(land);
                        },
                        keyboard: TextInputType.name,
                        preffix: const Icon(Icons.emoji_flags),
                      ),
                      SizedBox(
                        width: Get.size.width * 0.92,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              cartController.saveAddress(
                                  addressScreenCheck, addressId);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3D1CF9),
                          ),
                          child: const Text(
                            'Save Address',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              color: kWhitecolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
