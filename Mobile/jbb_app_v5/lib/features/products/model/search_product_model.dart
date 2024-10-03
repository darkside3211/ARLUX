import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_product_model.g.dart';

@JsonSerializable()
class SearchProductModel {
  final List<ProductModel> results;
  final ProductDebug debug;

  SearchProductModel({
    required this.results,
    required this.debug,
  });

  // Factory constructor to create a ProductModel from a JSON map
  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      _$SearchProductModelFromJson(json);

  // Method to convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() => _$SearchProductModelToJson(this);
}

@JsonSerializable()
class ProductDebug {
  final int totalProducts;
  final int searchResultsLength;

  ProductDebug(
      {required this.totalProducts, required this.searchResultsLength});

  // Factory constructor to create a ProductModel from a JSON map
  factory ProductDebug.fromJson(Map<String, dynamic> json) =>
      _$ProductDebugFromJson(json);

  // Method to convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() => _$ProductDebugToJson(this);
}
