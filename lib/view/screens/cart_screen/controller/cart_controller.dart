import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/model/create_address_model.dart';
import 'package:scotch/view/screens/address_screen/model/enum_address.dart';
import 'package:scotch/view/screens/address_screen/model/get_address_model.dart';
import 'package:scotch/view/screens/address_screen/service/address_service.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/cart_screen/model/add_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';
import 'package:scotch/view/screens/cart_screen/services/cart_service.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class CartController extends GetxController {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  CartController() {
    getCart();
    startLoading();
    getAllAddress();
  }

  String size = "5 inch";
  int quantity = 1;
  bool isLoading = false;
  CartModel? model;
  int? totalSave;
  int totalProductCount = 1;
  List<String> cartList = [];

  void getCart() async {
    isLoading = true;
    update();
    await CartService().getCart().then(
      (value) {
        if (value != null) {
          model = value;
          update();
          cartList = model!.products.map((e) => e.product.id).toList();
          totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
          totalProductsCount();
          update();
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
        return null;
      },
    );
  }

  void addToCart(
    String productId,
  ) async {
    isLoading = true;
    update();
    final AddToCartModel model = AddToCartModel(
      size: size,
      quantity: quantity,
      productId: productId,
    );
    await CartService().addToCart(model).then((value) {
      if (value != null) {
        getCart();
      }
      if (value == "product added to cart successfully") {
        Get.snackbar('Cart', 'product added to cart successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor);
        update();
      } else {
        null;
      }
    });
  }

  void pop() {
    Get.back();
    update();
  }

  void removeFromCart(String productId) {
    CartService().removeFromCart(productId).then((value) {
      if (value != null) {
        getCart();
        Get.snackbar('Cart', 'Product removed from cart Successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor);
        pop();
        update();
      } else {
        return;
      }
    });
  }

  void totalProductsCount() {
    int count = 0;
    for (var i = 0; i < model!.products.length; i++) {
      count = count + model!.products[i].qty;
    }
    totalProductCount = count;
    update();
  }

  Future<void> incrementOrDecrementQuantity(
    int qty,
    String productId,
    String productSize,
    int productquantity,
  ) async {
    final AddToCartModel addToCartModel = AddToCartModel(
      productId: productId,
      quantity: qty,
      size: productSize.toString(),
    );
    if (qty == 1 && productquantity >= 1 || qty == -1 && productquantity > 1) {
      await CartService()
          .addToCart(
        addToCartModel,
      )
          .then((value) async {
        if (value != null) {
          await CartService().getCart().then((value) {
            if (value != null) {
              model = value;
              update();
              totalProductsCount();
              update();
              cartList = model!.products.map((e) => e.product.id).toList();
              update();
              totalSave = (model!.totalPrice - model!.totalDiscount).toInt();
              update();
            } else {
              null;
            }
          });
        } else {
          null;
        }
      });
    } else {
      null;
    }
  }

  void cartToProductView(index) {
    Get.toNamed(ProductScreen.routeName,
        arguments: model!.products[index].product.id);
  }

  //----------------------------------order controller--------------------------------------------//

  bool loading = false;
  List<GetSingelCartProduct> product = [];
  List<String> productIds = [];

  void startLoading() {
    loading = true;
    update();
  }

  void toOderScreen(productId, cartId) {
    getSingleCartProduct(
      productId,
      cartId,
    );
    update();
    Get.to(
      OrderScreen(
          cartId: cartId,
          productId: productId,
          screenCheck: OrderScreenEnum.buyOneProductOrderScreen),
    );

    update();
  }

  Future<void> checkScreen(
    OrderScreenEnum screenCheck,
    String? productId,
    String? cartId,
  ) async {
    if (screenCheck == OrderScreenEnum.normalOrderScreen) {
      return;
    } else if (screenCheck == OrderScreenEnum.buyOneProductOrderScreen) {
      await getSingleCartProduct(
        productId!,
        cartId!,
      ).then((value) {
        loading = false;
        update();
        return;
      });
    }
  }

  Future<void> getSingleCartProduct(String productId, String cartId) async {
    await CartService().getSingleCart(productId, cartId).then((value) {
      if (value != null) {
        product = value;
        update();
        loading = false;
        update();
      } else {
        loading = false;
        update();
      }
    });
  }

  //------------------------------------------address controller----------------------------------//

  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController landMark = TextEditingController();

  bool isLoding = false;
  bool isLoding2 = false;
  String addressType = 'HOME';
  bool isSelected = true;
  List<GetAddressModel> addressList = [];
  bool isButtonVisbile = true;

  int selectIndex = 0;

  void addressSelect(int index) {
    selectIndex = index;
    update();
  }

  void isVisible(notification) {
    if (notification.direction == ScrollDirection.reverse) {
      if (isButtonVisbile) {
        isButtonVisbile = false;
        update();
      }
    } else if (notification.direction == ScrollDirection.forward) {
      if (!isButtonVisbile) {
        isButtonVisbile = true;
        update();
      }
    }
  }

  void addAddress() async {
    isLoding = true;
    update();
    final CreateAddressModel model = CreateAddressModel(
      fullName: fullName.text,
      phone: phone.text,
      pin: pincode.text,
      state: state.text,
      place: place.text,
      address: address.text,
      landMark: landMark.text,
      title: addressType,
    );
    await AddressService()
        .addAddress(
      model,
    )
        .then((value) {
      if (value != null) {
        log("helo");
        isLoding = true;
        update();
        Get.snackbar('Cart', 'Address added successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor);
        isLoding = false;
        getAllAddress();
        clearController();
        update();
      } else {
        isLoding = false;
        update();
      }
    });
    return null;
  }

  void updateAddress(String addressId) async {
    isLoding = true;
    update();
    final CreateAddressModel model = CreateAddressModel(
      title: addressType,
      fullName: fullName.text,
      phone: phone.text,
      pin: pincode.text,
      state: state.text,
      place: place.text,
      address: address.text,
      landMark: landMark.text,
    );
    await AddressService().updateAddress(model, addressId).then((value) {
      if (value != null) {
        clearController();
        Get.back();
        getAllAddress();
        isLoding = false;
        update();
      } else {
        isLoding = false;
        update();
      }
    });
  }

  getAllAddress() async {
    isLoding2 = true;
    update();
    await AddressService().getAddress().then((value) {
      if (value != null) {
        log(value.toString());
        addressList = value;
        update();
        isLoding2 = false;

        update();
      } else {
        isLoding2 = false;
        update();
        return null;
      }
    });
    return null;
  }

  void deleteAdderess(String addressId) async {
    isLoding2 = true;
    update();
    await AddressService().deleteAddress(addressId).then((value) {
      isLoding2 = false;
      Get.back();
      Get.snackbar('Cart', 'Address removed successfully',
          snackPosition: SnackPosition.BOTTOM,
          colorText: kWhitecolor,
          backgroundColor: kBlackcolor);
      getAllAddress();
      update();
    });
  }

  void clearController() {
    fullName.clear();
    phone.clear();
    pincode.clear();
    state.clear();
    place.clear();
    address.clear();
    landMark.clear();
    addressType = 'HOME';
  }

  void saveAddress(EnumAddress addressScreenCheck, String addressId) {
    if (addressScreenCheck == EnumAddress.addAddressScreen) {
      addAddress();
    } else {
      updateAddress(addressId);
    }
    update();
  }

  void typeButtonSelect() {
    isSelected = !isSelected;
    update();
    isSelected == true ? addressType = 'HOME' : addressType = 'OFFICE';
    update();
  }

  void setAddressScreen(
    EnumAddress addressScreenCheck,
    String? addressId,
  ) async {
    if (addressScreenCheck == EnumAddress.addAddressScreen) {
      clearController();
    } else {
      await AddressService().getSingleAddress(addressId!).then(
        (value) {
          if (value != null) {
            fullName.text = value.fullName;
            phone.text = value.phone;
            pincode.text = value.pin;
            state.text = value.state;
            place.text = value.place;
            address.text = value.address;
            landMark.text = value.landMark;
            value.title == 'Home' ? isSelected = true : isSelected = false;
            update();
          }
        },
      );
    }
  }

  //...................validations

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your full name";
    } else {
      return null;
    }
  }

  String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }

    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return 'Enter Valid Phone Number';
    }

    if (value.length > 10 || value.length < 10) {
      return "Mobile length must be 10 characters";
    } else {
      return null;
    }
  }

  String? pincodeValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your pincode";
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{6}$)').hasMatch(value)) {
      return 'Enter Valid pincode';
    }
    if (value.length > 6 || value.length < 6) {
      return "Pincode length must be 6 characters";
    } else {
      return null;
    }
  }

  String? stateValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your state";
    } else {
      return null;
    }
  }

  String? placeValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your place";
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your Address";
    } else {
      return null;
    }
  }

  String? landMarkValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter your land mark";
    } else {
      return null;
    }
  }
}
