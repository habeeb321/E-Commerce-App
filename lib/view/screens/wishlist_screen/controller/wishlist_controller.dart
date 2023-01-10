import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';
import 'package:scotch/view/screens/wishlist_screen/model/wishlist_model.dart';
import 'package:scotch/view/screens/wishlist_screen/services/wishlist_service.dart';

class WishlistController extends GetxController {
  WishlistController(context) {
    getWishlist(context);
  }

  bool isLoading = false;

  WishlistService service = WishlistService();
  WishListModel? model;
  List<dynamic> wishList = [];
  void getWishlist(context) async {
    isLoading = true;
    update();
    await service.getWishlist(context).then(
      (value) {
        if (value != null) {
          model = value;
          update();
          wishList = model!.products.map((e) => e.product.id).toList();
          update();
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      },
    );
  }

  void addOrRemoveFromWishlist(context, String productId) async {
    isLoading = true;
    update();
    await service.addOrRemoveWishlist(context, productId).then((value) {
      if (value != null) {
        service.getWishlist(context).then((value) {
          if (value != null) {
            model = value;
            update();
            getWishlist(context);
            isLoading = false;
            update();
          } else {
            isLoading = false;
            update();
          }
        });
        if (value == 201) {
          Get.snackbar(
            'Wishlist',
            'Added To Wishlist',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (value == 204) {
          Get.snackbar(
            'Wishlist',
            'Removed From Wishlist',
            colorText: kWhitecolor,
            backgroundColor: kBlackcolor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        isLoading = false;
        update();
      }
    });
  }

  updateScreen() {
    update();
  }

  WishListModel findById(String id) {
    return wishList.firstWhere((element) => element.id == id);
  }

  void toProductScreen(index) {
    Get.toNamed(ProductScreen.routeName, arguments: wishList[index]);
  }
}
