import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/view/screens/wishlist_screen/controller/wishlist_controller.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    WishlistController wishlistController =
        Get.put(WishlistController(context));
    return GetBuilder<WishlistController>(builder: (context) {
      return GestureDetector(
        onTap: () => wishlistController.addOrRemoveFromWishlist(context, id),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            wishlistController.wishList.contains(id)
                ? Icons.favorite
                : Icons.favorite_outline_outlined,
            color: wishlistController.wishList.contains(id)
                ? Colors.red
                : Colors.black,
            size: 30,
          ),
        ),
      );
    });
  }
}
