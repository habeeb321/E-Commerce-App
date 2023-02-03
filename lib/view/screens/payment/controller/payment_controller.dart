import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/order_screen/model/order_model.dart';
import 'package:scotch/view/screens/order_screen/services/order_service.dart';

class PaymentController extends GetxController {
  Razorpay razorpay = Razorpay();
  List<Product> products = [];
  String? addressId;
  Map<String, dynamic> options = {};

  void setAddressId(String addressid) {
    addressId = addressid;
    update();
  }

  void setTotalAmount(amount, List<String> productIds, address) {
    final total = "${amount * 100}";
    final amountPayable = total.toString();
    openCheckout(amountPayable);
    products = productIds.map((e) => Product(id: e)).toList();
    addressId = address;
    update();
  }

  openCheckout(amountPayable) async {
    options = {
      'key': 'rzp_test_K1qY31Ub3PKsMs',
      'amount': amountPayable,
      'name': 'Scotch',
      'description': 'Laptop',
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
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        handleExternalWallet(response);
      });
      update();
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Payment', "SUCCESS:${response.paymentId}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: kWhitecolor);
    orderProducts(addressId!, 'ONLINE_PAYMENT');
    update();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment', "ERROR:${response.code} - ${response.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRedColor,
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

  bool loading = false;
  Future<void> orderProducts(String addressId, paymentType) async {
    loading = true;
    update();
    final OrdersModel model = OrdersModel(
      addressId: addressId,
      paymentType: paymentType,
      products: products,
    );

    await OrderService().placeOrder(model).then((value) {
      if (value != null) {
        loading = false;
        update();
      } else {
        loading = false;
        update();
      }
    });
  }
}
