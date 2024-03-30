import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/widgets/shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ShimmerWidget.rectangle(height: 150, width: double.infinity),
        ),
        kHeight10,
      ],
    );
  }
}
