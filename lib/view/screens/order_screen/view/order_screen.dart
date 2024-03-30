import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/profile_screen/address/controller/address_controller.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/row_order_widget.dart';
import 'package:scotch/view/screens/payment/controller/payment_controller.dart';
import 'package:scotch/view/screens/profile_screen/address/view/address_screen.dart';

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
  State<OrderScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderScreen> {
  CartController cartController = Get.put(CartController());
  AddressController addressController = Get.put(AddressController());
  OrdersController ordersController = Get.put(OrdersController());
  PaymentController paymentController = PaymentController();

  @override
  void initState() {
    final razorpay = paymentController.razorpay;
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, paymentController.handlePaymentSuccess);
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, paymentController.handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, paymentController.handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    paymentController.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getSingleCart(widget.productId, widget.cartId);

      paymentController.setAddressId(
          addressController.addressList[addressController.selectIndex].id);
      ordersController.productIds.insert(
          0,
          cartController
              .cartitemsPayId[cartController.cartitemsPayId.length - 1]);
    });
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
        centerTitle: true,
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
                                  addressController.addressList.isEmpty
                                      ? const SizedBox(
                                          height: 150,
                                          child: Center(
                                            child: Text('Add Address'),
                                          ),
                                        )
                                      : OrderAddressWidget(
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
                                                    widget.screenCheck ==
                                                            OrderScreenEnum
                                                                .normalOrderScreen
                                                        ? '${ApiBaseUrl().baseUrl}/products/${cartController.model!.products[index].product.image[4]}'
                                                        : '${ApiBaseUrl().baseUrl}/products/${ordersController.cartModel[0].product.image[4]}',
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
                                                              .model!
                                                              .products[index]
                                                              .product
                                                              .name
                                                          : ordersController
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
                                                        widget.screenCheck ==
                                                                OrderScreenEnum
                                                                    .normalOrderScreen
                                                            ? cartController
                                                                .model!
                                                                .products[index]
                                                                .product
                                                                .rating
                                                            : ordersController
                                                                .cartModel[0]
                                                                .product
                                                                .rating,
                                                      ),
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
                                                          widget.screenCheck ==
                                                                  OrderScreenEnum
                                                                      .normalOrderScreen
                                                              ? "${cartController.model!.products[index].product.offer}%Off"
                                                              : "${ordersController.cartModel[0].product.offer}%Off",
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
                                                          widget.screenCheck ==
                                                                  OrderScreenEnum
                                                                      .normalOrderScreen
                                                              ? "₹${cartController.model!.products[index].product.price}"
                                                              : "₹${ordersController.cartModel[0].product.price}",
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
                                                          widget.screenCheck ==
                                                                  OrderScreenEnum
                                                                      .normalOrderScreen
                                                              ? "₹${(cartController.model!.products[index].product.price - cartController.model!.products[index].product.discountPrice).round()}"
                                                              : "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
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
                                                    "${cartController.model!.products[index].qty}",
                                                    textAlign: TextAlign.center,
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
                                    itemCount: widget.screenCheck ==
                                            OrderScreenEnum.normalOrderScreen
                                        ? cartController.model!.products.length
                                        : 1,
                                  ),
                                  kHeight10,
                                  Container(
                                    color: kWhitecolor,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        kHeight10,
                                        const Row(
                                          children: [
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
                                          text2: widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
                                              : "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
                                          color: kRedColor,
                                        ),
                                        kHeight10,
                                        const RowOrderWidget(
                                          text: 'Delivery Charges',
                                          text2: "Free Delivery",
                                          color: Colors.green,
                                        ),
                                        const Text(
                                          '--------------------------------------------------------------------------------',
                                        ),
                                        RowOrderWidget(
                                          text: 'Total Amout',
                                          text2: widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
                                              : "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
                                        ),
                                        kHeight10,
                                      ],
                                    ),
                                  ),
                                  kHeight20,
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      kWidth15,
                                      Icon(Icons.verified_user,
                                          color: Colors.grey),
                                      Text(
                                        'Safe and Secure Payments.Easy returns.100% \nAuthentic products',
                                        style: TextStyle(
                                          color: kGreyColor,
                                        ),
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
      bottomNavigationBar: GetBuilder(
        init: paymentController,
        builder: (controller) {
          return GetBuilder(
            init: addressController,
            builder: (controller) {
              return GetBuilder(
                init: ordersController,
                builder: (controller) {
                  return GetBuilder(
                    init: cartController,
                    builder: (controller) {
                      return Material(
                        elevation: 10,
                        child: Row(
                          children: [
                            SizedBox(
                              height: Get.size.height * 0.06,
                              width: Get.size.width / 2,
                              child: Center(
                                child: ordersController.isLoading == true
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        widget.screenCheck ==
                                                OrderScreenEnum
                                                    .normalOrderScreen
                                            ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
                                            : "₹${(ordersController.cartModel[0].product.price - ordersController.cartModel[0].product.discountPrice).round()}",
                                        style: const TextStyle(
                                          color: kBlackcolor,
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                            addressController.addressList.isNotEmpty
                                ? SizedBox(
                                    height: Get.size.height * 0.06,
                                    width: Get.size.width / 2,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        paymentController.setTotalAmount(
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? int.parse((cartController
                                                          .model!.totalPrice -
                                                      cartController
                                                          .model!.totalDiscount)
                                                  .round()
                                                  .toString())
                                              : int.parse((ordersController
                                                          .cartModel[0].price -
                                                      ordersController
                                                          .cartModel[0]
                                                          .discountPrice)
                                                  .round()
                                                  .toString()),
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? cartController.cartitemsPayId
                                              : ordersController.productIds,
                                          addressController
                                              .addressList[
                                                  addressController.selectIndex]
                                              .id,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 0,
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                          color: kWhitecolor,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: Get.size.height * 0.06,
                                    width: Get.size.width / 2,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(const AddressScreen());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 0,
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                      child: const Text(
                                        'Add Adrress',
                                        style: TextStyle(
                                          color: kWhitecolor,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
