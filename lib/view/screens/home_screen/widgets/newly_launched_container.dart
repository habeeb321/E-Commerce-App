import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/widgets/shimmer_newly_launched.dart';

class NewlyLaunchedContainer extends StatelessWidget {
  NewlyLaunchedContainer({Key? key}) : super(key: key);

  double rotation = 5.5;
  Offset position = const Offset(40, 50);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
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
                return InkWell(
                  onTap: () => homeController.goToProdutScreen(index),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                height: 130,
                                image: NetworkImage(
                                    'http://${ApiBaseUrl.ip}:5000/products/${homeController.productList[index].image[4]}'),
                              ),
                              Text(
                                homeController.productList[index].name,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "₹${homeController.productList[index].price}",
                                style: const TextStyle(
                                  color: kBlackcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 13,
                          left: -5,
                          child: Transform.rotate(
                            angle: rotation,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "${homeController.productList[index].offer}%Off",
                                style: const TextStyle(
                                  color: kWhitecolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: homeController.productList.length,
            );
    });
  }
}
