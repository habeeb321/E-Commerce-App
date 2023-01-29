import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/order_screen/model/get_order_model.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/services/order_service.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class CoaController extends GetxController {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  CoaController() {
    getCart();
    startLoading();
    getAllAddress();
  }

  bool isLoadingc = false;
  CartModel? cartList;
  List<String> cartItemsId = [];
  int quantity = 1;
  int totalproductCount = 1;
  int? totalSave;
  CartService service = CartService();

  void getCart() async {
    isLoadingc = true;
    update();
    await service.getCart().then(
      (value) {
        if (value != null) {
          cartList = value;
          update();
          cartItemsId = cartList!.products.map((e) => e.product.id).toList();
          totalSave = (cartList!.totalPrice - cartList!.totalDiscount).toInt();
          totalProductCount();
          update();
          isLoadingc = false;
          update();
        } else {
          isLoadingc = false;
          update();
        }
        return null;
      },
    );
  }

  void addToCart(String productId, String size) async {
    isLoadingc = true;
    update();
    final AddToCartModel model = AddToCartModel(
      size: size.toString(),
      quantity: quantity,
      productId: productId,
    );
    await service.addToCart(model).then((value) {
      if (value != null) {
        getCart();
        if (value == "product added to cart successfully") {
          Get.snackbar(
            'Cart',
            'Product Added To Cart Successfully',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        isLoadingc = false;
        update();
        null;
      }
    });
  }

  void removeCart(productId) {
    service.removeFromCart(productId).then(
      (value) {
        if (value != null) {
          getCart();
          log(totalSave.toString());
          Get.back();
          update();
          Get.snackbar(
            'Cart',
            'Product removed from cart successfully',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
          update();
        } else {
          return;
        }
      },
    );
  }

  void totalProductCount() {
    int count = 0;
    for (var i = 0; i < cartList!.products.length; i++) {
      count = count + cartList!.products[i].qty;
    }
    totalproductCount = count;
    update();
  }

  Future<void> incrementDecrementQty(
      int qty, String productId, int productQuantity, String size) async {
    final AddToCartModel model = AddToCartModel(
      size: size.toString(),
      quantity: quantity,
      productId: productId,
    );
    if (qty == 1 && productQuantity >= 1 || qty == -1 && productQuantity > 1) {
      await CartService().addToCart(model).then(
        (value) async {
          if (value != null) {
            await CartService().getCart().then(
              (value) {
                if (value != null) {
                  cartList = value;
                  update();
                  totalProductCount();
                  cartItemsId =
                      cartList!.products.map((e) => e.product.id).toList();
                  update();
                  totalSave =
                      (cartList!.totalPrice - cartList!.totalDiscount).toInt();
                  update();
                } else {
                  null;
                }
              },
            );
          } else {
            null;
          }
        },
      );
    } else {
      null;
    }
  }

  void gotToCartFromProduct() {
    getCart();
    Get.to(const CartScreen());
  }

  void toProductScreen(index) {
    Get.toNamed(ProductScreen.routeName, arguments: cartItemsId[index]);
  }

  //-----------------------------------------------order controller---------------------------------//
  bool isLoadingo = false;

  void startLoading() {
    isLoadingo = true;
    update();
  }

  List<GetOrderModel> orderList = [];
  GetOrderModel? getSingleOrder;
  GetAddressModel? addressModel;
  List<GetSingelCartProduct> cartModel = [];

  void getAllOrders() async {
    isLoadingo = true;
    update();
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        orderList = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void getSingleOrders(String orderId) async {
    isLoadingo = true;
    update();
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        getSingleOrder = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void cancelOrders(String orderId) async {
    isLoadingo = true;
    update();
    await OrderService().cancelOrder(orderId).then((value) {
      if (value != null) {
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void getSingleAddress(String addressId) async {
    isLoadingo = false;
    update();
    await AddressService().getSingleAddress(addressId).then((value) {
      if (value != null) {
        log("message");

        addressModel = value;
        update();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void getSingleCart(String productId, String cartId) async {
    await CartService().getSingleCart(productId, cartId).then((value) {
      if (value != null) {
        cartModel = value;
        update();
        totalSave = (cartModel[0].price - cartModel[0].discountPrice).round();
        isLoadingo = false;
        update();
      } else {
        isLoadingo = false;
        update();
      }
    });
    return null;
  }

  void toOrderScreen(productId, cartId) {
    getSingleCart(
      productId,
      cartId,
    );
    update();
    Get.to(
      OrderScreen(
        cartId: cartId,
        productId: productId,
        screenCheck: OrderScreenEnum.buyOneProductOrderScreen,
      ),
    );
  }

  //-----------------------------------------------address controller-------------------------------//

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  bool isLoadinga = false;
  bool isLoading2 = false;
  bool isSelected = true;
  bool isOfficeSelected = false;
  int selectIndex = 0;

  List<GetAddressModel> addressList = [];
  String addressType = 'Home';

  Future<String?> getAllAddress() async {
    isLoadinga = true;
    update();
    await AddressService().getAddress().then((value) {
      if (value != null) {
        log(value.toString());
        addressList = value;
        update();
        isLoadinga = false;
        update();
      } else {
        isLoadinga = false;
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

    await AddressService().addAddress(model).then((value) {
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
      updateAddress(id);
      Get.back();
      getAllAddress();
      update();
    }
  }

  void setAddressScreen(
      EnumAddress addressScreenCheck, String? addressId) async {
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

  void updateAddress(String addressId) async {
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
    await AddressService().updateAddress(model, addressId).then((value) {
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

  void deleteAddress(String addressId) async {
    isLoading2 = true;
    update();
    log('delete function entered');
    await AddressService().deleteAddress(addressId).then((value) {
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
      return 'Please enter the place';
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the address';
    } else {
      return null;
    }
  }

  String? landmarkValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the landmark';
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

  void selectDefault(int index) {
    selectIndex = index;
    update();
  }

  //--------------------------------payment controller---------------------------------//

  Razorpay razorpay = Razorpay();

  void openCheckout(price) async {
    var options = {
      'key': 'rzp_test_boWotLKxahxvUM',
      'amount': price * 100,
      'name': 'Scotch',
      'description': 'Mobile Phones',
      'prefill': {'contact': '9895709034', 'email': 'Scotch@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    update();
    try {
      razorpay.open(options);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        handlePaymentSuccess(response);
      });
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse resp) {
        handlePaymentError(resp);
      });
      update();
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Payment', "SUCCESS:${response.paymentId}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kBlackcolor,
        colorText: kWhitecolor);
    update();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment', "ERROR:${response.code} - ${response.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kBlackcolor,
        colorText: kWhitecolor);
    update();
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('Payment', "EXTERNAL_WALLET:${response.walletName}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kBlackcolor,
        colorText: kWhitecolor);
    update();
  }
}
