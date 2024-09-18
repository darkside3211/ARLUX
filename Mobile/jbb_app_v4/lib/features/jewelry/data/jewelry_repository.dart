import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jbb_app_v4/core/network/network_core.dart';
import 'package:jbb_app_v4/features/jewelry/data/jewelry_local_repository.dart';
import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';
import 'package:jbb_app_v4/features/jewelry/models/search_jewelry_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jewelry_repository.g.dart';

class JewelryRepository {
  final Dio dio = DioInstance().getDioInstance();

  Future<List<JewelryModel>> fetchJewelryList() async {
    try {
      bool isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        List<JewelryModel> localJewelries =  await JewelryLocalRepository.getJewelries();
        return localJewelries;
      }

      final result =
          await dio.request('/products', options: Options(method: 'GET'));
      if (result.statusCode == 200) {
        await JewelryLocalRepository.clearJewelries();

        final json = result.data as List<dynamic>;

        List<JewelryModel> jewelries =
            json.map((item) => JewelryModel.fromJson(item)).toList();

        await JewelryLocalRepository.saveJewelries(jewelries);

        return jewelries;
      } else {
        List<JewelryModel> localJewelries =  await JewelryLocalRepository.getJewelries();
        return localJewelries;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return JewelryLocalRepository.getJewelries();
    }
  }

  Future<SearchJewelryModel> searchJewelryList({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      // Create a map to hold query parameters
      final Map<String, dynamic> params = {'q': q};

      // Add optional parameters to the map if they are not null
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

      final result = await dio.request('/products/search',
          queryParameters: params, options: Options(method: 'GET'));

      if (result.statusCode == 200) {
        final json = result.data as Map<String, dynamic>;
        final searchJewelryModel = SearchJewelryModel.fromJson(json);
        return searchJewelryModel;
      } else {
        throw Exception('Failed to fetch data: ${result.statusMessage}');
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<JewelryModel>> categorizeJewelryList(
      {required String category}) async {
    try {
      final result = await dio.request("/products/category",
          queryParameters: {"category": category},
          options: Options(method: "GET"));

      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;
        return json.map((item) => JewelryModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to fetch Category Jewelries");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return List.empty();
    }
  }
}

@riverpod
JewelryRepository jewelryRepository(JewelryRepositoryRef ref) {
  return JewelryRepository();
}

@riverpod
Future<List<JewelryModel>> fetchJewelryList(FetchJewelryListRef ref) async {
  final jewelryRepository = ref.watch(jewelryRepositoryProvider);
  return jewelryRepository.fetchJewelryList();
}

@riverpod
Future<SearchJewelryModel> searchJewelryList(
  SearchJewelryListRef ref, {
  required String q,
  String? category,
  double? minPrice,
  double? maxPrice,
}) async {
  final jewelryRepository = ref.watch(jewelryRepositoryProvider);
  return jewelryRepository.searchJewelryList(
    q: q,
    category: category,
    minPrice: minPrice,
    maxPrice: maxPrice,
  );
}

@riverpod
Future<List<JewelryModel>> categorizeJewelryList(CategorizeJewelryListRef ref,
    {required String category}) async {
  final jewelryRepository = ref.watch(jewelryRepositoryProvider);
  return jewelryRepository.categorizeJewelryList(category: category);
}
