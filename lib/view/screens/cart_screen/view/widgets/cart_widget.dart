import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_alert_widget.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_shimmer.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/count_widget.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    CartController cartController = Get.put(CartController());
    OrdersController ordersController = Get.put(OrdersController());
    return GetBuilder(
      init: homeController,
      builder: (controller) {
        return GetBuilder(
          init: cartController,
          builder: (controller) {
            return GetBuilder(
              init: ordersController,
              builder: (controller) {
                return cartController.isLoading == true
                    ? const CartShimmer()
                    : cartController.cartList.isEmpty
                        ? SizedBox(
                            height: Get.size.height * 0.75,
                            child: const Center(
                              child: Text('No Cart Items'),
                            ),
                          )
                        : ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return cartController.model == null ||
                                      cartController.model!.products.isEmpty
                                  ? SizedBox(
                                      height: Get.size.height / 2,
                                      child: const Center(
                                        child: Text('Cart is Empty'),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Card(
                                        elevation: 4,
                                        shadowColor: Colors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartController
                                                      .toProductScreen(index);
                                                },
                                                child: Row(
                                                  children: [
                                                    kWidth10,
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  '${ApiBaseUrl().baseUrl}/products/${cartController.model!.products[index].product.image[4]}',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          kHeight10,
                                                          Row(
                                                            children: [
                                                              CountWidget(
                                                                countNumber:
                                                                    '${cartController.model!.products[index].qty}',
                                                                minusPressed:
                                                                    () {
                                                                  cartController.incrementOrDecrementQuantity(
                                                                      -1,
                                                                      cartController
                                                                          .model!
                                                                          .products[
                                                                              index]
                                                                          .product
                                                                          .id,
                                                                      cartController
                                                                          .model!
                                                                          .products[
                                                                              index]
                                                                          .size,
                                                                      cartController
                                                                          .model!
                                                                          .products[
                                                                              index]
                                                                          .qty);
                                                                },
                                                                plusPressed:
                                                                    () {
                                                                  cartController
                                                                      .incrementOrDecrementQuantity(
                                                                    1,
                                                                    cartController
                                                                        .model!
                                                                        .products[
                                                                            index]
                                                                        .product
                                                                        .id,
                                                                    cartController
                                                                        .model!
                                                                        .products[
                                                                            index]
                                                                        .size,
                                                                    cartController
                                                                        .model!
                                                                        .products[
                                                                            index]
                                                                        .qty,
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: Get.size.width *
                                                              0.14),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            cartController
                                                                .model!
                                                                .products[index]
                                                                .product
                                                                .name,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          kHeight10,
                                                          RatingBar.builder(
                                                            initialRating: double
                                                                .parse(cartController
                                                                    .model!
                                                                    .products[
                                                                        index]
                                                                    .product
                                                                    .rating),
                                                            itemSize: 15,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            ignoreGestures:
                                                                true,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (startRating) {
                                                              log(startRating
                                                                  .toString());
                                                            },
                                                          ),
                                                          kHeight10,
                                                          Text(
                                                            "${cartController.model!.products[index].product.offer}%Off",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Montserrat",
                                                            ),
                                                          ),
                                                          kHeight10,
                                                          Text(
                                                            "₹${cartController.model!.products[index].product.price}",
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
                                                                  "Montserrat",
                                                            ),
                                                          ),
                                                          kHeight10,
                                                          Text(
                                                            "₹${(cartController.model!.products[index].product.price - cartController.model!.products[index].product.discountPrice).round()}",
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
                                                                  "Montserrat",
                                                            ),
                                                          ),
                                                          kHeight10,
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              kHeight10,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CartAlertWidget(
                                                              index: index,
                                                              cart:
                                                                  cartController,
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                const FractionalOffset(
                                                                    0, 0),
                                                            end:
                                                                const FractionalOffset(
                                                                    0.8, 0),
                                                            stops: const [
                                                              0,
                                                              0.6,
                                                            ],
                                                            tileMode:
                                                                TileMode.clamp,
                                                            colors: [
                                                              themeColor,
                                                              Colors.blue
                                                                  .shade500,
                                                            ],
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: const [
                                                            Icon(
                                                              Icons.delete,
                                                              color:
                                                                  kWhitecolor,
                                                              size: 23,
                                                            ),
                                                            Text(
                                                              'Remove item',
                                                              style: TextStyle(
                                                                  color:
                                                                      kWhitecolor,
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  letterSpacing:
                                                                      1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kWidth20,
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        ordersController
                                                            .toOrderScreen(
                                                                cartController
                                                                    .model!
                                                                    .products[
                                                                        index]
                                                                    .product
                                                                    .id,
                                                                cartController
                                                                    .model!.id);
                                                        ordersController
                                                            .isLoading = true;
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                const FractionalOffset(
                                                                    0, 0),
                                                            end:
                                                                const FractionalOffset(
                                                                    0.8, 0),
                                                            stops: const [
                                                              0.3,
                                                              0.9
                                                            ],
                                                            tileMode:
                                                                TileMode.clamp,
                                                            colors: [
                                                              Colors.blue
                                                                  .shade500,
                                                              themeColor,
                                                            ],
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Buy Now',
                                                            style: TextStyle(
                                                                color:
                                                                    kWhitecolor,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                            itemCount:
                                cartController.model?.products.length ?? 0,
                            separatorBuilder: (context, index) => kHeight20,
                          );
              },
            );
          },
        );
      },
    );
  }
}
