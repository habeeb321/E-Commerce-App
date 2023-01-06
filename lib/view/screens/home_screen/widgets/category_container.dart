import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/widgets/shimmer_category.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(context));
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return homeController.categoryList.isEmpty
          ? const CategoryShimmer()
          : Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  "http://172.16.6.168:5000/category/${homeController.categoryList[index].image}"),
                            ),
                            Row(
                              children: [
                                Text(
                                  homeController.categoryList[index].name,
                                  style: const TextStyle(
                                      color: kBlackcolor, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.categoryList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return kWidth10;
                    },
                  ),
                ),
              ],
            );
    });
  }
}
