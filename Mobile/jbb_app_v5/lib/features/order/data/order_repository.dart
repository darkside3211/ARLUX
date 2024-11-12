import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<String?> checkoutOrder({
    required List<CheckoutItem> jewelryItems,
    required AddressModel address,
    required String? token,
  }) async {
    try {
      final Response result = await dio.request(
        '/users/auth/checkout',
        data: {
          "address": address.toPayMongoJson(),
          "jewelryItems": jewelryItems,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "POST",
        ),
      );

      if (result.statusCode == 200) {
        final json = result.data;
        return json["checkoutURL"];
      }
    } catch (e) {
      ToastFailure(message: e.toString());
    }
    return null;
  }

  Future<List<OrderModel>> getOrders({required String? token}) async {
    try {
      final Response result = await dio.request(
        "/users/auth/orders",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "GET",
        ),
      );

      if (result.statusCode == 200) {
        final List<dynamic> json = result.data;

        return json.map((order) => OrderModel.fromJson(order)).toList();
      } else {
        throw Exception("Failed to fetch orders.");
      }
    } catch (e) {
      ToastFailure(message: "Failed to fetch user orders.");
      throw Exception(e.toString());
    }
  }
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository();
}

@riverpod
Future<String?> checkoutOrder(
  CheckoutOrderRef ref, {
  required List<CheckoutItem> orders,
  required AddressModel address,
}) async {
  final OrderRepository orderRepository = ref.watch(orderRepositoryProvider);
  final String? firebaseToken =
      await ref.watch(getFirebaseTokenProvider.future);

  final order = await orderRepository.checkoutOrder(
      address: address, jewelryItems: orders, token: firebaseToken);

  if (order != null) {
    // ignore: unused_result
    ref.refresh(getOrdersProvider);
  }
  return order;
}

@riverpod
Future<List<OrderModel>> getOrders(GetOrdersRef ref) async {
  final OrderRepository orderRepository = ref.watch(orderRepositoryProvider);
  final String? firebaseToken =
      await ref.watch(getFirebaseTokenProvider.future);

  final items = await orderRepository.getOrders(token: firebaseToken);

  ref.read(orderStatusCountProvider.notifier).updateCounts(items);

  return items;
}
