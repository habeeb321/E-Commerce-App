import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/model/carosel_model.dart';
import 'package:scotch/view/screens/home_screen/model/category_model.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';
import 'package:scotch/view/screens/home_screen/services/carosel_service.dart';
import 'package:scotch/view/screens/home_screen/services/category_service.dart';
import 'package:scotch/view/screens/home_screen/services/product_services.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

class HomeController extends GetxController {
  HomeController() {
    getCategory();
    getProduct();
    getCarousel();
  }

  @override
  void onInit() {
    super.onInit();
    getConnectivity();
  }

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          isAlertSet = true;
          update();
        }
      });

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  showDialogBox() => Get.defaultDialog(
        barrierDismissible: false,
        title: "No Connection",
        content: const Text(
          "Please check your internet connectivity",
          style: TextStyle(color: kWhitecolor),
        ),
        backgroundColor: kBlackcolor,
        titleStyle: const TextStyle(color: Colors.white),
        radius: 30,
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              isAlertSet = false;
              update();
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                isAlertSet = true;
                update();
              }
            },
            child: const Text('OK'),
          ),
        ],
      );

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

  void getCategory() async {
    isLoading = true;
    update();
    await category.categoryUsers().then((value) {
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

  void getProduct() async {
    log('get');
    isLoading = true;
    update();
    await product.homeProducts().then((value) {
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

  void getCarousel() async {
    isLoading = true;
    update();
    await carousal.homeCarousel().then((value) {
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

  ProductModel findById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }

  void goToProdutScreen(index) {
    Get.toNamed(ProductScreen.routeName, arguments: productList[index].id);
  }

  List<ProductModel> findByCategoryId(String categoryId) {
    return productList
        .where((element) => element.category.contains(categoryId))
        .toList();
  }

  CategoryModel findByName(String id) {
    return categoryList.firstWhere((element) => element.id == id);
  }
}
