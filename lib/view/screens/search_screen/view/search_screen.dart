import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/view/widgets/shimmer_newly_launched.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: CupertinoSearchTextField(
                      prefixInsets:
                          const EdgeInsetsDirectional.fromSTEB(10, 4, 5, 3),
                      backgroundColor: const Color(0xFFF0EFFF),
                      controller: homeController.searchController,
                      onChanged: (value) {
                        homeController.search(value);
                      },
                    ),
                  ),
                  kHeight20,
                  homeController.seachResult.isEmpty
                      ? SizedBox(
                          height: Get.size.height * 0.7,
                          child: const Center(
                            child: Text(
                              'No Search Results Found',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : homeController.isLoading == true
                          ? const NewlyLaunchedShimmer()
                          : ListView.separated(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    homeController.goToProdutScreen(index);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            kWidth10,
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  '${ApiBaseUrl().baseUrl}/products/${homeController.seachResult[index].image[4]}',
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    homeController
                                                        .seachResult[index]
                                                        .name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: 'Manrope',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(
                                                        homeController
                                                            .seachResult[index]
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
                                                    onRatingUpdate:
                                                        (startRating) {
                                                      log(startRating
                                                          .toString());
                                                    },
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${homeController.seachResult[index].offer}%Off",
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          fontFamily: "Manrope",
                                                        ),
                                                      ),
                                                      kWidth10,
                                                      Text(
                                                        "₹${homeController.seachResult[index].price}",
                                                        style: const TextStyle(
                                                          color: kGreyColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontFamily: "Manrope",
                                                        ),
                                                      ),
                                                      kWidth10,
                                                      Text(
                                                        "₹${(homeController.seachResult[index].price - homeController.seachResult[index].discountPrice).round()}",
                                                        style: const TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "Manrope",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      kHeight10,
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: homeController.seachResult.length,
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
