import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  int activeIndex = 0;

  void getProductCarousel(index) {
    activeIndex = index;
    update();
  }

  void goBackHome(context) {
    Navigator.of(context).pop();
    activeIndex = 0;
    update();
  }
}
