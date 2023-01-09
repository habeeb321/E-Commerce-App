import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class AddToCartDesButton extends StatelessWidget {
  const AddToCartDesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0.8, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
              colors: [
                themeColor,
                Color(0xFFFF97C1),
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
                'Add To Cart',
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
