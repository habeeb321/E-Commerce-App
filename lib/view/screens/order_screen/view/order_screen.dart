import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_bottom_widget.dart';
import 'package:scotch/view/screens/payment/controller/payment_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    super.key,
    required this.cartId,
    required this.productId,
    required this.screenCheck,
  });

  final String cartId;
  final String productId;
  final OrderScreenEnum screenCheck;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  PaymentController paymentController = PaymentController();

  @override
  void initState() {
    final razorpay = paymentController.razorpay;
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        paymentController.handlerPaymentSuccess);
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, paymentController.handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        paymentController.handlerExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    paymentController.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    CartController cartController = Get.put(CartController());
    cartController.getSingleCart(widget.productId, widget.cartId);
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GetBuilder<AddressController>(builder: (controller) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderAddressWidget(
                        index: addressController.selectIndex,
                        value: addressController,
                      );
                    },
                    itemCount: addressController.addressList.length,
                  );
                }),
                kHeight10,
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Column(
                      children: [
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
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? '${ApiBaseUrl().baseUrl}/products/${cartController.cartList!.products[index].product.image[4]}'
                                              : '${ApiBaseUrl().baseUrl}/products/${cartController.cartModel[0].product.image[4]}',
                                        ),
                                      ),
                                      kWidth10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.screenCheck ==
                                                    OrderScreenEnum
                                                        .normalOrderScreen
                                                ? cartController
                                                    .cartList!
                                                    .products[index]
                                                    .product
                                                    .name
                                                : cartController
                                                    .cartModel[0].product.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBar.builder(
                                            initialRating: double.parse(
                                              widget.screenCheck ==
                                                      OrderScreenEnum
                                                          .normalOrderScreen
                                                  ? cartController
                                                      .cartList!
                                                      .products[index]
                                                      .product
                                                      .rating
                                                  : cartController.cartModel[0]
                                                      .product.rating,
                                            ),
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
                                                widget.screenCheck ==
                                                        OrderScreenEnum
                                                            .normalOrderScreen
                                                    ? "${cartController.cartList!.products[index].product.offer}%Off"
                                                    : "${cartController.cartModel[0].product.offer}%Off",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: "Manrope",
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                widget.screenCheck ==
                                                        OrderScreenEnum
                                                            .normalOrderScreen
                                                    ? "₹${cartController.cartList!.products[index].product.price}"
                                                    : "₹${cartController.cartModel[0].product.price}",
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
                                                widget.screenCheck ==
                                                        OrderScreenEnum
                                                            .normalOrderScreen
                                                    ? "₹${(cartController.cartList!.products[index].product.price - cartController.cartList!.products[index].product.discountPrice).round()}"
                                                    : "₹${(cartController.cartModel[0].product.price - cartController.cartModel[0].product.discountPrice).round()}",
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
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          "${cartController.cartList!.products[index].qty}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget.screenCheck ==
                                  OrderScreenEnum.normalOrderScreen
                              ? cartController.cartList!.products.length
                              : 1,
                        ),
                        // kHeight10,
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: const [
                        //           Text(
                        //             'Price Details',
                        //             style: TextStyle(
                        //               fontFamily: "Montserrat",
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18,
                        //               letterSpacing: 1,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       kHeight10,
                        //       RowOrderWidget(
                        //         text: 'Price',
                        //         text2: widget.screenCheck ==
                        //                 OrderScreenEnum.normalOrderScreen
                        //             ? "₹${(cartController.cartList!.totalPrice - cartController.cartList!.totalDiscount).round()}"
                        //             : "₹${(cartController.cartModel[0].product.price - cartController.cartModel[0].product.discountPrice).round()}",
                        //         color: kRedColor,
                        //       ),
                        //       kHeight10,
                        //       const RowOrderWidget(
                        //         text: 'Delivery Charges',
                        //         text2: "Free Delivery",
                        //         color: Colors.green,
                        //       ),
                        //       const Text(
                        //         '--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --',
                        //       ),
                        //       RowOrderWidget(
                        //         text: 'Total Amout',
                        //         text2: widget.screenCheck ==
                        //                 OrderScreenEnum.normalOrderScreen
                        //             ? "₹${(cartController.cartList!.totalPrice - cartController.cartList!.totalDiscount).round()}"
                        //             : "₹${(cartController.cartModel[0].product.price - cartController.cartModel[0].product.discountPrice).round()}",
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // kHeight10,
                        Row(
                          children: [
                            kWidth10,
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.verified_user_rounded,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              'Safe and Secure Payments.Easy returns.100% \nAuthentic products',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: OrderBottomWidget(
        screenCheck: widget.screenCheck,
      ),
    );
  }
}
