import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/view/address_screen.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/address_widget.dart';
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
    CartController cartController = Get.put(CartController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.getSingleCartProduct(widget.productId, widget.cartId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order summary'),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          return cartController.loading == true
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      kHeight10,
                      cartController.addressList.isEmpty
                          ? Container()
                          : AddressWidget(
                              name: cartController
                                  .addressList[cartController.selectIndex]
                                  .fullName,
                              title: cartController
                                  .addressList[cartController.selectIndex]
                                  .title,
                              cartController:
                                  '''${cartController.addressList[cartController.selectIndex]},
${cartController.addressList[cartController.selectIndex].state} - ${cartController.addressList[cartController.selectIndex].pin}
Land Mark - ${cartController.addressList[cartController.selectIndex].landMark}
''',
                              number: cartController
                                  .addressList[cartController.selectIndex]
                                  .phone,
                              onPreesed: () {
                                Get.to(const AddressScreen());
                              },
                              address: '',
                            ),
                      kHeight10,
                      ListView.separated(
                        itemCount: widget.screenCheck ==
                                OrderScreenEnum.normalOrderScreen
                            ? cartController.model!.products.length
                            : 1,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: kWhitecolor,
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    // provider.cartList.length - 1
                                    image: NetworkImage(
                                      widget.screenCheck ==
                                              OrderScreenEnum.normalOrderScreen
                                          ? '${ApiBaseUrl().baseUrl}/products/${cartController.model!.products[index].product.image[0]}'
                                          : '${ApiBaseUrl().baseUrl}/products/${cartController.product[0].product.image[0]}',
                                    ),
                                  )),
                                ),
                                kWidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Text(
                                        widget.screenCheck ==
                                                OrderScreenEnum
                                                    .normalOrderScreen
                                            ? cartController.model!
                                                .products[index].product.name
                                            : cartController
                                                .product[0].product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      allowHalfRating: true,
                                      onRatingUpdate: (cartController) {},
                                      itemBuilder: (context, hello) {
                                        return const Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 24, 110, 29),
                                        );
                                      },
                                      itemSize: 16,
                                      initialRating: double.parse(
                                        widget.screenCheck ==
                                                OrderScreenEnum
                                                    .normalOrderScreen
                                            ? cartController.model!
                                                .products[index].product.rating
                                            : cartController
                                                .product[0].product.rating,
                                      ),
                                    ),
                                    kHeight5,
                                    Row(
                                      children: [
                                        Text(
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? "${cartController.model!.products[index].product.offer}%off"
                                              : "${cartController.product[0].product.offer}%off",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        kWidth10,
                                        Text(
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? "₹${cartController.model!.products[index].product.price}"
                                              : "${cartController.product[0].product.price}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: kGreyColor,
                                          ),
                                        ),
                                        kWidth10,
                                        Text(
                                          widget.screenCheck ==
                                                  OrderScreenEnum
                                                      .normalOrderScreen
                                              ? "₹${(cartController.model!.products[index].product.price - cartController.model!.products[index].product.discountPrice).round()}"
                                              : "₹${(cartController.product[0].product.price - cartController.product[0].product.discountPrice).round()}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight10,
                                    widget.screenCheck ==
                                            OrderScreenEnum.normalOrderScreen
                                        ? Text(
                                            '${cartController.model!.products[index].qty} Item',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kGreyColor,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return kHeight20;
                        },
                      ),
                      kHeight10,
                      Container(
                        color: kWhitecolor,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            kHeight20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderScreenEnum.normalOrderScreen
                                      ? "₹${cartController.model!.totalPrice}"
                                      : "₹${cartController.product[0].product.price}",
                                ),
                              ],
                            ),
                            kHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Discount Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderScreenEnum.normalOrderScreen
                                      ? "₹${cartController.model!.totalDiscount.toStringAsFixed(0)}"
                                      : "₹${cartController.product[0].product.discountPrice.toStringAsFixed(0)}",
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: .6,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderScreenEnum.normalOrderScreen
                                      ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
                                      : "₹${(cartController.product[0].product.price - cartController.product[0].product.discountPrice).round()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: .6,
                            ),
                            Text(
                              widget.screenCheck ==
                                      OrderScreenEnum.normalOrderScreen
                                  ? 'You will save ₹${cartController.model!.totalDiscount.toStringAsFixed(0)} on this cartController'
                                  : 'You will save ₹${cartController.product[0].product.discountPrice.toStringAsFixed(0)} on this cartController',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 30,
                            color: Colors.grey.shade600,
                          ),
                          kWidth10,
                          const Text(
                            '''Safe and secure payment. Easy returns.
           100% Authentic products.''',
                          ),
                        ],
                      ),
                      kHeight20,
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return cartController.loading == true
              ? const CircularProgressIndicator()
              : Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kWhitecolor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: cartController.loading == true
                        ? const CircularProgressIndicator()
                        : Text(
                            widget.screenCheck ==
                                    OrderScreenEnum.normalOrderScreen
                                ? "₹${cartController.model!.totalPrice}"
                                : "₹${cartController.product[0].price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kGreyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                    subtitle: Text(
                      widget.screenCheck == OrderScreenEnum.normalOrderScreen
                          ? "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}"
                          : "₹${(cartController.product[0].product.price - cartController.product[0].product.discountPrice).round()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kRedColor,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 200,
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          return cartController.addressList.isEmpty
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: themeColor,
                                  ),
                                  onPressed: () {
                                    Get.to(const AddressScreen());
                                  },
                                  child: const Text(
                                    'Add cartController',
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                  ),
                                  onPressed: () {
                                    paymentController.openCheckout(widget
                                                .screenCheck ==
                                            OrderScreenEnum.normalOrderScreen
                                        ? int.parse(
                                            (cartController.model!.totalPrice -
                                                    cartController
                                                        .model!.totalDiscount)
                                                .round()
                                                .toString())
                                        : int.parse(
                                            (cartController.product[0].price -
                                                    cartController.product[0]
                                                        .discountPrice)
                                                .round()
                                                .toString()));
                                  },
                                  child: Text(
                                    widget.screenCheck ==
                                            OrderScreenEnum.normalOrderScreen
                                        ? 'CONTINUE (${cartController.totalProductCount})'
                                        : 'CONTINUE',
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
