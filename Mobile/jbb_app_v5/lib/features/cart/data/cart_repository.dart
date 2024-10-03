import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/products/data/product_local_repository.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_repository.g.dart';

class CartRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<bool> addToBag({
    required String productID,
    required String size,
    required int quantity,
    required String? token,
  }) async {
    try {
      final Response result = await dio.request(
        '/users/auth/cart',
        data: {
          "productId": productID,
          "quantity": quantity,
          "size": size,
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CartModel>> getBagItems({required String? token}) async {
    try {
      final Response result = await dio.request(
        "/users/auth/cart",
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

        List<CartModel> jewelries =
            json.map((item) => CartModel.fromJson(item)).toList();

        await ProductLocalRepository().cacheBag(jewelries);

        return jewelries;
      } else {
        ToastFailure(message: "failed to get cart items.");
        return ProductLocalRepository().getCachedBag();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editBagItem({
    required String cartID,
    required String newSize,
    required int newQuantity,
    required String? token,
  }) async {
    try {
      final Response result = await dio.request(
        '/users/auth/cart/',
        data: {
          'cartID': cartID,
          'quantity': newQuantity,
          'size': newSize,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "PUT",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> removeBagItems({
    required List<String> cartIDs,
    required String? token,
  }) async {
    try {
      final Response result = await dio.request(
        '/users/auth/cart',
        data: {'cartIDs': cartIDs},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "DELETE",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) {
  return CartRepository();
}

@riverpod
Future<bool> addToBag(
  AddToBagRef ref, {
  required String productID,
  required String size,
  required int quantity,
}) async {
  CartRepository cartRepository = ref.watch(cartRepositoryProvider);
  String? firebaseToken = await ref.watch(getFirebaseTokenProvider.future);

  bool result = await cartRepository.addToBag(
    productID: productID,
    size: size,
    quantity: quantity,
    token: firebaseToken,
  );

  if (result) {
    // ignore: unused_result
    ref.refresh(getBagItemsProvider);
  }

  return result;
}

@riverpod
Future<List<CartModel>> getBagItems(GetBagItemsRef ref) async {
  CartRepository cartRepository = ref.watch(cartRepositoryProvider);
  String? firebaseToken = await ref.watch(getFirebaseTokenProvider.future);

  final items = await cartRepository.getBagItems(token: firebaseToken);

  ref.read(bagItemCountProvider.notifier).state = items.length;

  return items;
}

@riverpod
Future<bool> removeBagItems(RemoveBagItemsRef ref,
    {required List<String> cartIDs}) async {
  CartRepository cartRepository = ref.watch(cartRepositoryProvider);
  String? firebaseToken = await ref.watch(getFirebaseTokenProvider.future);

  bool result = await cartRepository.removeBagItems(
    cartIDs: cartIDs,
    token: firebaseToken,
  );

  if (result) {
    // ignore: unused_result
    ref.refresh(getBagItemsProvider);
  }

  return result;
}

@riverpod
Future<bool> editBagItem(
  EditBagItemRef ref, {
  required String cartID,
  required String newSize,
  required int newQuantity,
}) async {
  CartRepository cartRepository = ref.watch(cartRepositoryProvider);
  String? firebaseToken = await ref.watch(getFirebaseTokenProvider.future);

  bool result = await cartRepository.editBagItem(
    cartID: cartID,
    newQuantity: newQuantity,
    newSize: newSize,
    token: firebaseToken,
  );

  if (result) {
    // ignore: unused_result
    ref.refresh(getBagItemsProvider);
  }

  return result;
}
