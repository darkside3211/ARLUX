import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/features/products/model/search_product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_remote_repository.g.dart';

class ProductRemoteRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<List<ProductModel>> fetchProductList() async {
    try {
      final result =
          await dio.request('/products', options: Options(method: 'GET'));
      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;

        List<ProductModel> jewelries =
            json.map((item) => ProductModel.fromJson(item)).toList();

        return jewelries;
      } else {
        return List.empty();
      }
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<SearchProductModel> searchProductList({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final Map<String, dynamic> params = {'q': q};

      if (category != null) {
        params['category'] = category;
      }

      // Add minPrice and maxPrice separately to handle cases where one is null
      if (minPrice != null) {
        params['minPrice'] = minPrice;
      }

      if (maxPrice != null) {
        params['maxPrice'] = maxPrice;
      }

      final result = await dio.request(
        '/products/search',
        queryParameters: params,
        options: Options(method: 'GET'),
      );

      if (result.statusCode == 200) {
        final json = result.data as Map<String, dynamic>;
        final searchProductModel = SearchProductModel.fromJson(json);
        return searchProductModel;
      } else {
        throw Exception('Failed to fetch data: ${result.statusMessage}');
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> categorizeProductList(
      {required String category}) async {
    try {
      final result = await dio.request("/products/category",
          queryParameters: {"category": category},
          options: Options(method: "GET"));

      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;
        return json.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to fetch Category Jewelries");
      }
    } catch (e) {
      return List.empty();
    }
  }
}

@riverpod
ProductRemoteRepository productRemoteRepository(
    ProductRemoteRepositoryRef ref) {
  return ProductRemoteRepository();
}

@riverpod
Future<List<ProductModel>> fetchProductList(FetchProductListRef ref) async {
  final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);
  return productRemoteRepository.fetchProductList();
}

@riverpod
Future<SearchProductModel> searchProductList(
  SearchProductListRef ref, {
  required String q,
  String? category,
  double? minPrice,
  double? maxPrice,
}) async {
  final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);
  return productRemoteRepository.searchProductList(
    q: q,
    category: category,
    minPrice: minPrice,
    maxPrice: maxPrice,
  );
}

@riverpod
Future<List<ProductModel>> categorizeProductList(
  CategorizeProductListRef ref, {
  required String category,
}) async {
  final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);
  
  return productRemoteRepository.categorizeProductList(category: category);
}
