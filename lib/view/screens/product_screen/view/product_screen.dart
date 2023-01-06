import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/product_screen/controller/product_controller.dart';
import 'package:scotch/view/screens/product_screen/widgets/preview_product.dart';
import 'package:scotch/view/screens/product_screen/widgets/product_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const routeName = '/product_screen.dart';

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(context));
    ProductController productController = Get.put(ProductController());
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final homeCtr = homeController.findById(productId);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ProductController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    kHeight10,
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CarouselSlider.builder(
                            itemCount: homeCtr.image.length,
                            itemBuilder: (context, index, realIndex) {
                              return Center(
                                child: Image(
                                  image: NetworkImage(
                                      'http://172.16.6.168:5000/products/${homeCtr.image[index]}'),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 250,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                productController.getProductCarousel(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHeight10,
                    AnimatedSmoothIndicator(
                      activeIndex: productController.activeIndex,
                      count: homeCtr.image.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.orange,
                      ),
                    ),
                    kHeight10,
                    PreviewProductWidget(image: homeCtr.image),
                    kHeight20,
                    ProductDetailsWidget(
                      name: homeCtr.name,
                      price: homeCtr.price,
                      rating: homeCtr.rating,
                    ),
                    kHeight10,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
