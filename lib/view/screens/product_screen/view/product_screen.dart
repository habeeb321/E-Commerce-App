import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
import 'package:scotch/view/screens/product_screen/controller/product_controller.dart';
import 'package:scotch/view/screens/product_screen/view/widgets/add_to_cart_des_button.dart';
import 'package:scotch/view/screens/product_screen/view/widgets/wishlist_button.dart';
import 'package:scotch/view/screens/product_screen/view/widgets/preview_product.dart';
import 'package:scotch/view/screens/product_screen/view/widgets/product_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const routeName = '/product_screen.dart';

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    ProductController productController = Get.put(ProductController());
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final homeCtr = homeController.findById(productId);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kGreyColor.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_backspace, color: kBlackcolor),
        ),
        title: Text(
          homeCtr.name,
          style: const TextStyle(
              color: kBlackcolor,
              fontFamily: 'Playfair Display',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ProductController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(16),
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
                                      '${ApiBaseUrl().baseUrl}/products/${homeCtr.image[index]}'),
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
                        dotColor: kGreyColor,
                        activeDotColor: Colors.orange,
                      ),
                    ),
                    kHeight10,
                    PreviewProductWidget(image: homeCtr.image),
                    kHeight10,
                    ProductDetailsWidget(
                      name: homeCtr.name,
                      price: homeCtr.price,
                      rating: homeCtr.rating,
                      description: homeCtr.description,
                      discountPrice: homeCtr.discountPrice,
                      offer: homeCtr.offer,
                    ),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddToCartDesButton(
                            id: homeCtr.id,
                            productId: productId,
                            size: homeCtr.size),
                        kWidth10,
                        WishlistButton(id: homeCtr.id, size: homeCtr.size),
                      ],
                    ),
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
