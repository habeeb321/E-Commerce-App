import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/auth/splash_screen/view/splash_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Scotch',
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: SplashScreen(),
      unknownRoute: GetPage(
          name: ProductScreen.routeName, page: () => const ProductScreen()),
      getPages: [
        GetPage(
            name: ProductScreen.routeName, page: () => const ProductScreen()),
      ],
    );
  }
}
