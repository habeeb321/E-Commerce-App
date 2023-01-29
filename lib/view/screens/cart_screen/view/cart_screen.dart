import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_shimmer.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/counting_button.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/custom_outlined.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/show_alert.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: cartController.isLoading == true
              ? const CartShimmer()
              : cartController.model == null ||
                      cartController.model!.products.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: const Center(
                        child: Text('Cart is empty'),
                      ),
                    )
                  : ListView.separated(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartController.model?.products.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GetBuilder<CartController>(builder: (controller) {
                              return GestureDetector(
                                onTap: () {
                                  cartController.cartToProductView(index);
                                },
                                child: Row(
                                  children: [
                                    cartController.isLoading == true ||
                                            cartController.cartList.isEmpty
                                        ? const CircularProgressIndicator()
                                        : Container(
                                            height: 90,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: NetworkImage(
                                                '${ApiBaseUrl().baseUrl}/products/${cartController.model!.products[index].product.image[0]}',
                                              ),
                                            )),
                                          ),
                                    kWidth10,
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .73,
                                            child: Text(
                                              cartController.model!
                                                  .products[index].product.name,
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
                                                color: Color.fromARGB(
                                                    255, 24, 110, 29),
                                              );
                                            },
                                            itemSize: 16,
                                            initialRating: double.parse(
                                                cartController
                                                    .model!
                                                    .products[index]
                                                    .product
                                                    .rating),
                                          ),
                                          kHeight10,
                                          Row(
                                            children: [
                                              Text(
                                                "${cartController.model!.products[index].product.offer}%off",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                '₹${cartController.model!.products[index].price}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: kGreyColor,
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                '₹${(cartController.model!.products[index].price - cartController.model!.products[index].discountPrice).round()}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.clip),
                                              ),
                                            ],
                                          ),
                                          kHeight10,
                                          CountButton(
                                            countNumber:
                                                '${cartController.model!.products[index].qty}',
                                            minusPressed: () {
                                              cartController
                                                  .incrementOrDecrementQuantity(
                                                -1,
                                                cartController.model!
                                                    .products[index].product.id,
                                                cartController.model!
                                                    .products[index].size,
                                                cartController
                                                    .model!.products[index].qty,
                                              );
                                            },
                                            plusPressed: () {
                                              cartController
                                                  .incrementOrDecrementQuantity(
                                                1,
                                                cartController.model!
                                                    .products[index].product.id,
                                                cartController.model!
                                                    .products[index].size,
                                                cartController
                                                    .model!.products[index].qty,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            kHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<CartController>(
                                  builder: (controller) {
                                    return CustomOutlineButton(
                                      text: "Remove",
                                      icon: Icons.delete_outlined,
                                      buttonColor: kRedColor,
                                      onPressed: () {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return ShowAlertWidget(
                                              yesPress: () {
                                                cartController.removeFromCart(
                                                  cartController
                                                      .model!
                                                      .products[index]
                                                      .product
                                                      .id,
                                                );
                                              },
                                              title: 'Remove Item',
                                              contant:
                                                  'Are you sure you want to remove this item?',
                                            );
                                          },
                                        );
                                      },
                                      width: MediaQuery.of(context).size.width *
                                          .47,
                                    );
                                  },
                                ),
                                GetBuilder<CartController>(
                                  builder: (controller) {
                                    return CustomOutlineButton(
                                      text: "BUY NOW",
                                      icon: Icons.currency_rupee_outlined,
                                      buttonColor: themeColor,
                                      onPressed: () {
                                        cartController.loading = true;
                                        cartController.toOderScreen(
                                          cartController.model!.products[index]
                                              .product.id,
                                          cartController.model!.id,
                                        );
                                      },
                                      width: MediaQuery.of(context).size.width *
                                          .47,
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
        ),
      ),
      bottomNavigationBar: cartController.totalSave == 0 ||
              cartController.totalSave == null
          ? const SizedBox()
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
                title: Text(
                  "₹${cartController.model?.totalPrice ?? 0}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kGreyColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Text(
                  "₹${(cartController.model!.totalPrice - cartController.model!.totalDiscount).round()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: SizedBox(
                  width: 200,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return const OrderScreen(
                                screenCheck: OrderScreenEnum.normalOrderScreen,
                                cartId: '',
                                productId: '',
                              );
                            },
                          ));
                          cartController.loading = false;
                        },
                        child: Text(
                          'PLACE ORDER (${cartController.totalProductCount})',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
