import 'package:get/get.dart';

class CarouselHomeController extends GetxController {
  int activeIndex = 0;

  void smoothIndicator(index) {
    activeIndex = index;
    update();
  }
}
