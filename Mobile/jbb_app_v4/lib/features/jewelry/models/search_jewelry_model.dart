import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';

part 'search_jewelry_model.freezed.dart';
part 'search_jewelry_model.g.dart';

@freezed
class SearchJewelryModel with _$SearchJewelryModel {
  factory SearchJewelryModel({
    required List<JewelryModel> results,
    required int page,
    required int totalPages,
    required int totalCount,
    required SearchFacets facets,
  }) = _SearchJewelryModel;

  factory SearchJewelryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchJewelryModelFromJson(json);
}

@freezed
class SearchFacets with _$SearchFacets {
  factory SearchFacets({
    required List<CategoryFacet> categories,
    required List<PriceRangeFacet> priceRange,
  }) = _SearchFacets;

  factory SearchFacets.fromJson(Map<String, dynamic> json) =>
      _$SearchFacetsFromJson(json);
}

@freezed
class CategoryFacet with _$CategoryFacet {
  factory CategoryFacet({
    required int count,
    required String category,
  }) = _CategoryFacet;

  factory CategoryFacet.fromJson(Map<String, dynamic> json) =>
      _$CategoryFacetFromJson(json);
}

@freezed
class PriceRangeFacet with _$PriceRangeFacet {
  factory PriceRangeFacet({
    required double min,
    required double max,
  }) = _PriceRangeFacet;

  factory PriceRangeFacet.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFacetFromJson(json);
}
