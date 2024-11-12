import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/features/order/model/order_status_count.dart';

class OrderStatusCountNotifier extends StateNotifier<OrderStatusCount> {
  OrderStatusCountNotifier() : super(const OrderStatusCount());

  // Method to update counts based on orders
  void updateCounts(List<OrderModel> orders) {
    int toPayCount = 0;
    int toShipCount = 0;
    int toReceiveCount = 0;
    int toRateCount = 0;

    for (var order in orders) {
      switch (order.orderStatus) {
        case 'toPay':
          toPayCount++;
          break;
        case 'toShip':
          toShipCount++;
          break;
        case 'toReceive':
          toReceiveCount++;
          break;
        case 'Completed':
          toRateCount++;
          break;
      }
    }

    // Update state with new counts
    state = state.copyWith(
      totalOrders: orders.length,
      toPay: toPayCount,
      toShip: toShipCount,
      toReceive: toReceiveCount,
      toRate: toRateCount,
    );
  }
}
