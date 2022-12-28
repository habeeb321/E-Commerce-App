import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scotch/view/screens/homescreen/controller/carousel_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CarouselHomeController carouselController = Get.put(CarouselHomeController());
  List items = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROEy6HFi9g3cF8EttxQpGM0juTIVLAhhxAbQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2ueq9b3-C9p-BzUtfeaE5MCsrwSG1R751zQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjJEY_JtGFkmuwMl-T-MpMFSbBtU8cWmah1w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm5N931d5WVvluRD3SygGFKlkUWZpokJ37FA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_oFigixtWJkdbizRFfhaMQCMVuKZ_OMx0o2YQoBYGmZiyGzsFMTWDtHAHRsISmsiVOLY&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 45,
              child: CupertinoSearchTextField(
                prefixInsets: EdgeInsetsDirectional.fromSTEB(7, 3, 5, 2),
              ),
            ),
            kHeight10,
            GetBuilder<CarouselHomeController>(
              builder: (controller) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      items: items
                          .map((image) => Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: size.height * 0.25,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          carouselController.smoothIndicator(index);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedSmoothIndicator(
                        activeIndex: carouselController.activeIndex,
                        count: items.length,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
