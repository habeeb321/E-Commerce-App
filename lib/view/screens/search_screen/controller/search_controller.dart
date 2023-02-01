// import 'package:get/get.dart';
// import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';
// import 'package:scotch/view/screens/home_screen/model/product_model.dart';

// class SearchController extends GetxController {
//   HomeController homeController = Get.put(HomeController());
//   late List<ProductModel> productList = homeController.productList;
//   List<ProductModel> foundItems = [];

//   void itemsLoading() {
//     foundItems = productList;
//     update();
//   }

//   void search(String enteredKeyword) {
//     List<ProductModel> results = [];
//     if (enteredKeyword.isEmpty) {
//       results = productList;
//     } else {
//       results = productList
//           .where((element) =>
//               element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//     }
//     foundItems = results;
//     update();
//   }
// }
