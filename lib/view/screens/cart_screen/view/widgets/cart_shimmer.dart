import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/widgets/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                kWidth10,
                ShimmerWidget.rectangle(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.18,
                  radius: BorderRadius.circular(5),
                ),
                kWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight10,
                    ShimmerWidget.rectangle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                      radius: BorderRadius.circular(
                        3,
                      ),
                    ),
                    kHeight10,
                    ShimmerWidget.rectangle(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.7,
                      radius: BorderRadius.circular(
                        3,
                      ),
                    ),
                    kHeight5,
                    Row(
                      children: [
                        ShimmerWidget.rectangle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
                        ),
                        kWidth10,
                        ShimmerWidget.rectangle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
                        ),
                        kWidth10,
                        ShimmerWidget.rectangle(
                          height: 10,
                          width: 60,
                          radius: BorderRadius.circular(
                            3,
                          ),
                        ),
                      ],
                    ),
                    kHeight10,
                    ShimmerWidget.rectangle(
                      height: 20,
                      width: 40,
                      radius: BorderRadius.circular(
                        6,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
