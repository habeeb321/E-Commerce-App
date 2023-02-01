import 'package:scotch/view/screens/order_screen/model/order_enum.dart';

class CarttoOrderScreenArguementModel {
  final OrderScreenEnum screenCheck;
  final String? cartId;
  final String? productId;

  CarttoOrderScreenArguementModel({
    required this.screenCheck,
    this.cartId,
    this.productId,
  });
}
