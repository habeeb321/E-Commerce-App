// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scotch/core/const.dart';
// import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
// import 'package:scotch/view/screens/profile_screen/address/controller/address_controller.dart';
// import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
// import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
// import 'package:scotch/view/screens/payment/controller/payment_controller.dart';
// import 'package:scotch/view/screens/profile_screen/address/view/address_screen.dart';

// class OrderBottomWidget extends StatelessWidget {
//   const OrderBottomWidget({
//     Key? key,
//     required this.screenCheck,
//   }) : super(key: key);

//   final OrderScreenEnum screenCheck;

//   @override
//   Widget build(BuildContext context) {
//     PaymentController paymentController = Get.put(PaymentController());
//     AddressController addressController = Get.put(AddressController());
//     CartController cartController = Get.put(CartController());
//     OrdersController ordersController = Get.put(OrdersController());
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       //ordersController.getSingleCart(widget.productId, widget.cartId);

//       paymentController.setAddressId(
//           addressController.addressList[addressController.selectIndex].id);
//       ordersController.productIds.insert(
//           0,
//           cartController
//               .cartitemsPayId[cartController.cartitemsPayId.length - 1]);
//     });
//     return GetBuilder(
//       init: paymentController,
//       builder: (controller) {
//         return GetBuilder(
//           init: addressController,
//           builder: (controller) {
//             return GetBuilder(
//               init: ordersController,
//               builder: (controller) {
//                 return GetBuilder(
//                   init: cartController,
//                   builder: (controller) {
//                     return Material(
//                       elevation: 10,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             height: Get.size.height * 0.06,
//                             width: Get.size.width / 2,
//                             child: Center(
//                               child: ordersController.isLoading == true
//                                   ? const CircularProgressIndicator()
//                                   : Text(
//                                       screenCheck ==
//                                               OrderScreenEnum.normalOrderScreen
//                                           ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
//                                           : "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
//                                       style: const TextStyle(
//                                         color: kBlackcolor,
//                                         fontFamily: "Manrope",
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: 1,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                           addressController.addressList.isNotEmpty
//                               ? SizedBox(
//                                   height: Get.size.height * 0.06,
//                                   width: Get.size.width / 2,
//                                   child: ElevatedButton(
//                                     onPressed: () async {
//                                       paymentController.setTotalAmount(
//                                         screenCheck ==
//                                                 OrderScreenEnum
//                                                     .normalOrderScreen
//                                             ? int.parse((cartController
//                                                         .model!.totalPrice -
//                                                     cartController
//                                                         .model!.totalDiscount)
//                                                 .round()
//                                                 .toString())
//                                             : int.parse((ordersController
//                                                         .cartModel[0].price -
//                                                     ordersController
//                                                         .cartModel[0]
//                                                         .discountPrice)
//                                                 .round()
//                                                 .toString()),
//                                         screenCheck ==
//                                                 OrderScreenEnum
//                                                     .normalOrderScreen
//                                             ? cartController.cartitemsPayId
//                                             : ordersController.productIds,
//                                         addressController
//                                             .addressList[
//                                                 addressController.selectIndex]
//                                             .id,
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blue,
//                                       elevation: 0,
//                                       shape: const RoundedRectangleBorder(),
//                                     ),
//                                     child: const Text(
//                                       'Continue',
//                                       style: TextStyle(
//                                         color: kWhitecolor,
//                                         fontFamily: "Montserrat",
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: 1,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : SizedBox(
//                                   height: Get.size.height * 0.06,
//                                   width: Get.size.width / 2,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Get.to(const AddressScreen());
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blue,
//                                       elevation: 0,
//                                       shape: const RoundedRectangleBorder(),
//                                     ),
//                                     child: const Text(
//                                       'Add Adrress',
//                                       style: TextStyle(
//                                         color: kWhitecolor,
//                                         fontFamily: "Montserrat",
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: 1,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
