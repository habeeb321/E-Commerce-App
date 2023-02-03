import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:scotch/view/screens/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/profile_screen/order_placed/widgets/order_details_view.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = Get.put(OrdersController());
    BottomNavController bottomNavController = Get.put(BottomNavController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getAllOrders();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        actions: [
          GetBuilder<BottomNavController>(
            builder: (controller) {
              return IconButton(
                onPressed: () {
                  Get.offAll(const BottomNavBar());
                  bottomNavController.currentIndex = 3;
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                ),
              );
            },
          ),
        ],
      ),
      body: ordersController.isLoading == true
          ? SizedBox(
              height: Get.size.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : GetBuilder<OrdersController>(
              builder: (controller) {
                return ordersController.ordersList!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Your Orders is empty!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black54,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                foregroundColor: kWhitecolor,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Get.back();
                                bottomNavController.gotoHomescreen();
                              },
                              child: const Text('Order Now'),
                            ),
                          ],
                        ),
                      )
                    : ordersController.isLoading == true
                        ? const CircularProgressIndicator()
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: ListView.separated(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final deliveryDate =
                                    ordersController.formatDate(ordersController
                                        .ordersList![index].deliveryDate
                                        .toString());
                                final canceledDate = ordersController
                                    .formatCancelDate(ordersController
                                        .ordersList![index].cancelDate
                                        .toString());
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: ordersController
                                      .ordersList![index].products.length,
                                  itemBuilder: (context, index1) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(OrderDetialsView(
                                          orderId: ordersController
                                              .ordersList![index].id,
                                          index1: index1,
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          Image(
                                            height: 70,
                                            width: 70,
                                            image: NetworkImage(
                                              "${ApiBaseUrl().baseUrl}/products/${ordersController.ordersList![index].products[index1].product.image[4]}",
                                            ),
                                          ),
                                          kWidth10,
                                          SizedBox(
                                            width: Get.size.width * 0.4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ordersController
                                                      .ordersList![index]
                                                      .products[index1]
                                                      .product
                                                      .name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                                Text(
                                                  ordersController
                                                              .ordersList![
                                                                  index1]
                                                              .orderStatus ==
                                                          'CANCELED'
                                                      ? 'Delivery Canceled on $canceledDate'
                                                      : ordersController
                                                                  .ordersList![
                                                                      index1]
                                                                  .orderStatus ==
                                                              'delivered'
                                                          ? 'Delivered on $deliveryDate'
                                                          : 'Delivery on $deliveryDate',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount:
                                  ordersController.ordersList?.length ?? 0,
                            ),
                          );
              },
            ),
    );
  }
}
