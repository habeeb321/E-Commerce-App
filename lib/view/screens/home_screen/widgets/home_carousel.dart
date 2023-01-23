import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/home_screen/widgets/shimmer_carousel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    Size size = Get.size;
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: homeController.isLoading == true
                  ? const CarouselShimmer()
                  : CarouselSlider.builder(
                      options: CarouselOptions(
                        height: size.height * 0.30,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {
                          homeController.smoothIndicator(index);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return homeController.carousalList.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "http://${ApiBaseUrl.ip}:5000/carousals/${homeController.carousalList[index].image}"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                      },
                      itemCount: homeController.carousalList.length,
                    ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AnimatedSmoothIndicator(
                activeIndex: homeController.activeIndex,
                count: homeController.carousalList.length,
                effect: const WormEffect(dotHeight: 10, dotWidth: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}
