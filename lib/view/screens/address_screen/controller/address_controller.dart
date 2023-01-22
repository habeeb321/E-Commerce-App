import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/model/get_address_model.dart';
import 'package:scotch/view/screens/address_screen/model/create_address_model.dart';
import 'package:scotch/view/screens/address_screen/service/address_service.dart';

class AddressController extends GetxController {
  AddressController() {
    getAllAddress();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  bool isLoading = false;
  bool isLoading2 = false;
  bool isSelected = true;
  bool isOfficeSelected = false;

  List<GetAddressModel> addressList = [];
  String addressType = 'Home';

  Future<String?> getAllAddress() async {
    isLoading = true;
    update();
    await AddressService().getAddress().then((value) {
      if (value != null) {
        log(value.toString());
        addressList = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        return null;
      }
    });
    return null;
  }

  void addAddress() async {
    isLoading2 = true;
    update();
    final CreateAddressModel model = CreateAddressModel(
      title: addressType,
      fullName: nameController.text,
      phone: phoneController.text,
      pin: pinController.text,
      state: stateController.text,
      place: placeController.text,
      address: addressController.text,
      landMark: landmarkController.text,
    );

    await AddressService()
        .addAddress(
      model,
    )
        .then((value) {
      if (value != null) {
        log('hai');
        clearAllControllers();
        Get.back();
        Get.snackbar(
          'Address',
          'Address added successfully',
          colorText: kWhitecolor,
          backgroundColor: kBlackcolor,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading2 = false;
        getAllAddress();
        update();
      } else {
        isLoading2 = false;
        update();
      }
    });
    return null;
  }

  void saveAddress(EnumAddress addressScreenCheck, String id) {
    if (addressScreenCheck == EnumAddress.addAddressScreen) {
      addAddress();
      update();
    } else {
      updateAddress(
        id,
      );
      Get.back();
      getAllAddress();
      update();
    }
  }

  void setAddressScreen(
    EnumAddress addressScreenCheck,
    String? addressId,
  ) async {
    if (addressScreenCheck == EnumAddress.addAddressScreen) {
      clearAllControllers();
    } else {
      await AddressService().getSingleAddress(addressId!).then((value) {
        if (value != null) {
          nameController.text = value.fullName;
          phoneController.text = value.phone;
          pinController.text = value.pin;
          stateController.text = value.state;
          placeController.text = value.place;
          addressController.text = value.address;
          landmarkController.text = value.landMark;
          update();
          value.title == "Home" ? isSelected = true : isSelected = false;
          update();
        }
      });
    }
  }

  void updateAddress(
    String addressId,
  ) async {
    isLoading2 = true;
    update();
    final CreateAddressModel model = CreateAddressModel(
      title: addressType,
      fullName: nameController.text,
      phone: phoneController.text,
      pin: pinController.text,
      state: stateController.text,
      place: placeController.text,
      address: addressController.text,
      landMark: landmarkController.text,
    );
    await AddressService()
        .updateAddress(
      model,
      addressId,
    )
        .then((value) {
      if (value != null) {
        clearAllControllers();
        getAllAddress();
        update();
        isLoading2 = false;
        update();
      } else {
        isLoading2 = false;
        update();
      }
    });
    return null;
  }

  void deleteAddress(
    String addressId,
  ) async {
    isLoading2 = true;
    update();
    log('delete function entered');
    await AddressService()
        .deleteAddress(
      addressId,
    )
        .then((value) {
      if (value != null) {
        isLoading2 = false;
        update();
      } else {
        return;
      }
    });
  }

  void buttonSelection() {
    isSelected = !isSelected;
    update();
    isSelected == true ? addressType = 'Home' : addressType = 'Office';
    update();
  }

  String? fullNameValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the username';
    } else if (value.length < 2) {
      return 'Too short username';
    } else {
      return null;
    }
  }

  String? mobileValdation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length < 10) {
      return 'Invalid mobile number,make sure your entered 10 digits';
    } else {
      return null;
    }
  }

  String? pincodeValdation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your PIN number';
    } else if (value.length < 6) {
      return 'Invalid Pin No';
    } else {
      return null;
    }
  }

  String? stateValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? placeValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? landmarkValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  void pop() {
    Get.back();
    update();
  }

  void clearAllControllers() {
    nameController.clear();
    addressType = "Home";
    pinController.clear();
    stateController.clear();
    placeController.clear();
    addressController.clear();
    phoneController.clear();
    landmarkController.clear();
  }

  GetAddressModel findById(String id) {
    return addressList.firstWhere((element) => element.id == id);
  }
}
