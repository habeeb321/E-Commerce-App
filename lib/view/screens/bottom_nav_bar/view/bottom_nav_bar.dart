import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/profile_screen/view/profile_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/cart_screen/view/cart_screen.dart';
import 'package:scotch/view/screens/home_screen/view/home_screen.dart';
import 'package:scotch/view/screens/wishlist_screen/view/wishlist_screen.dart';

class BottomNavBar extends GetView<BottomNavController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    List pages = [
      const HomeScreen(),
      const CartScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: GetBuilder<BottomNavController>(
        builder: (controller) {
          return pages[controller.currentIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.size.width * 0.05,
                vertical: Get.size.height * 0.015,
              ),
              child: GNav(
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    iconSize: 30,
                    text: 'Home',
                  ),
                  GButton(
                      icon: Icons.shopping_cart_outlined,
                      iconSize: 30,
                      text: 'Cart'),
                  GButton(
                      icon: Icons.favorite_border_outlined,
                      iconSize: 30,
                      text: 'Wishlist'),
                  GButton(
                      icon: Icons.person_outline,
                      iconSize: 30,
                      text: 'Account'),
                ],
                backgroundColor: themeColor,
                color: kWhitecolor,
                activeColor: lightThemeColor,
                tabBackgroundColor: kWhitecolor,
                padding: const EdgeInsets.all(3),
                curve: Curves.bounceIn,
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  currentIndex = index;
                  controller.currentIndex = index;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
