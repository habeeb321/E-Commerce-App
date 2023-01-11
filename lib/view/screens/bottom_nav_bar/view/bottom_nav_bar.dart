import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/account/account_screen.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/category_screen/category_screen.dart';
import 'package:scotch/view/screens/home_screen/view/home_screen.dart';
import 'package:scotch/view/screens/wishlist_screen/view/wishlist_screen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  BottomNavController bottomNavController = Get.put(BottomNavController());
  int currentIndex = 0;

  List pages = [
    HomeScreen(),
    const CategoryScreen(),
    const WishlistScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavController>(
        builder: (controller) {
          return pages[bottomNavController.currentIndex];
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              child: GNav(
                tabs: const [
                  GButton(
                      icon: Icons.home_outlined, iconSize: 30, text: 'Home'),
                  GButton(
                      icon: Icons.category_outlined,
                      iconSize: 30,
                      text: 'Category'),
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
                activeColor: kWhitecolor,
                tabBackgroundColor: const Color(0xFFFF5858),
                padding: const EdgeInsets.all(8),
                curve: Curves.bounceIn,
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  currentIndex = index;
                  bottomNavController.currentIndex = index;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
