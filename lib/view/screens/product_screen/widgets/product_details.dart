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
          divider,
          kHeight10,
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
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
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
              kWidth10,
              Text(
                '₹${price.toString()}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          kHeight10,
          divider,
          kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: const FractionalOffset(0, 0),
                        end: const FractionalOffset(0.8, 0),
                        stops: const [0, 1],
                        tileMode: TileMode.clamp,
                        colors: [
                          Colors.lightBlue.shade900,
                          Colors.lightBlue,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: kWhitecolor,
                          size: 25,
                        ),
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            color: kWhitecolor,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kWidth10,
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: const FractionalOffset(0, 0),
                        end: const FractionalOffset(0.8, 0),
                        stops: const [0, 1],
                        tileMode: TileMode.clamp,
                        colors: [
                          Colors.lightBlue,
                          Colors.lightBlue.shade900,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: kWhitecolor,
                          size: 25,
                        ),
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            color: kWhitecolor,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
