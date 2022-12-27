import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/view/screens/account/account_screen.dart';
import 'package:scotch/view/screens/bottomnavbar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/categoryscreen/category_screen.dart';
import 'package:scotch/view/screens/homescreen/home_screen.dart';
import 'package:scotch/view/screens/orderscreen/order_screen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  BottomNavController bottomNavController = Get.put(BottomNavController());
  int currentIndex = 0;

  List pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const OrderScreen(),
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
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 25), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category, size: 25), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart, size: 25), label: 'Order'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 25), label: 'Account'),
            ],
            backgroundColor: const Color.fromARGB(255, 76, 104, 244),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              bottomNavController.currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
