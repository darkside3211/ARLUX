import 'dart:convert';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalRepository {
  Future<void> cacheProducts(List<ProductModel> products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> productListJson =
        products.map((product) => jsonEncode(product.toJson())).toList();

    await prefs.setStringList('cached_products', productListJson);
  }

  Future<List<ProductModel>> getCachedProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? productListJson = prefs.getStringList('cached_products');

    if (productListJson != null) {
      return productListJson
          .map((productListJson) =>
              ProductModel.fromJson(jsonDecode(productListJson)))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future<void> cacheBag(List<CartModel> products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> productListJson =
        products.map((product) => jsonEncode(product.toJson())).toList();

    await prefs.setStringList('cached_bag', productListJson);
  }

  Future<List<CartModel>> getCachedBag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? productListJson = prefs.getStringList('cached_bag');

    if (productListJson != null) {
      return productListJson
          .map((productListJson) =>
              CartModel.fromJson(jsonDecode(productListJson)))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future<void> cacheOrder(List<OrderModel> orders) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> productListJson =
        orders.map((product) => jsonEncode(product.toJson())).toList();

    await prefs.setStringList('cached_order', productListJson);
  }

  Future<List<OrderModel>> getCachedOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? productListJson = prefs.getStringList('cached_order');

    if (productListJson != null) {
      return productListJson
          .map((productListJson) =>
              OrderModel.fromJson(jsonDecode(productListJson)))
          .toList();
    } else {
      return List.empty();
    }
  }
}
