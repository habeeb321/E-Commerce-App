import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_and_order_controller/cart_and_order_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_arguments.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key, this.args});

  final OrderArgumnetsModel? args;

  @override
  Widget build(BuildContext context) {
    CartAndOrderController cartAndOrderController =
        Get.put(CartAndOrderController());
    AddressController addressController = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SafeArea(
        child: cartAndOrderController.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<AddressController>(
                      builder: (controller) {
                        return OrderAddressWidget(
                          index: addressController.selectIndex,
                          value: addressController,
                        );
                      },
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
                                    GetBuilder<CartAndOrderController>(
                                      builder: (controller) {
                                        return Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(
                                            '${ApiBaseUrl().baseUrl}/products/${cartAndOrderController.cartModel[0].product.image[0]}',
                                          ),
                                        );
                                      },
                                    ),
                                    kWidth10,
                                    GetBuilder<CartAndOrderController>(
                                        builder: (controller) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartAndOrderController.cartList!
                                                .products[index].product.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBar.builder(
                                            initialRating: double.parse(
                                                cartAndOrderController
                                                    .cartList!
                                                    .products[index]
                                                    .product
                                                    .rating),
                                            itemSize: 15,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            ignoreGestures: true,
                                            itemBuilder: (context, _) =>
                                                const Icon(
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
                                                "${cartAndOrderController.cartList!.products[index].product.offer}%Off",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: "Manrope",
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                "₹${cartAndOrderController.cartList!.products[index].product.price}",
                                                style: const TextStyle(
                                                  color: kGreyColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontFamily: "Manrope",
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                "₹${(cartAndOrderController.cartList!.products[index].product.price - cartAndOrderController.cartList!.products[index].product.discountPrice).round()}",
                                                style: const TextStyle(
                                                  color: kRedColor,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Manrope",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                kHeight10,
                                const Text(
                                  'Order Placed Successfully',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 1),
                    kHeight10,
                  ],
                ),
              ),
      ),
    );
  }
}
