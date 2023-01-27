import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/widgets/cart_alert_widget.dart';

class RemoveBuyButton extends StatelessWidget {
  const RemoveBuyButton({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
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
                        fontFamily: 'Montserrat',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        kWidth20,
        GetBuilder<CartController>(builder: (context) {
          return Expanded(
            child: InkWell(
              onTap: () {
                cartController.toOrderScreen(
                    cartController.cartList!.products[index].product.id,
                    cartController.cartList!.id);
                cartController.isLoading = true;
              },
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
                        fontFamily: 'Montserrat',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
