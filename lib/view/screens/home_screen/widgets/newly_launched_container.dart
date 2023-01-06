import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/widgets/shimmer_newly_launched.dart';

class NewlyLaunchedContainer extends StatelessWidget {
  const NewlyLaunchedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(context));

    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return homeController.isLoading == true
          ? const NewlyLaunchedShimmer()
          : GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 5.1 / 6,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://172.16.6.168:5000/products/${homeController.productList[index].image[4]}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(homeController.productList[index].name),
                          Text("₹${homeController.productList[index].price}"),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: homeController.productList.length,
            );
    });
  }
}
