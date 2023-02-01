import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/view/widgets/newly_launched_container.dart';
import 'package:scotch/view/screens/home_screen/view/widgets/category_container.dart';
import 'package:scotch/view/screens/home_screen/view/widgets/home_carousel.dart';
import 'package:scotch/view/screens/search_screen/view/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const SearchScreen());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: homeController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Carousel(),
                  kHeight20,
                  Divider(thickness: 2),
                  kHeight10,
                  Text('Categories', style: textStyle),
                  kHeight10,
                  CategoryContainer(),
                  kHeight10,
                  Divider(thickness: 2),
                  kHeight10,
                  Text('Newly launched', style: textStyle),
                  kHeight10,
                  NewlyLaunchedContainer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
