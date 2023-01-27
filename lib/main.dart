import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/controller/all_binding_controller.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/splash_screen/view/splash_screen.dart';
import 'package:scotch/view/screens/home_screen/view/widgets/category_screen.dart';
import 'package:scotch/view/screens/product_screen/view/product_screen.dart';

void main() {
  runApp(DevicePreview(
    enabled: false,
    tools: const [
      ...DevicePreview.defaultTools,
    ],
    builder: (BuildContext context) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBindingController(),
      debugShowCheckedModeBanner: false,
      title: 'Scotch',
      theme: ThemeData(
        primaryColor: themeColor,
        appBarTheme: const AppBarTheme(color: themeColor),
      ),
      home: const SplashScreen(),
      unknownRoute: GetPage(
          name: ProductScreen.routeName, page: () => const ProductScreen()),
      getPages: [
        GetPage(
            name: ProductScreen.routeName, page: () => const ProductScreen()),
        GetPage(
            name: CategoryScreen.routeName, page: () => const CategoryScreen()),
        //GetPage(name: OrderScreen.routeName, page: () =>  OrderScreen()),
      ],
    );
  }
}
