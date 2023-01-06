import 'dart:developer';

import 'package:get/get.dart';
import 'package:scotch/view/screens/home_screen/model/carosel_model.dart';
import 'package:scotch/view/screens/home_screen/model/category_model.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';
import 'package:scotch/view/screens/home_screen/services/carosel_service.dart';
import 'package:scotch/view/screens/home_screen/services/category_service.dart';
import 'package:scotch/view/screens/home_screen/services/product_services.dart';

class HomeController extends GetxController {
  HomeController(context) {
    getCategory(context);
    getProduct(context);
    getCarousel(context);
  }
  int activeIndex = 0;
  bool isLoading = false;

  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<CarousalModel> carousalList = [];

  CategoryServices category = CategoryServices();
  ProductServices product = ProductServices();
  CarousalService carousal = CarousalService();

  void smoothIndicator(index) {
    activeIndex = index;
    update();
  }

  void getCategory(context) async {
    isLoading = true;
    update();
    await category.categoryUsers(context).then((value) {
      if (value != null) {
        categoryList = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        return null;
      }
    });
  }

  void getProduct(context) async {
    log('get');
    isLoading = true;
    update();
    await product.homeProducts(context).then((value) {
      log('product', name: 'product controller');
      if (value != null) {
        log('hai');
        productList = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        return null;
      }
    });
  }

  void getCarousel(context) async {
    isLoading = true;
    update();
    await carousal.homeCarousel(context).then((value) {
      if (value != null) {
        log('carousal no null');
        carousalList = value;
        update();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        return null;
      }
    });
  }
}
