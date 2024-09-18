import 'package:dio/dio.dart';
import 'package:jbb_app_v2/core/errors/exceptions.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
Future<List<ProductModel>> getProductList(
  GetProductListRef ref, {
  String? sorted,
  int? limited,
  String? category,
}) async {
  final dio = Dio();
  final dynamic response;
  if (category != null) {
    response = await dio.get(
        'https://fakestoreapi.com/products/category/$category',
        queryParameters: {
          'limit': limited,
          'sort': sorted,
        });
  } else {
    response =
        await dio.get('https://fakestoreapi.com/products/', queryParameters: {
      'limit': limited,
      'sort': sorted,
    });
  }

  if (response.statusCode == 200) {
    final json = response.data as List<dynamic>;
    return json.map((item) => ProductModel.fromJson(item)).toList();
  } else {
    throw ServerException(message: 'Failed to load products.');
  }
}

@riverpod
Future<List<dynamic>> getCategoryList(GetCategoryListRef ref) async {
  final dio = Dio();
  final response =
      await dio.get('https://fakestoreapi.com/products/categories');

  if (response.statusCode == 200) {
    final json = response.data as List<dynamic>;
    return json;
  } else {
    throw ServerException(message: 'Failed to load list of categories.');
  }
}

// @riverpod
// Future<ProductModel> getSingleProduct(
//   GetSingleProductRef ref, {
//   required int id,
// }) async {
//   final dio = Dio();
//   final response = await dio.get('https://fakestoreapi.com/products/$id');

//   if (response.statusCode == 200) {
//     final json = response.data as Map<String, dynamic>;
//     return ProductModel.fromJson(json);
//   } else {
//     throw ServerException(message: 'Failed to load single product.');
//   }
// }
