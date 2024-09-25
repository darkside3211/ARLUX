import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';
part 'product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    required String id,
    required String name,
    required double price,
    required String description,
    required String lensID,
    required String groupID,
    required String category,
    required double averageRating,
    required List<String> imageUrls,
    required String modelUrl,
    int? quantity,
    String? size,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
