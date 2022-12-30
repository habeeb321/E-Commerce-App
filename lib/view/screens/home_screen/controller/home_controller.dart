import 'package:get/get.dart';

class HomeController extends GetxController {
  int activeIndex = 0;
  bool isLoading = false;

  void smoothIndicator(index) {
    activeIndex = index;
    update();
  }
}
