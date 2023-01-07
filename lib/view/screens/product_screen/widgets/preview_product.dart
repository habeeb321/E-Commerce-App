import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class PreviewProductWidget extends StatelessWidget {
  const PreviewProductWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final List<String> image;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    'http://172.16.6.168:5000/products/${image[index]}',
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return kWidth10;
          },
          itemCount: image.length,
        ),
      ),
    );
  }
}
