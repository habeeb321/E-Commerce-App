import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/order_screen/controller/order_controller.dart';

class OrderCanceldStatusWidget extends StatelessWidget {
  const OrderCanceldStatusWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = Get.put(OrdersController());
    return GetBuilder<OrdersController>(
      builder: (controller) {
        final canceledDate = ordersController.formatDate(
            ordersController.ordersList![index].cancelDate.toString());
        final orderedDate = ordersController.formatCancelDate(
            ordersController.ordersList![index].orderDate.toString());
        return Row(
          children: [
            SizedBox(
              height: 240,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 10,
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: kWhitecolor,
                    ),
                  ),
                  Container(
                    height: 65,
                    width: 3,
                    color: kWhitecolor,
                  ),
                  const CircleAvatar(
                    backgroundColor: kRedColor,
                    radius: 10,
                    child: Icon(
                      Icons.cancel,
                      size: 14,
                      color: kWhitecolor,
                    ),
                  ),
                ],
              ),
            ),
            kHeight20,
            SizedBox(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order confirmed'),
                      Text(orderedDate.toString(),
                          style: const TextStyle(fontSize: 12))
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order Canceled'),
                      Text(
                        canceledDate ?? '12',
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
