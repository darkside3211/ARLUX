import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/features/order/data/order_status_notifier.dart';
import 'package:jbb_app_v5/features/order/model/order_status_count.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
final orderTabIndexProvider = StateProvider<int>((ref) => 0);


final selectedProductProvider = StateProvider<ProductModel?>((ref) => null);
final bagItemCountProvider = StateProvider<int>((ref) => 0);

final orderStatusCountProvider =
    StateNotifierProvider<OrderStatusCountNotifier, OrderStatusCount>((ref) {
  ref.read(getOrdersProvider);
  return OrderStatusCountNotifier();
});

final defaultAddressProvider = StateProvider<AddressModel?>((ref) => null);
