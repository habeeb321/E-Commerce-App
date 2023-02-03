import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/profile_screen/address/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_arguments.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key, this.args});

  final OrderArgumnetsModel? args;

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    OrdersController ordersController = Get.put(OrdersController());
    CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
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
                                            kHeight20,
                                            Row(
                                              children: [
                                                kWidth10,
                                                Image(
                                                  height: 100,
                                                  width: 100,
                                                  image: NetworkImage(
                                                    '${ApiBaseUrl().baseUrl}/products/${ordersController.cartModel[0].product.image[4]}',
                                                  ),
                                                ),
                                                kWidth10,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ordersController
                                                          .cartModel[0]
                                                          .product
                                                          .name,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'Manrope',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating:
                                                          double.parse(
                                                              ordersController
                                                                  .cartModel[0]
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
                                                          "${ordersController.cartModel[0].product.offer}%Off",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Manrope",
                                                          ),
                                                        ),
                                                        kWidth10,
                                                        Text(
                                                          "₹${ordersController.cartModel[0].product.price}",
                                                          style:
                                                              const TextStyle(
                                                            color: kGreyColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontFamily:
                                                                "Manrope",
                                                          ),
                                                        ),
                                                        kWidth10,
                                                        Text(
                                                          "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
                                                          style:
                                                              const TextStyle(
                                                            color: kRedColor,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                            kHeight20,
                                            Column(
                                              children: const [
                                                Text(
                                                  'Order Placed Successfully',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 25),
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
                                      );
                                    },
                                    itemCount: 1),
                                kHeight20,
                              ],
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
