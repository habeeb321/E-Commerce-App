import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/order_screen/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/widgets/order_bottom_widget.dart';
import 'package:scotch/view/screens/order_screen/widgets/row_order_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const routeName = "/order_screen";

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    HomeController homeController = Get.put(HomeController());
    CartController cartController = Get.put(CartController());
    final args = ModalRoute.of(context)?.settings.arguments as String;
    final homeCtr = homeController.findById(args);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AddressController>(
            builder: (controller) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderAddressWidget(
                        index: index,
                        value: addressController,
                      );
                    },
                    itemCount: addressController.addressList.length,
                  ),
                  kHeight10,
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        color: kWhitecolor,
                        child: Column(
                          children: [
                            kHeight10,
                            Row(
                              children: [
                                kWidth10,
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                    'http://172.16.5.206:5005/products/${homeCtr.image[0]}',
                                    // order.cartModel[index].product.image[0],
                                  ),
                                ),
                                kWidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeCtr.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RatingBar.builder(
                                      initialRating:
                                          double.parse(homeCtr.rating),
                                      itemSize: 15,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (startRating) {
                                        log(startRating.toString());
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${homeCtr.offer}%Off",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: "Manrope",
                                          ),
                                        ),
                                        kWidth10,
                                        Text(
                                          "₹${homeCtr.price}",
                                          style: const TextStyle(
                                            color: kGreyColor,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontFamily: "Manrope",
                                          ),
                                        ),
                                        kWidth10,
                                        Text(
                                          "₹${(homeCtr.price - homeCtr.discountPrice).round()}",
                                          style: const TextStyle(
                                            color: kRedColor,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Manrope",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            kHeight10,
                            Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  height: 25,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "${cartController.cartList!.products[index].qty}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            kHeight10
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                  ),
                  kHeight10,
                  Container(
                    color: kWhitecolor,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Price Details',
                              style: TextStyle(
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        kHeight10,
                        RowOrderWidget(
                          text: 'Price',
                          text2:
                              "₹${(homeCtr.price - homeCtr.discountPrice).round()}",
                          color: kRedColor,
                        ),
                        kHeight10,
                        const RowOrderWidget(
                          text: 'Delivery Charges',
                          text2: "Free Delivery",
                          color: Colors.green,
                        ),
                        const Text(
                          '-------------------------------------------------------------------------------------',
                        ),
                        RowOrderWidget(
                          text: 'Total Amout',
                          text2:
                              "₹${(homeCtr.price - homeCtr.discountPrice).round()}",
                        ),
                      ],
                    ),
                  ),
                  kHeight10,
                  Row(
                    children: const [
                      kWidth10,
                      Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/images/shield_5f9216.png'),
                      ),
                      Text(
                        'Safe and Secure Payments.Easy returns.100% \nAuthentic products',
                        style: TextStyle(
                          color: kGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: OrderBottomWidget(
        homeCtr: homeCtr,
        payableAmount: int.parse(
          (homeCtr.price - homeCtr.discountPrice).round().toString(),
        ),
      ),
    );
  }
}
