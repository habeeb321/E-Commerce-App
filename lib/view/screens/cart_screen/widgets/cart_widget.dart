import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/widgets/cart_alert_widget.dart';
import 'package:scotch/view/screens/cart_screen/widgets/cart_shimmer.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return GetBuilder<CartController>(
      builder: (controller) {
        return cartController.isLoading == true
            ? const CartShimmer()
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return cartController.cartList == null ||
                          cartController.cartList!.products.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: Text('Cart is Empty'),
                          ),
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartController.toProductScreen(index);
                              },
                              child: Row(
                                children: [
                                  kWidth10,
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                        '${ApiBaseUrl().baseUrl}/products/${cartController.cartList!.products[index].product.image[0]}',
                                      ),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartController.cartList!
                                              .products[index].product.name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              cartController
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
                                              "${cartController.cartList!.products[index].product.offer}%Off",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontFamily: "Manrope",
                                              ),
                                            ),
                                            kWidth10,
                                            Text(
                                              "₹${cartController.cartList!.products[index].product.price}",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontFamily: "Manrope",
                                              ),
                                            ),
                                            kWidth10,
                                            Text(
                                              "₹${(cartController.cartList!.products[index].product.price - cartController.cartList!.products[index].product.discountPrice).round()}",
                                              style: const TextStyle(
                                                color: Colors.red,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Manrope",
                                              ),
                                            ),
                                          ],
                                        ),
                                        kHeight10,
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // cartController.incrementDecrementQty(
                                                  //   -1,
                                                  //   cartController.cartList!.products[index]
                                                  //       .product.id,
                                                  //   cartController.cartList!.products[index]
                                                  //       .qty,
                                                  //   context,
                                                  //   cartController.cartList!.products[index]
                                                  //       .product.size
                                                  //       .toString(),
                                                  // );
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              kWidth10,
                                              Container(
                                                height: 25,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "${cartController.cartList!.products[index].qty}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              kWidth10,
                                              InkWell(
                                                onTap: () {
                                                  cartController
                                                      .incrementDecrementQty(
                                                    1,
                                                    cartController
                                                        .cartList!
                                                        .products[index]
                                                        .product
                                                        .id,
                                                    cartController.cartList!
                                                        .products[index].qty,
                                                    cartController
                                                        .cartList!
                                                        .products[index]
                                                        .product
                                                        .size
                                                        .toString(),
                                                  );
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kHeight10,
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CartAlertWidget(
                                            index: index,
                                            cart: cartController,
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.2),
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: kBlackcolor,
                                    ),
                                    label: const Text(
                                      'Remove',
                                      style: TextStyle(
                                          color: kBlackcolor,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    child: const Text(
                                      'Buy Now',
                                      style: TextStyle(
                                          color: kWhitecolor,
                                          fontFamily: 'Manrope',
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                            kHeight10,
                          ],
                        );
                },
                itemCount: cartController.cartList?.products.length ?? 0,
                separatorBuilder: (context, index) => const Divider(),
              );
      },
    );
  }
}
