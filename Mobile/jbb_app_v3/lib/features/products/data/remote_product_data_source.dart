import 'package:flutter/foundation.dart';
import 'package:jbb_app_v3/configs/network_config.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'remote_product_data_source.g.dart';

@riverpod
class RemoteProductDataSource extends _$RemoteProductDataSource {
  final Dio dio = DioInstance().getDioInstance();

  @override
  Future<List<ProductModel>> build() async {
    try {
      final response = await dio.request(
        '/products',
        options: Options(method: 'GET'),
      );

      if (response.statusCode == 200) {
        final json = response.data as List<dynamic>;
        return json.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return List.empty();
    }
  }
}
