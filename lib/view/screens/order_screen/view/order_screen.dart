import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_bottom_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/row_order_widget.dart';

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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AddressController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OrderAddressWidget(
                          index: index,
                        );
                      },
                      itemCount: addressController.addressList.length,
                    ),
                    kHeight10,
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: kWhitecolor,
                              borderRadius: BorderRadius.circular(15)),
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
                                      '${ApiBaseUrl().baseUrl}products/${homeCtr.image[4]}',
                                    ),
                                  ),
                                  kWidth10,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        homeCtr.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Montserrat',
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
                                              fontFamily: "Montserrat",
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
                                              fontFamily: "Montserrat",
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
                                              fontFamily: "Montserrat",
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
                              kHeight10,
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          'Price Details',
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
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
                                      '--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --',
                                    ),
                                    RowOrderWidget(
                                      text: 'Total Amout',
                                      text2:
                                          "₹${(homeCtr.price - homeCtr.discountPrice).round()}",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 1,
                    ),
                    kHeight10,
                    Row(
                      children: [
                        kWidth10,
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.verified_user_rounded,
                                color: Colors.grey.shade700)),
                        Text(
                          'Safe and Secure Payments.Easy returns.100% \nAuthentic products',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
