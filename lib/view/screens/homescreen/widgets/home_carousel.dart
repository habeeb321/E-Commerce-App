import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/homescreen/controller/home_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatelessWidget {
  Carousel({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  List<String> items = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROEy6HFi9g3cF8EttxQpGM0juTIVLAhhxAbQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2ueq9b3-C9p-BzUtfeaE5MCsrwSG1R751zQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjJEY_JtGFkmuwMl-T-MpMFSbBtU8cWmah1w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm5N931d5WVvluRD3SygGFKlkUWZpokJ37FA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_oFigixtWJkdbizRFfhaMQCMVuKZ_OMx0o2YQoBYGmZiyGzsFMTWDtHAHRsISmsiVOLY&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: homeController.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : CarouselSlider.builder(
                      options: CarouselOptions(
                        height: size.height * 0.25,
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
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(items[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AnimatedSmoothIndicator(
                activeIndex: homeController.activeIndex,
                count: 5,
                effect: const WormEffect(dotHeight: 10, dotWidth: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}
