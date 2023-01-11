import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/widgets/newly_launched_container.dart';
import 'package:scotch/view/screens/home_screen/widgets/category_container.dart';
import 'package:scotch/view/screens/home_screen/widgets/home_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(context),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: const [
                  SizedBox(
                    height: 45,
                    child: CupertinoSearchTextField(
                      prefixInsets: EdgeInsetsDirectional.fromSTEB(7, 3, 5, 2),
                    ),
                  ),
                  kHeight10,
                  Carousel(),
                  kHeight10,
                  Text('Categories', style: textStyle),
                  kHeight10,
                  CategoryContainer(),
                  kHeight10,
                  Text('Newly launched', style: textStyle),
                  kHeight10,
                  NewlyLaunchedContainer(),
                ],
              ),
            );
          }),
    );
  }
}
