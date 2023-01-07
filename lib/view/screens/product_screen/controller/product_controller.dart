import 'package:get/get.dart';

class ProductController extends GetxController {
  int activeIndex = 0;

  void getProductCarousel(index) {
    activeIndex = index;
    update();
  }

  void goBackHome(context) {
    Get.back();
    activeIndex = 0;
    update();
  }
}
