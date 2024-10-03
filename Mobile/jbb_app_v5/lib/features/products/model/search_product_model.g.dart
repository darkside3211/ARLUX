// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductModel _$SearchProductModelFromJson(Map<String, dynamic> json) =>
    SearchProductModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      debug: ProductDebug.fromJson(json['debug'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchProductModelToJson(SearchProductModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'debug': instance.debug,
    };

ProductDebug _$ProductDebugFromJson(Map<String, dynamic> json) => ProductDebug(
      totalProducts: (json['totalProducts'] as num).toInt(),
      searchResultsLength: (json['searchResultsLength'] as num).toInt(),
    );

Map<String, dynamic> _$ProductDebugToJson(ProductDebug instance) =>
    <String, dynamic>{
      'totalProducts': instance.totalProducts,
      'searchResultsLength': instance.searchResultsLength,
    };
