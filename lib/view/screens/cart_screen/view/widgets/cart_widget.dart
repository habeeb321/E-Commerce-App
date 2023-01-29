import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_shimmer.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/count_widget.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/remove_buy_button.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoaController coaController = Get.put(CoaController());
    return GetBuilder<CoaController>(
      builder: (controller) {
        return coaController.isLoadingc == true
            ? const CartShimmer()
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return coaController.cartList == null ||
                          coaController.cartList!.products.isEmpty
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
                                      coaController.toProductScreen(index);
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
                                                  '${ApiBaseUrl().baseUrl}/products/${coaController.cartList!.products[index].product.image[0]}',
                                                ),
                                              )),
                                            ),
                                            kHeight10,
                                            Row(
                                              children: [
                                                CountWidget(
                                                  countNumber:
                                                      '${coaController.cartList!.products[index].qty}',
                                                  minusPressed: () {
                                                    coaController
                                                        .incrementOrDecrementQuantity(
                                                      -1,
                                                      coaController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .id,
                                                      coaController.cartList!
                                                          .products[index].size,
                                                      coaController.cartList!
                                                          .products[index].qty,
                                                      context,
                                                    );
                                                  },
                                                  plusPressed: () {
                                                    coaController
                                                        .incrementOrDecrementQuantity(
                                                      1,
                                                      coaController
                                                          .cartList!
                                                          .products[index]
                                                          .product
                                                          .id,
                                                      coaController.cartList!
                                                          .products[index].size,
                                                      coaController.cartList!
                                                          .products[index].qty,
                                                      context,
                                                    );
                                                  },
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
                                                coaController
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
                                                    coaController
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
                                                "${coaController.cartList!.products[index].product.offer}%Off",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                ),
                                              ),
                                              kHeight10,
                                              Text(
                                                "₹${coaController.cartList!.products[index].product.price}",
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
                                                "₹${(coaController.cartList!.products[index].product.price - coaController.cartList!.products[index].product.discountPrice).round()}",
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
                itemCount: coaController.cartList?.products.length ?? 0,
                separatorBuilder: (context, index) => kHeight20,
              );
      },
    );
  }
}
