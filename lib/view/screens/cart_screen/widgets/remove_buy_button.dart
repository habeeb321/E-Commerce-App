import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/widgets/cart_alert_widget.dart';

class RemoveBuyButton extends StatelessWidget {
  const RemoveBuyButton({
    Key? key,
    required this.cartController,
    required this.index,
  }) : super(key: key);

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CartAlertWidget(
                    index: index,
                    cart: cartController,
                  );
                },
              );
            },
            child: Container(
              height: 40,
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
                    Icons.delete,
                    color: kWhitecolor,
                    size: 23,
                  ),
                  Text(
                    'Remove item',
                    style: TextStyle(
                        color: kWhitecolor,
                        fontFamily: 'Manrope',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        kWidth20,
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
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
              child: const Center(
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                      color: kWhitecolor,
                      fontFamily: 'Manrope',
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
