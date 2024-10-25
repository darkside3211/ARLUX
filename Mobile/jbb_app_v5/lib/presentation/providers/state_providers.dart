import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/features/order/data/order_status_notifier.dart';
import 'package:jbb_app_v5/features/order/model/order_status_count.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
final selectedProductIdProvider = StateProvider<String>((ref) => '');
final bagItemCountProvider = StateProvider<int>((ref) => 0);

final orderStatusCountProvider =
    StateNotifierProvider<OrderStatusCountNotifier, OrderStatusCount>(
        (ref) => OrderStatusCountNotifier());

final defaultAddressProvider = StateProvider<AddressModel?>((ref) => null);
