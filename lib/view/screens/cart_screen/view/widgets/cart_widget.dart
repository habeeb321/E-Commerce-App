import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_controller/cart_and_order_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_shimmer.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/remove_buy_button.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartAndOrderController cartAndOrderController =
        Get.put(CartAndOrderController());
    return GetBuilder<CartAndOrderController>(
      builder: (controller) {
        return cartAndOrderController.isLoading == true
            ? const CartShimmer()
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return cartAndOrderController.cartList == null ||
                          cartAndOrderController.cartList!.products.isEmpty
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
                                      cartAndOrderController
                                          .toProductScreen(index);
                                    },
                                    child: Row(
                                      children: [
                                        kWidth10,
                                        Column(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  '${ApiBaseUrl().baseUrl}/products/${cartAndOrderController.cartList!.products[index].product.image[4]}',
                                                ),
                                              )),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    cartAndOrderController
                                                        .incrementDecrementQty(
                                                      -1,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .id,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .qty,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .size
                                                          .toString(),
                                                    );
                                                  },
                                                  icon: const Icon(Icons
                                                      .remove_circle_outline),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                  width: 40,
                                                  child: Text(
                                                    "${cartAndOrderController.cartList!.products[index].qty}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    cartAndOrderController
                                                        .incrementDecrementQty(
                                                      1,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .id,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .qty,
                                                      cartAndOrderController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .size
                                                          .toString(),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_circle_outline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.size.width * 0.05),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartAndOrderController
                                                    .cartList!
                                                    .products[index]
                                                    .product
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.bold),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              kHeight10,
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
                                              kHeight10,
                                              Text(
                                                "${cartAndOrderController.cartList!.products[index].product.offer}%Off",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                ),
                                              ),
                                              kHeight10,
                                              Text(
                                                "₹${cartAndOrderController.cartList!.products[index].product.price}",
                                                style: const TextStyle(
                                                  color: kGreyColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontFamily: "Montserrat",
                                                ),
                                              ),
                                              kHeight10,
                                              Text(
                                                "₹${(cartAndOrderController.cartList!.products[index].product.price - cartAndOrderController.cartList!.products[index].product.discountPrice).round()}",
                                                style: const TextStyle(
                                                  color: kRedColor,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
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
                                  RemoveBuyButton(
                                    index: index,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
                itemCount:
                    cartAndOrderController.cartList?.products.length ?? 0,
                separatorBuilder: (context, index) => kHeight20,
              );
      },
    );
  }
}
