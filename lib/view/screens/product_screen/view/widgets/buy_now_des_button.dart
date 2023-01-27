import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/product_screen/view/widgets/favorite_button.dart';
import 'package:scotch/view/screens/wishlist_screen/controller/wishlist_controller.dart';
import 'package:scotch/view/screens/wishlist_screen/view/wishlist_screen.dart';

class BuyNowDesButton extends StatelessWidget {
  const BuyNowDesButton({
    Key? key,
    required this.id,
    required this.size,
  }) : super(key: key);

  final String id;
  final List<String> size;

  @override
  Widget build(BuildContext context) {
    WishlistController wishlistController =
        Get.put(WishlistController(context));
    return GetBuilder<WishlistController>(
      builder: (controller) {
        return wishlistController.wishList.contains(id)
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    wishlistController.wishList.contains(id);
                    Get.to(const WishlistScreen());
                  },
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: FavoriteButton(id: id),
                        ),
                        const Text(
                          'Open Wishlist',
                          style: TextStyle(
                            color: kWhitecolor,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: FavoriteButton(id: id),
                        ),
                        const Text(
                          'Wishlist',
                          style: TextStyle(
                            color: kWhitecolor,
                            fontFamily: "Montserrat",
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
      },
    );
  }
}
