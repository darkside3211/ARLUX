import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/features/products/model/search_product_model.dart';
import 'package:jbb_app_v5/features/search/data/search_history_repository.dart';
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
            json.map((item) => ProductModel.fromJson(item)).where((product) => product.stockCount > 0).toList();

        return jewelries;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
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

      if (category != null && category != "All") {
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

  Future<ProductModel?> getSingleProduct({required String productId}) async {
    try {
      final result = await dio.request("/products/$productId",
          options: Options(method: "GET"));

      if (result.statusCode == 200) {
        final json = result.data;
        return ProductModel.fromJson(json);
      } else {
        throw Exception("Failed to fetch Category Jewelries");
      }
    } catch (e) {
      return null;
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
  final SearchProductModel searchResults =
      await productRemoteRepository.searchProductList(
    q: q,
    category: category,
    minPrice: minPrice,
    maxPrice: maxPrice,
  );

  // ignore: unused_result
  ref.refresh(getSearchHistoryProvider);

  return searchResults;
}

@riverpod
Future<List<ProductModel>> categorizeProductList(
  CategorizeProductListRef ref, {
  required String category,
}) async {
  final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);

  return productRemoteRepository.categorizeProductList(category: category);
}

@riverpod
Future<ProductModel?> getSingleProduct(GetSingleProductRef ref,
    {required String productId}) async {
  final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);
  
  return productRemoteRepository.getSingleProduct(productId: productId);
}
