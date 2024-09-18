// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_jewelry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchJewelryModelImpl _$$SearchJewelryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchJewelryModelImpl(
      results: (json['results'] as List<dynamic>)
          .map((e) => JewelryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      facets: SearchFacets.fromJson(json['facets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SearchJewelryModelImplToJson(
        _$SearchJewelryModelImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'facets': instance.facets,
    };

_$SearchFacetsImpl _$$SearchFacetsImplFromJson(Map<String, dynamic> json) =>
    _$SearchFacetsImpl(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceRange: (json['priceRange'] as List<dynamic>)
          .map((e) => PriceRangeFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchFacetsImplToJson(_$SearchFacetsImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'priceRange': instance.priceRange,
    };

_$CategoryFacetImpl _$$CategoryFacetImplFromJson(Map<String, dynamic> json) =>
    _$CategoryFacetImpl(
      count: (json['count'] as num).toInt(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$$CategoryFacetImplToJson(_$CategoryFacetImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'category': instance.category,
    };

_$PriceRangeFacetImpl _$$PriceRangeFacetImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceRangeFacetImpl(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$$PriceRangeFacetImplToJson(
        _$PriceRangeFacetImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
