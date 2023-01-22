import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const routeName = "/category_screen.dart";

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final homeCtr = homeController.findByCategoryId(productId);
    return Scaffold(
      backgroundColor: kGreyColor.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GridView.builder(
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
                        color: kWhitecolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            height: 130,
                            image: NetworkImage(
                                'http://${ApiBaseUrl.ip}:5000/products/${homeCtr[index].image[4]}'),
                          ),
                          Text(
                            homeCtr[index].name,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "${homeCtr[index].offer}%Off",
                              style: const TextStyle(
                                color: kWhitecolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "₹${homeCtr[index].price}",
                            style: const TextStyle(
                              color: kBlackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: homeCtr.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
