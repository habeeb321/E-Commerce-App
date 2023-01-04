import 'package:get/get.dart';
import 'package:scotch/view/screens/home_screen/model/category_model.dart';
import 'package:scotch/view/screens/home_screen/model/product_model.dart';
import 'package:scotch/view/screens/home_screen/services/category_service.dart';
import 'package:scotch/view/screens/home_screen/services/product_services.dart';

class HomeController extends GetxController {
  HomeController(context) {
    getCategory(context);
    getProduct(context);
  }
  int activeIndex = 0;
  bool isLoading = false;

  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];

  CategoryServices category = CategoryServices();
  ProductServices product = ProductServices();

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
    isLoading = true;
    update();
    await product.homeProducts(context).then((value) {
      if (value != null) {
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
}
