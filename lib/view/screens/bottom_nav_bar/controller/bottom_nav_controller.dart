import 'package:get/get.dart';
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/home_screen/view/home_screen.dart';
import 'package:scotch/view/screens/profile_screen/profile/view/profile_screen.dart';
import 'package:scotch/view/screens/wishlist_screen/view/wishlist_screen.dart';

class BottomNavController extends GetxController {
  
  int currentIndex = 0;

  List pages = [
    const HomeScreen(),
    const CartScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  void bottomNav(value) {
    currentIndex = value;
    update();
  }

  void gotoHomescreen() {
    currentIndex = 0;
    update();
  }
}
