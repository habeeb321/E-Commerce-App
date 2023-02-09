import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.discountPrice,
    required this.offer,
  }) : super(key: key);

  final String name;
  final int price;
  final String rating;
  final String description;
  final dynamic discountPrice;
  final int offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhitecolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight10,
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              letterSpacing: 1.2,
            ),
          ),
          kHeight10,
          const Text(
            'About This item',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          kHeight10,
          Text(
            description,
            style: const TextStyle(wordSpacing: 3),
          ),
          kHeight10,
          RichText(
            text: TextSpan(
              text: rating,
              style: const TextStyle(color: kBlackcolor),
              children: [
                WidgetSpan(
                  child: RatingBar.builder(
                    initialRating: double.parse(rating),
                    itemSize: 15,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onRatingUpdate: (startRating) {
                      log(startRating.toString());
                    },
                  ),
                )
              ],
            ),
          ),
          kHeight10,
          Row(
            children: [
              Text(
                '-${offer.toString()}%',
                style: const TextStyle(color: kRedColor, fontSize: 20),
              ),
              kWidth10,
              Text(
                '₹${(price - discountPrice).round()}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          kHeight10,
        ],
      ),
    );
  }
}
