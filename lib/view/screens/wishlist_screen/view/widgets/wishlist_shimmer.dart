import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/widgets/shimmer.dart';
import 'package:scotch/view/screens/wishlist_screen/controller/wishlist_controller.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const ShimmerWidget.rectangle(height: 100, width: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight10,
                            const ShimmerWidget.rectangle(
                                height: 10, width: 50),
                            kHeight10,
                            const ShimmerWidget.rectangle(
                                height: 10, width: 50),
                            kHeight10,
                            Row(
                              children: const [
                                ShimmerWidget.rectangle(height: 10, width: 20),
                                kWidth10,
                                ShimmerWidget.rectangle(height: 10, width: 30),
                                kWidth10,
                                ShimmerWidget.rectangle(height: 10, width: 30),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kWidth20,
                      const ShimmerWidget.circle(height: 30, width: 30),
                    ],
                  ),
                  kHeight10,
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 10,
          ),
        ],
      );
    });
  }
}
