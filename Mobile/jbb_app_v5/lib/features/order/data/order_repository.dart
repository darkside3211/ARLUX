import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/features/products/data/product_local_repository.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<void> checkoutOrder(
      {required List<CheckoutItem> jewelryItems, required String? token}) async {
    try {
      final Response result = await dio.request(
        '/users/auth/checkout',
        data: {
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
        LaunchCheckout(checkoutUrl: json["checkoutURL"]!);
      }
    } catch (e) {
      ToastFailure(message: e.toString());
    }
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
        final json = result.data as List<dynamic>;

        List<OrderModel> jewelries =
            json.map((item) => OrderModel.fromJson(item)).toList();

        await ProductLocalRepository().cacheOrder(jewelries);

        return jewelries;
      } else {
        ToastFailure(message: "failed to get order items.");
        return ProductLocalRepository().getCachedOrders();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository();
}

@riverpod
Future<void> checkoutOrder(CheckoutOrderRef ref,
    {required List<CheckoutItem> orders}) async {
  final OrderRepository orderRepository = ref.watch(orderRepositoryProvider);
  final String? firebaseToken =
      await ref.watch(getFirebaseTokenProvider.future);

  await orderRepository.checkoutOrder(
      jewelryItems: orders, token: firebaseToken);

  // ignore: unused_result
  ref.refresh(getOrdersProvider);
}

@riverpod
Future<List<OrderModel>> getOrders(GetOrdersRef ref) async {
  final OrderRepository orderRepository = ref.watch(orderRepositoryProvider);
  final String? firebaseToken =
      await ref.watch(getFirebaseTokenProvider.future);

  final items = await orderRepository.getOrders(token: firebaseToken);

  ref.read(ordersItemCountProvider.notifier).state = items.length;

  return items;
}
