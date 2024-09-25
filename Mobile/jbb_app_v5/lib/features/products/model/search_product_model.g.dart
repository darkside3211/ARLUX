// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchProductModelImpl _$$SearchProductModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchProductModelImpl(
      results: (json['results'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchProductModelImplToJson(
        _$SearchProductModelImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
