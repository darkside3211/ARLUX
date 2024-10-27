import 'package:flutter/material.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  const OrderList({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const IconedFailure(
          message: 'No orders available',
          displayIcon: Icon(Icons.remove_shopping_cart));
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return OrderTile(orderModel: order);
      },
    );
  }
}
