import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/wishlist_screen/controller/wishlist_controller.dart';
import 'package:scotch/view/screens/wishlist_screen/view/widgets/wishlist_shimmer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WishlistController wishlistController =
        Get.put(WishlistController(context));
    Size size = Get.size;
    return Scaffold(
      backgroundColor: kGreyColor.shade200,
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: GetBuilder<WishlistController>(builder: (controller) {
            return wishlistController.isLoading == true
                ? const WishListShimmer()
                : Column(
                    children: [
                      wishlistController.model == null ||
                              wishlistController.model!.products.isEmpty
                          ? SizedBox(
                              height: size.height * 0.78,
                              child: const Center(
                                child: Text('Wishlist is Empty'),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  minVerticalPadding: 5,
                                  onTap: () =>
                                      wishlistController.toProductScreen(index),
                                  tileColor: kTileColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          '${ApiBaseUrl().baseUrl}/products/${wishlistController.model!.products[index].product.image[4]}'),
                                    ),
                                  ),
                                  title: Text(
                                    wishlistController
                                        .model!.products[index].product.name,
                                    style: textStyle,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kHeight5,
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            wishlistController
                                                .model!
                                                .products[index]
                                                .product
                                                .rating),
                                        itemSize: 15,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        ignoreGestures: true,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (startRating) {
                                          log(startRating.toString());
                                        },
                                      ),
                                      kHeight5,
                                      Text(
                                        "${wishlistController.model!.products[index].product.offer}%Off",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                      kHeight5,
                                      Text(
                                        "₹${wishlistController.model!.products[index].product.price}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        wishlistController
                                            .addOrRemoveFromWishlist(
                                                context,
                                                wishlistController
                                                    .model!
                                                    .products[index]
                                                    .product
                                                    .id);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: kRedColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => kHeight20,
                              itemCount: wishlistController.wishList.length,
                            ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
