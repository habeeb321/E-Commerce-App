import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/widgets/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  CategoryShimmer({super.key, required this.child});

  var child = Widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              kWidth10,
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const ShimmerWidget.circle(height: 60, width: 60),
                  ),
                  kHeight10,
                  const ShimmerWidget.rectangle(height: 20, width: 60)
                ],
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return kWidth10;
        },
      ),
    );
  }
}
