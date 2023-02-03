import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/profile_screen/address/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/row_order_widget.dart';
import 'package:scotch/view/screens/payment/controller/payment_controller.dart';

class AllOrderPlacedScreen extends StatefulWidget {
  const AllOrderPlacedScreen({super.key});

  @override
  State<AllOrderPlacedScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<AllOrderPlacedScreen> {
  CartController cartController = Get.put(CartController());
  AddressController addressController = Get.put(AddressController());
  OrdersController ordersController = Get.put(OrdersController());
  PaymentController paymentController = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
        child: GetBuilder(
          init: addressController,
          builder: (controller) {
            return GetBuilder(
              init: ordersController,
              builder: (controller) {
                return GetBuilder(
                  init: cartController,
                  builder: (controller) {
                    return ordersController.isLoading == true
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  OrderAddressWidget(
                                    index: addressController.selectIndex,
                                    value: addressController,
                                  ),
                                  kHeight10,
                                  ListView.builder(
                                      physics: const ScrollPhysics(),
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
                                                        '${ApiBaseUrl().baseUrl}/products/${cartController.cartList!.products[index].product.image[4]}'),
                                                  ),
                                                  kWidth10,
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        cartController
                                                            .cartList!
                                                            .products[index]
                                                            .product
                                                            .name,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'Manrope',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      RatingBar.builder(
                                                        initialRating:
                                                            double.parse(
                                                                cartController
                                                                    .cartList!
                                                                    .products[
                                                                        index]
                                                                    .product
                                                                    .rating),
                                                        itemSize: 15,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        ignoreGestures: true,
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (startRating) {
                                                          log(startRating
                                                              .toString());
                                                        },
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${cartController.cartList!.products[index].product.offer}%Off",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Manrope",
                                                            ),
                                                          ),
                                                          kWidth10,
                                                          Text(
                                                            "₹${cartController.cartList!.products[index].product.price}",
                                                            style:
                                                                const TextStyle(
                                                              color: kGreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontFamily:
                                                                  "Manrope",
                                                            ),
                                                          ),
                                                          kWidth10,
                                                          Text(
                                                            "₹${(cartController.cartList!.products[index].product.price - cartController.cartList!.products[index].product.discountPrice).round()}",
                                                            style:
                                                                const TextStyle(
                                                              color: kRedColor,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Manrope",
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      "${cartController.cartList!.products[index].qty}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              kHeight10
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: cartController
                                          .cartList!.products.length),
                                  kHeight10,
                                  divider,
                                  RowOrderWidget(
                                    text: 'Total Amout',
                                    text2:
                                        "₹${(cartController.cartList!.totalPrice - cartController.cartList!.totalDiscount).round()}",
                                  ),
                                  divider,
                                  Column(
                                    children: const [
                                      Text(
                                        'Order Placed Successfully',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 25),
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                        size: 60,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
