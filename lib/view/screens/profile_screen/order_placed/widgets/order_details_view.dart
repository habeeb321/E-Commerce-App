import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';
import 'package:scotch/view/screens/profile_screen/order_placed/widgets/order_cancel_widget.dart';
import 'package:scotch/view/screens/profile_screen/order_placed/widgets/order_success_widget.dart';

class OrderDetialsView extends StatelessWidget {
  const OrderDetialsView({
    super.key,
    required this.orderId,
    required this.index1,
  });

  final String orderId;
  final int index1;
  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = Get.put(OrdersController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ordersController.getSingleOrder(orderId);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrdersController>(
          builder: (controller) {
            return ordersController.isLoading == true ||
                    ordersController.singleModel == null
                ? SizedBox(
                    height: Get.size.height * 0.5,
                    child: const Center(child: CircularProgressIndicator()))
                : Column(
                    children: [
                      Card(
                        color: kWhitecolor,
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ID - ${ordersController.singleModel!.id.toUpperCase()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: kGreyColor,
                                  fontSize: 12,
                                ),
                              ),
                              divider,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ordersController.singleModel!
                                            .products[index1].product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      kHeight10,
                                      Text(
                                        "₹${(ordersController.singleModel!.products[index1].product.price - ordersController.singleModel!.products[index1].product.discountPrice).round()}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image(
                                    height: 80,
                                    width: 100,
                                    image: NetworkImage(
                                        '${ApiBaseUrl().baseUrl}/products/${ordersController.singleModel!.products[index1].product.image[4]}'),
                                  )
                                ],
                              ),
                              divider,
                              ordersController.singleModel!.orderStatus ==
                                      'CANCELED'
                                  ? OrderCanceldStatusWidget(index: index1)
                                  : OrderSucssesStatusWidget(index: index1),
                              divider,
                              GetBuilder<OrdersController>(
                                builder: (controller) {
                                  return ordersController
                                              .singleModel!.orderStatus ==
                                          'CANCELED'
                                      ? Center(
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  Colors.grey.shade600,
                                            ),
                                            onPressed: () {
                                              ordersController
                                                  .sendOrderDetials();
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                              size: 20,
                                            ),
                                            label: const Text(
                                              'Share Order Details',
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.grey.shade600,
                                              ),
                                              onPressed: () {
                                                ordersController
                                                    .cancelOrder(orderId);
                                                Get.back();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            const VerticalDivider(
                                                endIndent: 20),
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.grey.shade600,
                                              ),
                                              onPressed: () {
                                                ordersController
                                                    .sendOrderDetials();
                                              },
                                              icon: const Icon(
                                                Icons.share,
                                                size: 20,
                                              ),
                                              label: const Text(
                                                'Share Order Details',
                                              ),
                                            )
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      GetBuilder<OrdersController>(
                        builder: (controller) {
                          return Card(
                            color: kWhitecolor,
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Shopping Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: kGreyColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  divider,
                                  Text(
                                    ordersController.singleModel!.fullName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  kHeight5,
                                  Text(
                                      '${ordersController.singleModel!.address}\n${ordersController.singleModel!.place}\n${ordersController.singleModel!.state} - ${ordersController.singleModel!.pin}\nPhone Number: ${ordersController.singleModel!.phone}')
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
