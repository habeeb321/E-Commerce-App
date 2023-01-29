// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:scotch/core/const.dart';

// class PaymentController extends GetxController {
//   Razorpay razorpay = Razorpay();

//   void openCheckout(price) async {
//     var options = {
//       'key': 'rzp_test_boWotLKxahxvUM',
//       'amount': price * 100,
//       'name': 'Scotch',
//       'description': 'Mobile Phones',
//       'prefill': {'contact': '9895709034', 'email': 'Scotch@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     update();
//     try {
//       razorpay.open(options);
//       razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//           (PaymentSuccessResponse response) {
//         handlePaymentSuccess(response);
//       });
//       razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse resp) {
//         handlePaymentError(resp);
//       });
//       update();
//     } on PaymentFailureResponse catch (e) {
//       log(e.error.toString());
//     }
//   }

//   void handlePaymentSuccess(PaymentSuccessResponse response) {
//     Get.snackbar('Payment', "SUCCESS:${response.paymentId}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: kBlackcolor,
//         colorText: kWhitecolor);
//     update();
//   }

//   void handlePaymentError(PaymentFailureResponse response) {
//     Get.snackbar('Payment', "ERROR:${response.code} - ${response.message}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: kBlackcolor,
//         colorText: kWhitecolor);
//     update();
//   }

//   void handleExternalWallet(ExternalWalletResponse response) {
//      Get.snackbar('Payment', "EXTERNAL_WALLET:${response.walletName}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: kBlackcolor,
//         colorText: kWhitecolor);
//     update();
//   }
// }
