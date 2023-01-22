import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class BuyNowDesButton extends StatelessWidget {
  const BuyNowDesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(0.8, 0),
              stops: const [0.3, 0.9],
              tileMode: TileMode.clamp,
              colors: [
                Colors.blue.shade500,
                themeColor,
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
    );
  }
}
