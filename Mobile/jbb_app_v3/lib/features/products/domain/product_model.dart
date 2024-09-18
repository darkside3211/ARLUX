import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    required String id,
    required String name,
    required double price,
    required String description,
    required String imageUrl,
    required double averageRating,
    String? lensID,
    String? groupID,
    required String category,
    String? modelUrl,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
