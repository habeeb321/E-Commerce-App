import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/model/get_single_cart_model.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  bool isLoading = false;
  String paymentType = 'Online Payment';
  List<Product> products = [];
  Map<String, dynamic> options = {};
  List<String>? productId;
  String? addressId;

  Razorpay razorpay = Razorpay();

  void openCheckout(int payableAmount) {
    options = {
      "key": "rzp_test_1us6kHimFxJzx6",
      "amount": payableAmount * 100,
      "name": "Scotch",
      "description": "Laptops",
      "prefill": {"contact": "9895709034", "email": "scotch@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
      update();
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    log("Pament success");
    Get.snackbar('Payment', "Payment Success${response.paymentId}",
        colorText: kWhitecolor, backgroundColor: Colors.green);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    log("Pament error");
    Get.snackbar('Payment',
        'Payment Cancelled${response.code.toString()} - ${response.message}',
        colorText: kWhitecolor, backgroundColor: kRedColor);
  }

  void handlerExternalWallet() {
    log("External Wallet");
    Get.snackbar('Payment', 'External Wallet',
        colorText: kWhitecolor, backgroundColor: Colors.green);
  }

  void findByProduct(model) {
    Get.toNamed(OrderScreen.routeName, arguments: model);
  }
}
