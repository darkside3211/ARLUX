import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_product_model.g.dart';
part 'search_product_model.freezed.dart';

@freezed
class SearchProductModel with _$SearchProductModel {
  factory SearchProductModel({
    required List<ProductModel> results,
    
  }) = _SearchProductModel;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      _$SearchProductModelFromJson(json);
}
