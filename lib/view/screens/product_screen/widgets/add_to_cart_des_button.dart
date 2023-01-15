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
            gradient: LinearGradient(
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(0.8, 0),
              stops: const [
                0,
                0.6,
              ],
              tileMode: TileMode.clamp,
              colors: [
                themeColor,
                Colors.blue.shade500,
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
